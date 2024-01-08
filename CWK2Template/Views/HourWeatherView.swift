//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    var current: Current
    var iconPath: URL
    
    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
        let hourlyForecast = current.weather.first?.weatherDescription.rawValue.capitalized ?? "N/A"
        
        VStack(spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .padding(.horizontal)
            
            AsyncImage(url: iconPath) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)

            Text("\((Double)(current.temp), specifier: "%.0f") ºC") //Converting using Int() will round down the value
                 .font(.body)
                 .padding(.horizontal)


             Text(hourlyForecast)
                 .font(.body)
                 .padding(.horizontal)
        }
        .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
        .background(Color.cyan.opacity(0.3))
        .cornerRadius(10)
        
    }
}




