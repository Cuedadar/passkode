//
//  ViewController.swift
//  WordGuesser
//
//  Created by John King on 8/7/24.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var stackView: UIStackView!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var textField: UITextField!
  @IBOutlet var bottomConstraint: NSLayoutConstraint!
  
  let game = Game()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Forfeit Game", style: .done, target: self, action: #selector(forfeitGamePressed))
    
    let notificationCenter = NotificationCenter.default
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    
    game.startGame()
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  func returnPressed(_ string: String) {
    let result = game.checkGuess(string)
    
    switch result.result {
    case .Correct:
      let alert: UIAlertController = UIAlertController(title: "Congratulations!", message: "\(string) was the PassKode!", preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "OK", style: .default))
      present(alert, animated: true)
      resetGame()
      
    case .Invalid:
      // TODO: Shake Input View...better
      shakeTextField()
      print("Shake your bootay")
      
    case .Results:
      displayNewResult(result)
    }
  }
  
  @objc func forfeitGamePressed() {
    let passkode = game.forfeitGame()
    let alert: UIAlertController = UIAlertController(title: "Oh No!", message: "\(passkode) was the PassKode!", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    present(alert, animated: true)
    
    // TODO: Improve by resetting after pressing OK
    resetGame()
  }
  
  func resetGame() {
    for aView in stackView.subviews {
      if let aResult = aView as? GuessResultsView {
        aResult.removeFromSuperview()
      }
    }
    
    game.startGame()
  }
  
  func displayNewResult(_ results: GuessResultViewModel) {
    let resultsView = GuessResultsView.loadFromNib()
    resultsView.setupResult(results)
    stackView.addArrangedSubview(resultsView)
    resultsView.flipToFront()
    //TODO: Scroll to bottom of StackView
  }
  
  func shakeTextField() {
    let animation = CABasicAnimation(keyPath: "position")
    animation.duration = 0.07
    animation.repeatCount = 4
    animation.autoreverses = true
    animation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 10, y: textField.center.y))
    animation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 10, y: textField.center.y))

    textField.layer.add(animation, forKey: "position")
  }
  
  @objc func adjustForKeyboard(notification: Notification) {
    guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

    let keyboardScreenEndFrame = keyboardValue.cgRectValue
    let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from:view.window)

    if notification.name == UIResponder.keyboardWillHideNotification {
      UIView.animate(withDuration:0.1, animations: {
        self.bottomConstraint.constant = 0
      })
    } else {
      UIView.animate(withDuration:0.1, animations: {
        self.bottomConstraint.constant = -keyboardViewEndFrame.size.height + self.view.safeAreaInsets.bottom
      })
    }
  }
  
  // Bug when touching the bottom of the screen
//  open override var preferredScreenEdgesDeferringSystemGestures: UIRectEdge {
//      return .all
//  }
}


extension ViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    if string == "\n" {
      if let text = textField.text {
        // This does end up checking empty strings, but it keeps all error checking in one place
        textField.text = ""
        returnPressed(text.trimmingCharacters(in: .whitespacesAndNewlines))
        textField.endEditing(false)
        return false
      }
      // How did we get here?
      return false
    }
    
    // Any other character
    return true
  }
}
