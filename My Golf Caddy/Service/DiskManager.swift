//
//  DiskManager.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 22/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation

enum DiskWriteError: Error {
    case errorWritingCourseToDisk
}

enum DiskReadError: Error {
    case errorReadingCourseData
}

struct DiskManager {
    
    private init() {}
    static let shared = DiskManager()
    
    func writeCourseToDisk(course: Course, completion: @escaping(Result<String, DiskWriteError>) -> Void) {
        if let _ = UserCourses.shared.courses {
            UserCourses.shared.courses!.append(course)
        } else {
            UserCourses.shared.courses = [course]
        }
        
        let encoder = JSONEncoder()
        if let encodedUserCourses = try? encoder.encode(UserCourses.shared.courses) {
            UserDefaults.standard.set(encodedUserCourses, forKey: "UserCourses")
            completion(.success(course.name))
        } else {
            completion(.failure(.errorWritingCourseToDisk))
        }
    }
    
    func attemptFetchCourseObject(courseName: String, completion: @escaping(Result<Course, Error>) -> Void) {
        DiskManager.shared.readCourseFromDisk(name: courseName) { response in
            switch response {
            case .success(let course):
                completion(.success(course))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func readCourseFromDisk(name: String, completion: @escaping(Result<Course, DiskReadError>) -> Void) {
        let decoder = JSONDecoder()
        if let courseData = UserDefaults.standard.data(forKey: "UserCourses") {
            do {
                let userCourses = try decoder.decode([Course].self, from: courseData)
                for course in userCourses {
                    if course.name == name { completion(.success(course)) }
                }
            } catch {
                completion(.failure(.errorReadingCourseData))
            }
        } else {
            completion(.failure(.errorReadingCourseData))
        }
    }
    
    func readCourseArrayFromDisk(completion: @escaping(Result<[Course], DiskReadError>) -> Void) {
        let decoder = JSONDecoder()
        if let courseData = UserDefaults.standard.data(forKey: "UserCourses") {
            do {
                let userCourses = try decoder.decode([Course].self, from: courseData)
                completion(.success(userCourses))
            } catch {
                completion(.failure(.errorReadingCourseData))
            }
        }
    }
}
