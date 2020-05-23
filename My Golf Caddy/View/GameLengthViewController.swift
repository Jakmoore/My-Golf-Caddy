//
//  GameLengthViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 17/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import UIKit
import LBTATools

class GameLengthViewController: LBTAFormController {
    
    let nineHolesButton = UIButton(title: "9 Holes", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(nineHolesButtonPressed))
    let eighteenHolesButton = UIButton(title: "18 Holes", titleColor: .black, font: .italicSystemFont(ofSize: 19), backgroundColor: .orange, target: self, action: #selector(eighteenHolesButtonPressed))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.2095873058, green: 0.2276916504, blue: 0.2519574165, alpha: 1)
        formContainerStackView.axis = .vertical
        formContainerStackView.spacing = 12
        
        formContainerStackView.layoutMargins = .init(top: 325, left: 24, bottom: 152, right: 24)
        
        nineHolesButton.constrainHeight(70)
        eighteenHolesButton.constrainHeight(70)
        
        formContainerStackView.addArrangedSubview(nineHolesButton)
        formContainerStackView.addArrangedSubview(eighteenHolesButton)
    }
    
    @objc private func nineHolesButtonPressed() {
        
    }
    
    @objc private func eighteenHolesButtonPressed() {
        
    }
}
