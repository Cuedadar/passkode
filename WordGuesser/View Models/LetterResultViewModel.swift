//
//  LetterResultViewModel.swift
//  Passkode
//
//  Created by John King on 8/15/24.
//

enum LetterResult {
  // Invalid Letter
  case Red
  // Right Letter, Right Spot
  case Green
  // Right Letter, Wrong Spot
  case Yellow
}

struct LetterResultViewModel {
  var letter: String
  var result: LetterResult
}
