//
//  WeatherMapViewModel.swift
//  CWK2Template
//
//  Created by girish lukka on 29/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit
class WeatherMapViewModel: ObservableObject {
// MARK:   published variables
    @Published var weatherDataModel: WeatherDataModel?
    @Published var city = "London"
    @Published var coordinates: CLLocationCoordinate2D?
    @Published var region: MKCoordinateRegion = MKCoordinateRegion()
    @Published var placesData: [Location] = []
    @Published var mapMarkers: [MapMarker] = []
    @Published var supportedTouristDestinations = ["London", "Rome", "Paris", "New York"]
    init() {
// MARK:  create Task to load London weather data when the app first launches
        Task {
            do {
                try await getCoordinatesForCity(city: city)
                try await loadData(lat: coordinates?.latitude ?? 51.509865, lon: coordinates?.longitude ?? -0.118092)
                loadLocationsFromJSONFile()
                
            } catch {
                // Handle errors if necessary
                print("Error loading weather data: \(error)")
            }
        }
    }
    func getCoordinatesForCity(city: String) async throws {
// MARK:  complete the code to get user coordinates for user entered place and specify the map region

        let geocoder = CLGeocoder()
        if let placemarks = try? await geocoder.geocodeAddressString(city),
           let location = placemarks.first?.location?.coordinate {

            DispatchQueue.main.async {
                self.coordinates = location
                self.region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                self.city = city
            }
        } else {
            // Handle error here if geocoding fails
            print("Error: Unable to find the coordinates for the club.")
        }
    }

    func loadData(lat: Double, lon: Double) async throws {
        if let url = URL(string: "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(lon)&units=metric&appid=45e40ad89ec404cc27fbe41436448e30") {
            let session = URLSession(configuration: .default)

            do {
                let (data, _) = try await session.data(from: url)
                let weatherDataModel = try JSONDecoder().decode(WeatherDataModel.self, from: data)

                DispatchQueue.main.async {
                    self.weatherDataModel = weatherDataModel
                }
                print("Data Fetched From Open Weather Map. Please use wisely")
            } catch {

                if let decodingError = error as? DecodingError {

                    print("Decoding error: \(decodingError)")
                } else {
                    //  other errors
                    print("Error: \(error)")
                }
                throw error // Re-throw the error to the caller
            }
        } else {
            throw NetworkError.invalidURL
        }
    }

    enum NetworkError: Error {
        case invalidURL
    }


    func loadLocationsFromJSONFile() {
        var allLocations: [Location] = []
        var locationList: LocationData
        
        if let fileURL = Bundle.main.url(forResource: "places", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let locationsFromJson = try decoder.decode(LocationData.self, from: data)
                
                locationList = locationsFromJson
                for location in locationList.locationData {
                    if (location.cityName == self.city) {
                        allLocations.append(location)
                    }
                }

            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        DispatchQueue.main.async {
            self.placesData = allLocations
        }
    }
    
    func createMapMarkersFromLocations() -> [MapMarker] {
        var allMapMarkers: [MapMarker] = []
        
        for location in placesData {
            allMapMarkers.append(MapMarker(coordinate: location.coordinates))
        }
        
        return allMapMarkers
    }
    
    func weatherIconURL(iconCode: String) -> URL {
        return URL(string: "https://openweathermap.org/img/wn/\(iconCode)@2x.png?appid=45e40ad89ec404cc27fbe41436448e30")!
    }

}


