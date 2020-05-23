//
//  AddCourseViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 17/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class AddCourseViewController: LBTAFormController {
    
    let nameTextField = IndentedTextField(placeholder: "Name", padding: 12, cornerRadius: 3, backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    let cityTextField = IndentedTextField(placeholder: "City", padding: 12, cornerRadius: 3, backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    let postCodeTextField = IndentedTextField(placeholder: "Postcode", padding: 12, cornerRadius: 3, backgroundColor: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
    let addCourseButton = UIButton(title: "Add", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(addButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        
        nameTextField.constrainHeight(50)
        cityTextField.constrainHeight(50)
        postCodeTextField.constrainHeight(50)
        addCourseButton.constrainHeight(50)
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
        formContainerStackView.addArrangedSubview(nameTextField)
        formContainerStackView.addArrangedSubview(cityTextField)
        formContainerStackView.addArrangedSubview(postCodeTextField)
        formContainerStackView.addArrangedSubview(addCourseButton)
        formContainerStackView.setCustomSpacing(500, after: postCodeTextField)
    }
    
    @objc private func addButtonPressed() {
        let nameText = nameTextField.text
        let cityText = cityTextField.text
        let postCodeText = postCodeTextField.text
        
        if nameText?.isEmpty ?? true {
            displayAlert(message: "Name field must be specified", success: false)
        } else if cityText?.isEmpty ?? true {
            displayAlert(message: "City field must be specified", success: false)
        } else if postCodeText?.isEmpty ?? true {
            displayAlert(message: "Postcode field must be specified", success: false)
        } else {
            attemptFetchCoordiantes(name: nameText!, city: cityText!, postcode: postCodeText!)
        }
    }
    
    private func attemptFetchCoordiantes(name: String, city: String, postcode: String) {
        DataService.shared.fetchCoordinates(city: city) { result in
            switch result {
            case .failure(let error):
                print(error)
                return
            case .success(let latLng):
                let coordinates = Coordinate(latitude: latLng.lat, longitude: latLng.lng)
                self.buildCourseObject(name: name, city: city, postcode: postcode, coordinates: coordinates)
                return
            }
        }
    }
    
    private func buildCourseObject(name: String, city: String, postcode: String, coordinates: Coordinate) {
        let course = Course(name: name, city: city, postcode: postcode, location: coordinates)
        attemptWriteCourseToDisk(course: course)
    }
    
    private func attemptWriteCourseToDisk(course: Course) {
        DiskManager.shared.writeCourseToDisk(course: course) { result in
            switch result {
            case .success(let name):
                DispatchQueue.main.async {
                    self.displayAlert(message: "\(name) was saved.", success: true)
                }
                return
            case.failure(let error):
                DispatchQueue.main.async {
                    self.displayAlert(message: "Unable to save \(course.name).", success: true)
                }
                print(error)
                return
            }
        }
    }
    
    private func displayAlert(message: String, success: Bool) {
        let alert = UIAlertController(title: success == true ? "Done!" : "Oops!", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
}

