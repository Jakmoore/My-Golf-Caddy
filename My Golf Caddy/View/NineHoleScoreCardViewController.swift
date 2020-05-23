//
//  9HoleScoreCardViewController.swift
//  My Golf Caddy
//
//  Created by Jak Moore on 14/05/2020.
//  Copyright © 2020 Jak Moore. All rights reserved.
//

import Foundation
import UIKit

class NineHoleScoreCardViewController: UIViewController {
    
    var scoreCardCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = (view.frame.size.width - 30) / 4
        let layout = scoreCardCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
}

extension NineHoleScoreCardViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ScoreCardCollectionViewCell
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let textField = cell.viewWithTag(1) as! UITextField
        applyTextFieldStyle(textField: textField, width: layout.itemSize.width, height: layout.itemSize.height)
        
        return cell
    }
    
    func applyTextFieldStyle(textField: UITextField, width: CGFloat, height: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        textField.frame = frame
        textField.textAlignment = .center
        textField.text = "TEST"
    }
}
