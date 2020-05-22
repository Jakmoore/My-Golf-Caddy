//
//  CoursesViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 17/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class CoursesViewController: LBTAFormController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let addCourseButton = UIButton(title: "Add Course", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(addCourseButtonPressed))
        addCourseButton.constrainHeight(70)
        
        formContainerStackView.addArrangedSubview(pickerView)
        formContainerStackView.addArrangedSubview(addCourseButton)
    }
    
    @objc private func addCourseButtonPressed() {
        let vc = AddCourseViewController()
        self.present(vc, animated: true)
    }
}

extension CoursesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}
