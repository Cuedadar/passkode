//
//  GuessResultViewModel.swift
//  Passkode
//
//  Created by John King on 8/15/24.
//

enum GuessResult {
  case Invalid
  case Correct
  case Results
}

struct GuessResultViewModel {
  var result: GuessResult
  // Only .Results returns this array
  var details: [LetterResultViewModel]?
}
