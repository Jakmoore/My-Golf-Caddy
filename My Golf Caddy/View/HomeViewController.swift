//
//  HomeViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 17/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class HomeViewController: LBTAFormController {
    
    let titleView = UILabel(text: "My Golf Caddy", font: .italicSystemFont(ofSize: 35), textColor: .orange, textAlignment: .center, numberOfLines: 1)
    let scoreCardButton = UIButton(title: "Score Card", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(scoreCardButtonPressed))
    let weatherButton = UIButton(title: "Weather", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(weatherbuttonPressed))
    let myCoursesButton = UIButton(title: "My Courses", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(myCoursesButtonPressed))
    let progressionButton  = UIButton(title: "Progression", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(progressionButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        
        titleView.backgroundColor = UIColor.clear
        titleView.constrainHeight(100)
        scoreCardButton.constrainHeight(70)
        weatherButton.constrainHeight(70)
        myCoursesButton.constrainHeight(70)
        progressionButton.constrainHeight(70)
        
        formContainerStackView.addArrangedSubview(titleView)
        formContainerStackView.addArrangedSubview(scoreCardButton)
        formContainerStackView.addArrangedSubview(weatherButton)
        formContainerStackView.addArrangedSubview(myCoursesButton)
        formContainerStackView.addArrangedSubview(progressionButton)
        formContainerStackView.setCustomSpacing(100, after: titleView)
    }
    
    @objc private func scoreCardButtonPressed() {
        let vc = GameLengthViewController()
        self.present(vc, animated: true)
    }
    
    @objc private func weatherbuttonPressed() {
        let vc =  ChooseWeatherViewController()
        self.present(vc, animated: true)
    }
    
    @objc private func myCoursesButtonPressed() {
        let vc = CoursesViewController()
        self.present(vc, animated: true)
    }
    
    @objc private func progressionButtonPressed() {
        let vc = ProgressionViewController()
        self.present(vc, animated: true)
    }
}
