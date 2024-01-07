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
    @State var currentLocation: MKCoordinateRegion = MKCoordinateRegion()
    var body: some View {
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        Map(coordinateRegion: $currentLocation, annotationItems: weatherMapViewModel.placesData) { location in
                            MapMarker(coordinate: location.coordinates)
                        }
                            .frame(height: 350)
                            .ignoresSafeArea()
                        VStack{
                            Text("Tourist Destinations in your area")
                        }.multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                if weatherMapViewModel.supportedTouristDestinations.contains(weatherMapViewModel.city) {
                    List{
                        ForEach(weatherMapViewModel.placesData) { item in
                            HStack{
                                Image(item.imageNames[0])
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                VStack {
                                    Text("\(item.name)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("\(item.description)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                    }
                } else {
                    Spacer()
                    VStack {
                        Text("Unfortunately we do not have any Tourist Destinations for this location yet")
                    }
                }
            }
            .onAppear {
                // Using London's coordinates to deafult if weatherMapViewModel doesn not provide any coordinates.
                currentLocation = MKCoordinateRegion(center: weatherMapViewModel.coordinates ?? CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            }
        }
    }



struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
