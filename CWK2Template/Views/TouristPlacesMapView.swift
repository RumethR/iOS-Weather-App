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
        NavigationStack {
            VStack {
                if weatherMapViewModel.coordinates != nil {
                    VStack {
                        Map(coordinateRegion: $currentLocation, annotationItems: weatherMapViewModel.placesData) { location in
                            MapMarker(coordinate: location.coordinates)
                        }
                        .ignoresSafeArea()
                        .frame(height: 320)
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
            .onAppear {
                // Using London's coordinates to deafult if weatherMapViewModel doesn not provide any coordinates.
                currentLocation = MKCoordinateRegion(center: weatherMapViewModel.coordinates ?? CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            }
        }
    }
}



struct TouristPlacesMapView_Previews: PreviewProvider {
    static var previews: some View {
        TouristPlacesMapView()
    }
}
