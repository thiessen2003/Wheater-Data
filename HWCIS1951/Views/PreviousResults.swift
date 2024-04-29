//
//  PreviousResults.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/11/24.
//
import SwiftUI

struct PreviousResultsView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        List(viewModel.fetchSavedWeatherData(), id: \.self) { weatherRecord in
            HStack {
                VStack(alignment: .leading) {
                    Text(weatherRecord.city ?? "")
                        .font(.headline)
                    Text(weatherRecord.timestamp ?? Date(), style: .date)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Text("\(weatherRecord.temperature, specifier: "%.1f")°C")
                    .font(.title2)
            }
        }
        .navigationTitle("Previous Results")
    }
}
