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
                    if let hourlyData = weatherMapViewModel.weatherDataModel?.hourly {

                        ScrollView(.horizontal, showsIndicators: false) {

                            HStack(spacing: 10) {
                                ForEach(hourlyData) { hour in
                                    //Access the necessary icon from the hour value and make an api request
                                    let iconURL = weatherMapViewModel.weatherIconURL(iconCode: hour.weather.first?.icon ?? "")
                                    HourWeatherView(current: hour, iconPath: iconURL)
                                }
                            }
                        }
                        .frame(height: 180)
                    }
                    Divider()
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    VStack(alignment: .listRowSeparatorLeading) { 
                        List {
                            ForEach(weatherMapViewModel.weatherDataModel?.daily ?? []) { day in
                                let iconURL = weatherMapViewModel.weatherIconURL(iconCode: day.weather.first?.icon ?? "")
                                DailyWeatherView(day: day, iconPath: iconURL)
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: 500)
                        // .opacity(0.2)
                    }
                }
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
