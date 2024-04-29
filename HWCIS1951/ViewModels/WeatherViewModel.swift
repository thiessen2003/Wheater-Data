//
//  WeatherViewModel.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/10/24.
//
import Foundation
import CoreData

class WeatherViewModel: ObservableObject {
    @Published var location: Location?
        @Published var weatherInfo: WeatherInfo?
        @Published var isLoading: Bool = false
    
    
        
        func fetchWeather(forCity city: String, inState state: String) {
            isLoading = true
            
            Task {
                do {
                    let location = try await APIManager.shared.fetchLocation(city: city, state: state)
                    let weather = try await APIManager.shared.fetchWeather(for: location.lat, longitude: location.lon)
                    
                    // Update the state on the main thread
                    await MainActor.run {
                        self.location = location
                        self.weatherInfo = weather
                        self.isLoading = false
                    }
                    
                    print("Weather data fetched successfully for \(city), \(state).")
                } catch {
                    await MainActor.run {
                        self.isLoading = false
                    }
                    
                    print("Failed to fetch weather data for \(city), \(state): \(error)")
                }
            }
        }
    func fetchSavedLocations() -> [Location] {
            let context = PersistenceController.shared.container.viewContext
            
            let fetchRequest: NSFetchRequest<SavedLocation> = SavedLocation.fetchRequest()
            
            do {
                let savedLocations = try context.fetch(fetchRequest)
                let locations = savedLocations.map { savedLocation -> Location in
                    return Location(lat: savedLocation.lat ?? "",
                                    lon: savedLocation.lon ?? "",
                                    name: savedLocation.name ?? "",
                                    displayName: savedLocation.displayName ?? "")
                }
                return locations
            } catch {
                print("Failed to fetch saved locations: \(error)")
                return []
            }
        }
    func saveWeatherData(_ weather: WeatherInfo, forLocation location: Location) {
        let context = PersistenceController.shared.container.viewContext
        
        let weatherRecord = WeatherRecord(context: context)
        weatherRecord.city = location.displayName
        weatherRecord.temperature = weather.data.temperature.first ?? 0.0
        weatherRecord.precipitation = weather.data.precipitation.first ?? 0.0
        weatherRecord.timestamp = Date()
        
        do {
            try context.save()
            print("Weather data saved successfully.")
        } catch {
            print("Failed to save weather data: \(error)")
        }
    }
    
    func fetchSavedWeatherData() -> [WeatherRecord] {
        let context = PersistenceController.shared.container.viewContext
        
        let fetchRequest: NSFetchRequest<WeatherRecord> = WeatherRecord.fetchRequest()
        // Add any predicates or sorting if needed
        
        do {
            let savedData = try context.fetch(fetchRequest)
            return savedData
        } catch {
            print("Failed to fetch saved weather data: \(error)")
            return []
        }
    }
    }
