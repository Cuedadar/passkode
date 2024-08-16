//
//  GuessResultsLetterView.swift
//  Passkode
//
//  Created by John King on 8/15/24.
//

import UIKit

class GuessResultsLetterView: UIView {
  
  @IBOutlet var letterLabel: UILabel!
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    if (self.subviews.count == 0) {
      let view = GuessResultsLetterView.loadFromNib()
      self.letterLabel = view.letterLabel
      self.frame = view.frame
      self.autoresizingMask = view.autoresizingMask
      self.addSubview(view)
    }
  }
}
