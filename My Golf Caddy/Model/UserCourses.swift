//
//  UserCourses.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 22/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation

class UserCourses: Codable {
    
    private init() {}
    static let shared = UserCourses()
    var courses: [Course]?
}
