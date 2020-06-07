//
//  ViewCourseViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 07/06/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class ViewCourseViewController: LBTAFormController {
    
    let courseTitle = UILabel(text: "", font: .italicSystemFont(ofSize: 35), textColor: .orange, textAlignment: .center, numberOfLines: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        
        let courseName = getCourseName()
        courseTitle.text = courseName
        DiskManager.shared.attemptFetchCourseObject(courseName: courseName) { response in
            switch response {
            case .success(let course):
                print(course)
            case .failure(let error):
                print(error)
            }
        }
        
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        formContainerStackView.layoutMargins = .init(top: 50, left: 24, bottom: 0, right: 24)
    }
    
    private func getCourseName() -> String {
        let chosenCourse = UserDefaults.standard.object(forKey: "ChosenCourseToView") as! String
        print("Chosen course to view: \(chosenCourse)")
        return chosenCourse
    }
}
