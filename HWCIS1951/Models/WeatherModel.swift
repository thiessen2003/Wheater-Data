//
//  WeatherModel.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/10/24.
//

import Foundation

struct Location: Identifiable, Decodable, Hashable {
    let lat: String
    let lon: String
    let name: String
    let displayName: String
    var id: String { "\(lat),\(lon)" }

    enum CodingKeys: String, CodingKey {
        case lat, lon, name, displayName = "display_name"
    }
}


struct WeatherInfo: Identifiable, Decodable, Equatable, Hashable {
    var id = UUID()
    
    let timestamp = "\(Date())"
    let data: WeatherData

    enum CodingKeys: String, CodingKey {
        case data = "hourly"
    }
}

struct WeatherData: Decodable, Equatable, Hashable {
    let time: [String]
    let temperature: [Double]
    let precipitation_probability: [Int]
    let precipitation: [Double]

    enum CodingKeys: String, CodingKey {
        case time
        case temperature = "temperature_2m"
        case precipitation_probability = "precipitation_probability"
        case precipitation
    }
}

struct HourlyUnits: Decodable, Equatable, Hashable {
    let temperature_2m: String
    let precipitation_probability: String
    let precipitation: String
}
