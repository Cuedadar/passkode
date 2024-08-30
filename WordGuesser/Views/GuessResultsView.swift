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
  
  var box1Cover: UIView = UIView()
  var box2Cover: UIView = UIView()
  var box3Cover: UIView = UIView()
  var box4Cover: UIView = UIView()
  var box5Cover: UIView = UIView()
  
  private var animationLength = 0.5
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    addConstraint(NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 90.0))
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    setupCovers()
  }
  
  func setupCovers() {
    print(box1.frame)
    print(box2.frame)
    print(box3.frame)
    print(box4.frame)
    print(box5.frame)
    
    box1Cover.frame = box1.frame
    box2Cover.frame = box2.frame
    box3Cover.frame = box3.frame
    box4Cover.frame = box4.frame
    box5Cover.frame = box5.frame
    
    box1Cover.autoresizingMask = box1.autoresizingMask
    box2Cover.autoresizingMask = box2.autoresizingMask
    box3Cover.autoresizingMask = box3.autoresizingMask
    box4Cover.autoresizingMask = box4.autoresizingMask
    box5Cover.autoresizingMask = box5.autoresizingMask
    
    box1Cover.backgroundColor = UIColor.darkGray
    box2Cover.backgroundColor = UIColor.darkGray
    box3Cover.backgroundColor = UIColor.darkGray
    box4Cover.backgroundColor = UIColor.darkGray
    box5Cover.backgroundColor = UIColor.darkGray
    
    addSubview(box1Cover)
    addSubview(box2Cover)
    addSubview(box3Cover)
    addSubview(box4Cover)
    addSubview(box5Cover)
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
  
  func flipToFront() {
    perform(#selector(flipCard1), with: nil, afterDelay: animationLength * 0)
    perform(#selector(flipCard2), with: nil, afterDelay: animationLength * 1)
    perform(#selector(flipCard3), with: nil, afterDelay: animationLength * 2)
    perform(#selector(flipCard4), with: nil, afterDelay: animationLength * 3)
    perform(#selector(flipCard5), with: nil, afterDelay: animationLength * 4)
  }
  
  @objc private func flipCard1() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    UIView.transition(with: box1Cover, duration: animationLength, options: transitionOptions, animations: {
      self.box1Cover.alpha = 0
    }, completion: { success in
      self.box1Cover.isHidden = true
    })
    
    UIView.transition(with: box1, duration: animationLength, options: transitionOptions) {
      self.box1.isHidden = false
    }
  }
  
  @objc private func flipCard2() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    UIView.transition(with: box2Cover, duration: animationLength, options: transitionOptions, animations: {
      self.box2Cover.alpha = 0
    }, completion: { success in
      self.box2Cover.isHidden = true
    })
    
    UIView.transition(with: box2, duration: animationLength, options: transitionOptions) {
      self.box2.isHidden = false
    }
  }
  
  @objc private func flipCard3() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    UIView.transition(with: box3Cover, duration: animationLength, options: transitionOptions, animations: {
      self.box3Cover.alpha = 0
    }, completion: { success in
      self.box3Cover.isHidden = true
    })
    
    UIView.transition(with: box3, duration: animationLength, options: transitionOptions) {
      self.box3.isHidden = false
    }
  }
  
  @objc private func flipCard4() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    UIView.transition(with: box4Cover, duration: animationLength, options: transitionOptions, animations: {
      self.box4Cover.alpha = 0
    }, completion: { success in
      self.box4Cover.isHidden = true
    })
    
    UIView.transition(with: box4, duration: animationLength, options: transitionOptions) {
      self.box4.isHidden = false
    }
  }
  
  @objc private func flipCard5() {
    let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
    
    UIView.transition(with: box5Cover, duration: animationLength, options: transitionOptions, animations: {
      self.box5Cover.alpha = 0
    }, completion: { success in
      self.box5Cover.isHidden = true
    })
    
    UIView.transition(with: box5, duration: animationLength, options: transitionOptions) {
      self.box5.isHidden = false
    }
  }
}
