//
//  DailyWeatherView.swift
//  CWK2Template
//
//  Created by girish lukka on 02/11/2023.
//

import SwiftUI

struct DailyWeatherView: View {
    var day: Daily
    var iconPath: URL
    
    var body: some View {
        let formattedDate = DateFormatterUtils.formattedDateWithWeekdayAndDay(from: TimeInterval(day.dt))
        let dailyForecast = day.weather.first?.weatherDescription.rawValue.capitalized ?? "N/A"

        HStack (spacing: .zero) {
            AsyncImage(url: iconPath) { image in
                image
                    .resizable()
                    
            } placeholder: {
                ProgressView()
            }
            .frame(width: 60, height: 60)
            
            Spacer()
            
            VStack {
                Text(dailyForecast)
                    .font(.body) // Customize the font if needed
                
                Text(formattedDate)
                    .font(.body) // Customize the font if needed
            }
            
            Spacer()
            
            Text("\((Double)(day.temp.max), specifier: "%.0f")ºC / \((Double)(day.temp.min), specifier: "%.0f")ºC")
        }
    }
}

//struct DailyWeatherView_Previews: PreviewProvider {
//    static var day = WeatherMapViewModel().weatherDataModel!.daily
//    static var previews: some View {
//        DailyWeatherView(day: day[0])
//    }
//}
