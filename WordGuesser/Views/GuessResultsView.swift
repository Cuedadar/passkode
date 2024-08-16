//
//  GuessResultsView.swift
//  Passkode
//
//  Created by John King on 8/15/24.
//

import UIKit

class GuessResultsView: UIView {

  @IBOutlet var box1: GuessResultsLetterView!
  @IBOutlet var box2: GuessResultsLetterView!
  @IBOutlet var box3: GuessResultsLetterView!
  @IBOutlet var box4: GuessResultsLetterView!
  @IBOutlet var box5: GuessResultsLetterView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 90.0))
  }

  func setupResult(_ result: GuessResultViewModel) {
    if let details = result.details {
      let boxesArray: [GuessResultsLetterView] = [box1, box2, box3, box4, box5]
      for index in 0..<boxesArray.count {
        let box = boxesArray[index]
        let detail = details[index]
        
        box.letterLabel.text = detail.letter.capitalized
        var backgroundColor: UIColor
        
        switch(detail.result) {
        case .Red:
          backgroundColor = UIColor.red
        case .Yellow:
          backgroundColor = UIColor.yellow
        case .Green:
          backgroundColor = UIColor.green
        }
        
        box.backgroundColor = backgroundColor
      }
    }
  }
}
