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
            HStack{
                Text("Change Location")

                TextField("Enter New Location", text: $temporaryCity)
                    .onSubmit {
                        weatherMapViewModel.city = temporaryCity
                        Task {
                            do {
                                try await weatherMapViewModel.getCoordinatesForCity(city: temporaryCity)
                                
                                try await weatherMapViewModel.loadData(lat: weatherMapViewModel.coordinates!.latitude, lon: weatherMapViewModel.coordinates!.longitude)
                                
                                weatherMapViewModel.loadLocationsFromJSONFile()
                                temporaryCity = ""
                                // write code to process user change of location
                            } catch {
                                print("Error while parsing entered location: \(error)")
                                temporaryCity = ""
                                isLoading = false
                                showAlert = true
                            }
                        }
                    }
            }
            .bold()
            .font(.system(size: 20))
            .padding(10)
            .shadow(color: .blue, radius: 10)
            .cornerRadius(10)
            .fixedSize()
            .font(.custom("Arial", size: 26))
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .cornerRadius(15)
            VStack{
                HStack{
                    Text("Current Location: \(weatherMapViewModel.city)")
                }
                .bold()
                .font(.system(size: 20))
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Arial", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                let timestamp = TimeInterval(weatherMapViewModel.weatherDataModel?.current.dt ?? 0)
                let formattedDate = DateFormatterUtils.formattedDateTime(from: timestamp)
                Text(formattedDate)
                    .padding()
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 1) 

                HStack{
                    // Weather Temperature Value
                    if let forecast = weatherMapViewModel.weatherDataModel, weatherMapViewModel.city != "Invalid City" {
                        Text("Temp: \((Double)(forecast.current.temp), specifier: "%.2f") ºC")
                            .font(.system(size: 25, weight: .medium))
                    } else {
                        ProgressView()
                    }
                }
               
            }//VS2
        } //VS1
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
        }
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
