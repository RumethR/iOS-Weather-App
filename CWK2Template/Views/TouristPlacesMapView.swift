//
//  TouristPlacesMapView.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

struct TouristPlacesMapView: View {
    @EnvironmentObject var weatherMapViewModel: WeatherMapViewModel
    var body: some View {
        NavigationStack {
            VStack {
                if weatherMapViewModel.coordinates != nil {
                    if let currentlocation = weatherMapViewModel.region{
                        VStack {
                            Map(coordinateRegion: .constant(currentlocation), annotationItems: weatherMapViewModel.placesData) { location in
                                MapMarker(coordinate: location.coordinates)
                            }
                            .ignoresSafeArea()
                            .frame(height: 320)
                        }
                    }
                }
                if weatherMapViewModel.supportedTouristDestinations.contains(weatherMapViewModel.city) {
                    Text("Tourist Attractions in \(weatherMapViewModel.city)")
                        .bold()
                        .font(.title2)
                        .padding(.vertical)
                    List{
                        ForEach(weatherMapViewModel.placesData) { item in
                            NavigationLink(destination: TouristDestinationDetails()) {
                                HStack{
                                    Image(item.imageNames[0])
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(10)
                                    VStack {
                                        Text("\(item.name)")
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Spacer()
                    Text("Unfortunately we do not have any Tourist Destinations for this location yet")
                    Spacer()
                }
            }
        }
    }
}



struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
