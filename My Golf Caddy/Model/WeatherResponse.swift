//
//  WeatherResponse.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 23/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    var weather: [Weather]
    var main: Main
    var wind: Wind
}

struct Weather: Decodable {
    var description: String
}

struct Main: Decodable {
    var temp: Double
}

struct Wind: Decodable {
    var speed: Double
}
