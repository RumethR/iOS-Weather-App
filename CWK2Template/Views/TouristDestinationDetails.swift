//
//  TouristDestinationDetails.swift
//  CWK2Template
//
//  Created by Tihara Jayawickrama on 2024-01-08.
//

import SwiftUI

struct TouristDestinationDetails: View {
    @Binding var locationData: Location
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    TabView {
                        ForEach(locationData.imageNames, id: \.self) { item in
                             Image(item)
                                .resizable()
                                .scaledToFill() //Because the images are of different sizes
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .frame(height: 200)
                    .padding(.bottom)
                    
                    Text("Description")
                        .bold()
                        .font(.title3)
                        .padding(.bottom)
                    
                    Text("\(locationData.description)")
                        .padding()

                    if let url = URL(string: locationData.link) {
                        Text("For more information visit:")
                            .font(.body)
                            .foregroundColor(.secondary)
                        
                        Link("\(locationData.link)", destination: url)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background {
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("\(locationData.name)")
    }
}
