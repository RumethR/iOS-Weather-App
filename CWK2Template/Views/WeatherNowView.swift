//
//  WeatherNowView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherNowView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    @State private var isLoading = false
    @State private var temporaryCity = ""
    @State private var showAlert: Bool = false
    var body: some View {

        VStack{
            HStack {
                TextField("Enter a city to get weather data", text: $temporaryCity)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    .shadow(color: .gray, radius: 4)
                    .onSubmit {
                        weatherMapViewModel.city = temporaryCity
                        Task {
                            do {
                                try await weatherMapViewModel.getCoordinatesForCity(city: temporaryCity)
                                
                                // No need of any default values, application throws an error if geocoding fails
                                try await weatherMapViewModel.loadData(lat: weatherMapViewModel.coordinates!.latitude, lon: weatherMapViewModel.coordinates!.longitude)
                                
                                weatherMapViewModel.loadLocationsFromJSONFile()
                                temporaryCity = ""
                            } catch {
                                print("Error while parsing entered location: \(error)")
                                temporaryCity = ""
                                isLoading = false
                                showAlert = true
                            }
                        }
                    }
                Image(systemName: "house.fill")
                    .font(.system(size: 20))
                    .padding(.trailing, 8)
                    .onTapGesture {
                        //Save the current city using AppStorage
                        weatherMapViewModel.saveDeaultLocation()
                    }
            }
                        
            let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
            let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp)
            Text(formattedDate)
                .padding(.top)
                .font(.body)
            
            Text("Current Location: \(weatherMapViewModel.city)")
                .font(.headline)
                .bold()
            
            if let weatherData = weatherMapViewModel.weatherDataModel {
                // Force Unwrapping because we can assure that weatherDataModel will always contain a weather obj
                AsyncImage(url: weatherMapViewModel.weatherIconURL(iconCode: weatherData.current.weather.first!.icon)) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 180, height: 180)
                
                Text("\((Double)(weatherData.current.temp), specifier: "%.0f") ºC")
                    .font(.title)
                    .bold()
                
                Text("\(weatherData.current.weather.first!.weatherDescription.rawValue.capitalized)")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                List {
                    HStack {
                        Image("humidity")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)

                        Text("Humidity")
                            .font(.headline)
                            .padding(.horizontal)

                        Text("\(weatherData.current.humidity)")
                            .font(.headline)
                        
                    }
                    .padding()
                    .listRowBackground(Color.gray.opacity(0.01))
                    
                    HStack {
                        Image("pressure")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)

                        Text("Pressure")
                            .font(.headline)
                            .padding(.horizontal)

                        Text("\(weatherData.current.pressure)")
                            .font(.headline)
                        
                    }
                    .padding()
                    .listRowBackground(Color.gray.opacity(0.01))

                    HStack {
                        Image("windSpeed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)

                        Text("Wind Speed")
                            .font(.headline)
                            .padding(.horizontal)

                        Text("\((Double)(weatherData.current.windSpeed), specifier: "%.2f")")
                            .font(.headline)
                        
                    }
                    .padding()
                    .listRowBackground(Color.gray.opacity(0.01))

                }
                .listStyle(.plain)
                .padding(.top)
            } else {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .padding()//VS1
        .background(
            Image("background2")
            .resizable()
            .scaledToFill()
            .opacity(0.4)
            .ignoresSafeArea()
        )
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Geocoding Error"), message: Text("Couldn't find the city provided"), dismissButton: .default(Text("Okay")))
        }
    }
}

struct WeatherNowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherNowView()
    }
}
