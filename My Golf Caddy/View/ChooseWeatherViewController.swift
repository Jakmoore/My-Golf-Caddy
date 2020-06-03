//
//  WeatherViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 17/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class ChooseWeatherViewController: LBTAFormController {
    
    let pickerView = CoursePickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        
        pickerView.delegate = pickerView
        pickerView.dataSource = pickerView
        
        let okButton = UIButton(title: "OK", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(okButtonPressed))
        okButton.constrainHeight(70)
        
        formContainerStackView.addArrangedSubview(pickerView)
        formContainerStackView.addArrangedSubview(okButton)
        formContainerStackView.setCustomSpacing(400, after: pickerView)
    }
    
    @objc private func okButtonPressed() {
        let chosenCourse = pickerView.currentValue ?? pickerView.pickerData[0]
        UserDefaults.standard.set(chosenCourse, forKey: "ChosenCourseForWeather")
        let vc = WeatherViewController()
        self.present(vc, animated: true)
    }
}
