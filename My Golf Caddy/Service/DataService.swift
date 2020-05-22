//
//  DataService.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 18/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation

enum LocationError: Error {
    case noDataAvailable
    case canNotProcessData
    case unableToProcessUrl
}

struct DataService {
    
    // MARK: Singleton
    static let shared = DataService()
    
    // MARK: Fetch Lat and Long from web service
    func fetchCoordinates(city: String, postcode: String, completion: @escaping(Result<LatLng, LocationError>) -> Void) {
        
        // Need to allow for country specific requests at some point
        let locationUrl = "https://open.mapquestapi.com/geocoding/v1/address?key=1kQpZCun5LCTIFskAKCQoiLiYhHOz7fg&location=\(city)"
        
        guard let url = URL(string: locationUrl) else {
            completion(.failure(.unableToProcessUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) {data, _, error in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                let locationResponse = try decoder.decode(LocationResponse.self, from: jsonData)
                let latLngResponse = locationResponse.results.first!.locations.first?.latLng
                let latLng = LatLng(lat: latLngResponse!.lat, lng: latLngResponse!.lng)
                completion(.success(latLng))
                return
            } catch let error as NSError {
                print("Error processing data. \(error)")
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    // MARK: Fetch weather data
    func fetchWeather(coordinates: Coordinate) {
        
    }
}
