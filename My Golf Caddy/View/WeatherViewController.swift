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
        constrainTextViewHeights()
        setTextViewBackgrounds()
        
        let courseName = getCourseName()
        courseTitle.text = courseName
        
        attemptFetchCourseObject(courseName: courseName) { response in
            switch response {
            case .success(let course):
                self.attemptFetchWeather(coordinates: course.location) { response in
                    switch response {
                    case .success(let weatherResponse):
                        self.populateWeatherInfo(weather: weatherResponse)
                    case .failure(let error):
                        print(error)
                        self.displayAlert(message: "Unable to retrieve weather data.", success: false)
                    }
                }
            case .failure(let error):
                print(error)
                self.displayAlert(message: "Unable to retrieve course data.", success: false)
            }
        }
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        formContainerStackView.addArrangedSubview(courseTitle)
        // formContainerStackView.addArrangedSubview(weatherImage)
        formContainerStackView.addArrangedSubview(temperatureTextView)
        formContainerStackView.addArrangedSubview(windTextView)
        formContainerStackView.addArrangedSubview(descriptionTextView)
    }
        
    private func constrainTextViewHeights() {
        courseTitle.constrainHeight(100)
        temperatureTextView.constrainHeight(70)
        windTextView.constrainHeight(70)
        descriptionTextView.constrainHeight(70)
    }
    
    private func setTextViewBackgrounds() {
        courseTitle.backgroundColor = .none
        temperatureTextView.backgroundColor = .none
        windTextView.backgroundColor = .none
        descriptionTextView.backgroundColor = .none
    }
    
    private func populateWeatherInfo(weather: WeatherResponse) {
        let temp = String(fahrenheitToCelsius(temp: weather.main.temp))
        let windSpeed = String(metersPerSecondToMilesPerHour(speed: weather.wind.speed))
        let description = weather.weather.first?.description
        DispatchQueue.main.async {
            self.temperatureTextView.text = "Temperature: \(temp)°C"
            self.windTextView.text = "Wind: \(windSpeed) mph"
            self.descriptionTextView.text = "Description: \(description!)"
        }
    }
    
    private func fahrenheitToCelsius(temp: Double) -> Int {
        return Int(temp - 273.15)
    }
    
    private func metersPerSecondToMilesPerHour(speed: Double) -> Int {
        return Int(speed * 2.237)
    }
    
    private func attemptFetchCourseObject(courseName: String, completion: @escaping(Result<Course, Error>) -> Void) {
        DiskManager.shared.readCourseFromDisk(name: courseName) { response in
            switch response {
            case .success(let course):
                completion(.success(course))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func attemptFetchWeather(coordinates: Coordinate, completion: @escaping(Result<WeatherResponse, Error>) -> Void) {
        DataService.shared.fetchWeather(coordinates: coordinates) { response in
            switch response {
            case .success(let weatherRepsonse):
                completion(.success(weatherRepsonse))
            case .failure(let error):
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
