//
//  CoursePickerView.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 24/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation
import UIKit

class CoursePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerData = [String]()
    var currentValue: String?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        DiskManager.shared.readCourseArrayFromDisk() { result in
            switch result {
            case .success(let userCourses):
                for course in userCourses { self.pickerData.append(course.name) }
                return
            case .failure(let error):
                print(error)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Columns
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Rows
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // Data
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.orange
        pickerLabel.text = pickerData[row]
        pickerLabel.font = UIFont.italicSystemFont(ofSize: 25)
        pickerLabel.textAlignment = NSTextAlignment.center
        
        return pickerLabel
    }
    
    // Current value
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentValue = pickerData[row]
    }
}
