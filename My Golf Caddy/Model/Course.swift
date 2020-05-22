//
//  Course.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 16/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation

struct Course: Codable {
    var name: String
    var city: String
    var postcode: String
    var location: Coordinate
}
