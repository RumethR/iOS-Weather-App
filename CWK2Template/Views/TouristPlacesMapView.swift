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
                                MapAnnotation(coordinate: location.coordinates) {
                                    NavigationLink(destination: TouristDestinationDetails(locationData: .constant(location))) {
                                        VStack {
                                            Text(location.name)
                                                .font(.caption)
                                                .bold()
                                                .background(Color.white)
                                                .foregroundColor(.black)
                                                .cornerRadius(10)
                                                .padding(.horizontal, 12)
                                            
                                            Image(systemName: "mappin")
                                                .font(.system(size: 30))
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }
                            .ignoresSafeArea()
                            .frame(height: 300)
                        }
                    }
                }
                if weatherMapViewModel.placesData.count != 0 {
                    Text("Tourist Attractions in \(weatherMapViewModel.city)")
                        .bold()
                        .font(.title2)
                        .padding(.vertical)
                    List{
                        ForEach(weatherMapViewModel.placesData) { item in
                            NavigationLink(destination: TouristDestinationDetails(locationData: .constant(item))) {
                                HStack{
                                    Image(item.imageNames[0])
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .cornerRadius(5)
                                    VStack {
                                        Text("\(item.name)")
                                            .font(.headline)
                                    }
                                }
                            }
                            .listRowBackground(Color.gray.opacity(0.01))
                        }
                    }
                    .listStyle(.plain)
                } else {
                    Image(systemName: "exclamationmark.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.red)
                        .padding(.top)
                    
                    Text("Unfortunately we do not have any Tourist Destinations for this location yet.")
                        .multilineTextAlignment(.center)
                        .bold()
                        .padding()
                    
                    Spacer()
                }
            }
            .background(
                Image("background2")
                .resizable()
                .scaledToFill()
                .opacity(0.4)
                .ignoresSafeArea()
            )

        }
    }
}



struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
