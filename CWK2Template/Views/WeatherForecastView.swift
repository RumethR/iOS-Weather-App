//
//  WeatherForcastView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import SwiftUI

struct WeatherForecastView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading, spacing: 16) {
                    Text("48 Hour Forecast")
                        .bold()
                        .font(.title2)
                        .padding(.top)
                        .padding(.leading)
                    
                    if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {
                        ScrollView(.horizontal, showsIndicators: true) {

                            HStack(spacing: 10) {
                                ForEach(hourlyData) { hour in
                                    //Access the necessary icon from the hour value and make api request
                                    let iconURL = weatherMapViewModel.weatherIconURL(iconCode: hour.weather.first?.icon ?? "")
                                    HourWeatherView(current: hour, iconPath: iconURL)
                                }
                            }
                        }
                        .frame(height: 180)
                        .padding(.leading)
                    }
                    Divider()
                        .padding(.horizontal, 16)
                    VStack {
                        Text("8 Day Weather Forecast")
                            .bold()
                            .font(.title2)
                            .padding()
                        List {
                            ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                                let iconURL = weatherMapViewModel.weatherIconURL(iconCode: day.weather.first?.icon ?? "")
                                DailyWeatherView(day: day, iconPath: iconURL)
                                    .listRowBackground(Color.gray.opacity(0.01))
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: 500)
                        // .opacity(0.2)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
                Color.gray.opacity(0.2)
                    .ignoresSafeArea()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "sun.min.fill")
                        Text("Weather Forecast for \(weatherMapViewModel.city)").font(.title3)
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct WeatherForcastView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherForecastView()
    }
}
