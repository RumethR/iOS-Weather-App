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
        let weatherDescription = current.weather[0].weatherDescription
        VStack(alignment: .leading, spacing: 5) {
            Text(formattedDate)
                .font(.body)
                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)

            Text("This is where the icon should go")
                .frame(width: 125)
                .font(.body)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)
            
            Text("\((Double)(current.temp), specifier: "%.0f") ºC")
                .font(.body)
                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)
            
            Text(weatherDescription.rawValue.capitalized)
                .font(.body)
                .padding(.horizontal)
                .background(Color.white)
                .foregroundColor(.black)
            
        }
        
    }
}




