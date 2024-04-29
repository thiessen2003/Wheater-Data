//
//  WeatherData.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/11/24.
//

import Foundation
import CoreData

@objc(WeatherRecordData)
public class WeatherRecordData: NSManagedObject {
    @NSManaged public var time: [String]?
    @NSManaged public var temperature: Double
    @NSManaged public var precipitationProbability: [Int]?
    @NSManaged public var precipitation: Double
    @NSManaged public var city: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var timestamp: Date?


}
