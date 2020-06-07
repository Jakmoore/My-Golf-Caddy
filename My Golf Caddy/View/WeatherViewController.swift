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
    
    let courseTitle = UILabel(text: "", font: .italicSystemFont(ofSize: 35), textColor: .orange, textAlignment: .center, numberOfLines: 1)
    let weatherImage = UIImageView()
    let temperatureLabel = UILabel(text: "Temperature: ?", font: .italicSystemFont(ofSize: 19), textColor: .orange, textAlignment: .left, numberOfLines: 1)
    let windLabel = UILabel(text: "Wind: ?", font: .italicSystemFont(ofSize: 19), textColor: .orange, textAlignment: .left, numberOfLines: 1)
    let descriptionLabel = UILabel(text: "Description:", font: .italicSystemFont(ofSize: 19), textColor: .orange, textAlignment: .left, numberOfLines: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        formatLabels()
        removeLabelBackgrounds()
        
        let courseName = getCourseName()
        courseTitle.text = courseName
        
        DiskManager.shared.attemptFetchCourseObject(courseName: courseName) { response in
            switch response {
            case .success(let course):
                DataService.shared.attemptFetchWeather(coordinates: course.location) { response in
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
        formContainerStackView.addArrangedSubview(temperatureLabel)
        formContainerStackView.addArrangedSubview(windLabel)
        formContainerStackView.addArrangedSubview(descriptionLabel)
    }
    
    private func formatLabels() {
        courseTitle.constrainHeight(100)
        temperatureLabel.constrainHeight(70)
        windLabel.constrainHeight(70)
        descriptionLabel.constrainHeight(70)
        temperatureLabel.textAlignment = .left
        windLabel.textAlignment = .left
        descriptionLabel.textAlignment = .left
    }
    
    private func removeLabelBackgrounds() {
        courseTitle.backgroundColor = UIColor.clear
        temperatureLabel.backgroundColor = UIColor.clear
        windLabel.backgroundColor = UIColor.clear
        descriptionLabel.backgroundColor = UIColor.clear
    }
    
    private func populateWeatherInfo(weather: WeatherResponse) {
        let temp = String(fahrenheitToCelsius(temp: weather.main.temp))
        let windSpeed = String(metersPerSecondToMilesPerHour(speed: weather.wind.speed))
        let description = weather.weather.first?.description
        DispatchQueue.main.async {
            self.temperatureLabel.text = "Temperature: \(temp)°C"
            self.windLabel.text = "Wind: \(windSpeed) mph"
            self.descriptionLabel.text = "Description: \(description!)"
        }
    }
    
    private func fahrenheitToCelsius(temp: Double) -> Int {
        return Int(temp - 273.15)
    }
    
    private func metersPerSecondToMilesPerHour(speed: Double) -> Int {
        return Int(speed * 2.237)
    }
    
    private func getCourseName() -> String {
        let chosenCourse = UserDefaults.standard.object(forKey: "ChosenCourseForWeather") as! String
        print("Chosen course for weather: \(chosenCourse)")
        return chosenCourse
    }
    
    private func displayAlert(message: String, success: Bool) {
        let alert = UIAlertController(title: success == true ? "Done!" : "Oops!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}
