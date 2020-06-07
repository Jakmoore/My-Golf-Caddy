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

enum WeatherError: Error {
    case unableToRetrieveWeather
    case canNotProcessData
    case unableToProcessUrl
}

struct DataService {
    
    static let shared = DataService()
    
    func fetchCoordinates(city: String, completion: @escaping(Result<LatLng, LocationError>) -> Void) {
        let locationUrl = "https://open.mapquestapi.com/geocoding/v1/address?key=1kQpZCun5LCTIFskAKCQoiLiYhHOz7fg&location=\(city)"
        
        guard let url = URL(string: locationUrl) else {
            completion(.failure(.unableToProcessUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
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
            } catch let error as NSError {
                print("Error processing location data. \(error)")
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
    func attemptFetchWeather(coordinates: Coordinate, completion: @escaping(Result<WeatherResponse, Error>) -> Void) {
        DataService.shared.fetchWeather(coordinates: coordinates) { response in
            switch response {
            case .success(let weatherRepsonse):
                completion(.success(weatherRepsonse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchWeather(coordinates: Coordinate, completion: @escaping(Result<WeatherResponse, WeatherError>) -> Void) {
        let lat = coordinates.latitude
        let long = coordinates.longitude
        let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=61859f6344902cb6dfb2c7374c5de438"
        
        guard let url = URL(string: weatherUrl) else {
            completion(.failure(.unableToProcessUrl))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let jsonData = data else {
                completion(.failure(.canNotProcessData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                completion(.success(weatherResponse))
            } catch let error as NSError {
                print("Error processing weather data. \(error)")
                completion(.failure(.unableToRetrieveWeather))
            }
        }
        dataTask.resume()
    }
}
