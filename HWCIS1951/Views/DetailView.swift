//
//  DetailView.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/10/24.
//

import SwiftUI
import Foundation


struct WeatherDetailView: View {
    var location: Location  // Assuming this is passed from the previous screen
    var weatherInfo: WeatherInfo  // Assuming this is fetched based on the location
    @ObservedObject var viewModel: WeatherViewModel


    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weather Details for \(location.name)")
                .font(.title2)
                .fontWeight(.semibold)
            HStack {
                            Text("Temperature: ")
                            // Assuming the temperature is stored in a similar way to precipitation
                            Text("\(weatherInfo.data.temperature.first ?? 0, specifier: "%.1f") °C")
                                .fontWeight(.bold)
                        }
            HStack {
                Text("Precipitation: ")
                Text("\(weatherInfo.data.precipitation.first ?? 0, specifier: "%.2f") mm")
                    .fontWeight(.bold)
            }

            HStack {
                Text("Precipitation Probability: ")
                Text("\(weatherInfo.data.precipitation_probability.first ?? 0)%")
                    .fontWeight(.bold)
            }

            // Buttons for favoriting and saving results
            HStack {
                Button(action: {
                    viewModel.saveWeatherData(weatherInfo, forLocation: location)
                }) {
                    Label("Save Results", systemImage: "tray.and.arrow.down")
                }
                .buttonStyle(BorderlessButtonStyle())
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Weather Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    WeatherDetailView(
           location: Location(lat: "37.7749", lon: "-122.4194", name: "San Francisco", displayName: "San Francisco, TX"),
           weatherInfo: WeatherInfo(data: WeatherData(time: ["2023-04-10T12:00"], temperature: [20.0], precipitation_probability: [30], precipitation: [2.5])),
           viewModel: WeatherViewModel()
       )
}
