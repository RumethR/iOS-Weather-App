//
//  HourWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct HourWeatherView: View {
    var current: Current

    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithDay(from: TimeInterval(current.dt))
        let hourlyForecast = current.weather.first?.weatherDescription.rawValue.capitalized ?? "N/A"
        
        VStack(spacing: 5) {
            Text(formattedDate)
                .font(.body)

                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)

            Text("\((Double)(current.temp), specifier: "%.0f") ºC") //Converting using Int() will round down the value
                 .font(.body)
                 .padding(.horizontal)
                 .background(Color.white)
                 .foregroundColor(.black)

             Text(hourlyForecast)
                 .font(.body)
                 .padding(.horizontal)
                 .background(Color.white)
                 .foregroundColor(.black)
        }
        
    }
}




