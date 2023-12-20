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
            VStack(spacing: 5) {
                if weatherMapViewModel.coordinates != nil {
                    VStack(spacing: 10){
                        Map(coordinateRegion: $weatherMapViewModel.region, annotationItems: weatherMapViewModel.placesData) { location in
                            MapMarker(coordinate: location.coordinates)
                        }
                            .frame(height: 350)
                            .ignoresSafeArea()
                        VStack{
                            Text("This is a locally defined map for starter template")
                            Text("A map of the user-entered location should be shown here")
                            Text("Map should also show pins of tourist places")
                        }.multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                List{
                    HStack{
                        VStack {
                            Text("Tourist place Image")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("Tourist place details")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Text("See images in coursework spec")
                        }
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
