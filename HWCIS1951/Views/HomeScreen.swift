//
//  HomeScreen.swift
//  AppWeatherDataHW4
//
//  Created by Gabriel Thiessen on 4/10/24.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var city: String = ""
    @State private var state: String = ""
    @State private var showDetailView = false
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        NavigationSplitView {
                    List {
                        Section(header: Text("Saved Locations")) {
                            ForEach(viewModel.fetchSavedLocations(), id: \.self) { location in
                                NavigationLink(destination: WeatherDetailView(location: location, weatherInfo: WeatherInfo(data: WeatherData(time: [], temperature: [], precipitation_probability: [], precipitation: [])), viewModel: viewModel)) {
                                    Text(location.displayName)
                                }
                            }
                        }
                        
                        Section(header: Text("Previous Results")) {
                            NavigationLink(destination: PreviousResultsView(viewModel: viewModel)) {
                                Text("View Previous Results")
                            }
                        }
                    }
                    .listStyle(SidebarListStyle())
        } detail: {
            VStack(spacing: 20) {
                Text("Welcome to the Weather App")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Enter a city and country to get started.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField("City", text: $city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("State", text: $state)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button("Get Weather") {
                    viewModel.fetchWeather(forCity: city, inState: state)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
                
                if viewModel.isLoading {
                    ProgressView()
                }
                
                NavigationLink(
                    destination: WeatherDetailView(location: viewModel.location ?? Location(lat: "", lon: "", name: "", displayName: ""), weatherInfo: viewModel.weatherInfo ?? WeatherInfo(data: WeatherData(time: [], temperature: [], precipitation_probability: [], precipitation: [])), viewModel: viewModel),
                    isActive: $showDetailView,
                    label: { EmptyView() }
                )
                .hidden()
                
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
        }
        .onChange(of: viewModel.weatherInfo) { _ in
            showDetailView = viewModel.weatherInfo != nil
        }
    }
}
#Preview {
    HomeScreenView()
}

