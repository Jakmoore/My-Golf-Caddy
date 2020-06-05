//
//  WeatherViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 24/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class WeatherViewController: LBTAFormController {
    
    let courseTitle = UITextView(text: "", font: .italicSystemFont(ofSize: 35), textColor: .orange, textAlignment: .center)
    let weatherImage = UIImageView()
    let temperatureTextView = UITextView(text: "Temperature: ?", font: .italicSystemFont(ofSize: 19), textColor: .orange, textAlignment: .center)
    let windTextView = UITextView(text: "Wind: ?", font: .italicSystemFont(ofSize: 19), textColor: .orange, textAlignment: .center)
    let descriptionTextView = UITextView(text: "Description", font: .italicSystemFont(ofSize: 19), textColor: .orange, textAlignment: .center)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        
        let courseName = getCourseName()
        courseTitle.backgroundColor = .none
        courseTitle.text = courseName
        courseTitle.constrainHeight(100)
        
        if let course = attemptFetchCourseObject(courseName: courseName) {
            if let weatherResponse = attemptFetchWeather(coordinates: course.location) {
                populateWeatherInfo(weather: weatherResponse)
            } else {
                displayAlert(message: "Unable to retrieve weather info.", success: false)
            }
        } else {
            displayAlert(message: "Unable to retrieve course info.", success: false)
        }
        
        formContainerStackView.addArrangedSubview(courseTitle)
        formContainerStackView.addArrangedSubview(weatherImage)
        formContainerStackView.addArrangedSubview(temperatureTextView)
        formContainerStackView.addArrangedSubview(windTextView)
        formContainerStackView.addArrangedSubview(descriptionTextView)
    }
    
    private func populateWeatherInfo(weather: WeatherResponse) {
        let temp = String(fahrenheitToCelcius(temp: weather.main.temp))
        let windSpeed = String(weather.wind.speed)
        let description = weather.weather.first?.description
        temperatureTextView.text = "Temperature: \(temp)"
        windTextView.text = "Wind: \(windSpeed)"
        descriptionTextView.text = "Description: \(description!)"
    }
    
    private func fahrenheitToCelcius(temp: Double) -> Double {
        return ((temp - 32) * 5) / 9
    }
    
    private func attemptFetchCourseObject(courseName: String) -> Course? {
        var course: Course?
        DiskManager.shared.readCourseFromDisk(name: courseName) { response in
            switch response {
            case .success(let courseFromDisk):
                course = courseFromDisk
                return
            case .failure(let error):
                print(error)
                return
            }
        }
        return course
    }
    
    private func attemptFetchWeather(coordinates: Coordinate, completion: @escaping(Result<WeatherResponse, Error>) -> Void) {
        DataService.shared.fetchWeather(coordinates: coordinates) { response in
            switch response {
            case .success(let weatherRepsonse):
                completion(.success(weatherRepsonse))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    private func getCourseName() -> String {
        let chosenCourse = UserDefaults.standard.object(forKey: "ChosenCourseForWeather") as! String
        print("Chosen course: \(chosenCourse)")
        return chosenCourse
    }
    
    private func displayAlert(message: String, success: Bool) {
        let alert = UIAlertController(title: success == true ? "Done!" : "Oops!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
