//
//  TouristDestinationDetails.swift
//  CWK2Template
//
//  Created by Rumeth Randombage on 2024-01-08.
//

import SwiftUI

struct TouristDestinationDetails: View {
    @Binding var locationData: Location
    @State private var imageList: [String] = []
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    // Not showing the image carousel if the images are not in Assests
                    if imageList.count != 0 {
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
                    }
                    
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
        .onAppear {
            for imageName in locationData.imageNames {
                if UIImage(named: imageName) != nil {
                    imageList.append(imageName)
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
