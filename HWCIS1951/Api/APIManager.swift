//
//  NetworkManager.swift
//  WeatherAppData
//
//  Created by Gabriel Thiessen on 4/10/24.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    
    let geocodingBaseURL = "https://nominatim.openstreetmap.org/search"
    let weatherBaseURL = "https://api.open-meteo.com/v1/forecast"
    
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse(URLResponse?)
        case decodingError(Error)
        case noData
    }
    
    func fetchLocation(city: String, state: String?) async throws -> Location {
        // URL encode city and state
        let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "".lowercased()
        
        var queryItems = [
            URLQueryItem(name: "q", value: encodedCity),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "limit", value: "1")
        ]

        
        var components = URLComponents(string: geocodingBaseURL)!
        components.queryItems = queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        try validateResponse(response)
        
        guard let location = try? JSONDecoder().decode([Location].self, from: data).first else {
            throw NetworkError.noData
        }
        
        return location
    }
    
    func fetchWeather(for latitude: String, longitude: String) async throws -> WeatherInfo {
        var components = URLComponents(string: weatherBaseURL)!
        components.queryItems = [
            URLQueryItem(name: "latitude", value: latitude),
            URLQueryItem(name: "longitude", value: longitude),
            URLQueryItem(name: "timezone", value: "auto"),
            URLQueryItem(name: "hourly", value: "temperature_2m,precipitation_probability,precipitation"),
            URLQueryItem(name: "temperature_unit", value: "fahrenheit"),
            URLQueryItem(name: "forecast_days", value: "1")
        ]
        print(components)

        guard let url = components.url else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        print(data)
        print(response)
        try validateResponse(response)
        return try JSONDecoder().decode(WeatherInfo.self, from: data)
    }
    
    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse(response)
        }
    }
}
