//
//  LocationResponse.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 20/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation

struct LocationResponse: Decodable {
    var results: [Results]
}

struct Results: Decodable {
    var locations: [Location]
}

struct Location: Decodable {
    var latLng: LatLng
}

struct LatLng: Decodable {
    var lat: Double
    var lng: Double
}
