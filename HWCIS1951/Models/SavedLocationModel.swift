//
//  SavedLocationModel.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/11/24.
//

import Foundation
import CoreData

extension SavedLocation {
    func addToWeatherRecords(_ value: WeatherRecord) {
        let records = mutableSetValue(forKey: "weatherRecords")
        records.add(value)
    }
}
