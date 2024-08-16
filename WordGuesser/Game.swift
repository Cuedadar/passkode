//
//  Game.swift
//  WordGuesser
//
//  Created by John King on 8/12/24.
//

// Needed for UITextChecker
import UIKit

class Game {
  private var passkode: String
  private var allWords: [String]
  private var allGuesses: [String]
  
  init(passkode: String = "", allWords: [String] = [String](), allGuesses: [String] = [String]()) {
    self.passkode = passkode
    self.allWords = allWords
    self.allGuesses = allGuesses
    
    if let allWordsURL = Bundle.main.path(forResource: "wordlist", ofType: "txt") {
      let words = try! String(contentsOfFile: allWordsURL)
      self.allWords = words.components(separatedBy: "\n")
    }
  }
  
  func startGame() {
    passkode = allWords.randomElement()!
    allGuesses.removeAll()
    print(passkode)
  }
  
  func forfeitGame() -> String {
    // Mark forfeit?
    allGuesses.removeAll()
    return passkode.uppercased()
  }
  
  func checkGuess(_ string: String) -> GuessResultViewModel {
    let lowercasedGuess = string.lowercased()
    
    // Check for solution
    if isPasskode(lowercasedGuess) {
      return GuessResultViewModel(result: .Correct)
    }
    
    // Check for already guessed
    if alreadyGuessed(lowercasedGuess) {
      return GuessResultViewModel(result: .Invalid)
    }
    
    // Check for 5 letters
    if !isFiveLetters(lowercasedGuess) {
      return GuessResultViewModel(result: .Invalid)
    }
    
    // Check for valid word
    if !isAWord(lowercasedGuess) {
      return GuessResultViewModel(result: .Invalid)
    }
    
    // We have a word that's not the solution.
    // Analyze the word and get the tuple array
    let results = analyzeWord(lowercasedGuess)
    allGuesses.append(lowercasedGuess)
    return GuessResultViewModel(result: .Results, details: results)
  }
}

// Internal Methods
extension Game {
  private func analyzeWord(_ string: String) -> [LetterResultViewModel] {
    // Easy solution to index char by char over a known-length string
    let guessArray = Array(string)
    let answerArray = Array(passkode)
    
    // Useful for checking words with the same character multiple times
    var multipleLettersArray = Array(passkode)
    
    var results = [LetterResultViewModel]()
    
    // Iterate through word a character at a time
    for index in 0..<5 {
      let guess = guessArray[index]
      // Check if right letter in right spot
      if guess == answerArray[index] {
        results.append(LetterResultViewModel(letter: String(guess), result: .Green))
        if let multiIndex = multipleLettersArray.firstIndex(where: {$0 == guess}) {
          // Remove from the multiarray
          multipleLettersArray.remove(at: multiIndex)
        } else {
          // Special case: Guess letter before we get to it in the right spot (Mark it wrong so the 'right' one will be green and no doubling
          // We've already removed it, go back and change yellow to red
          for resultIndex in 0..<results.count {
            var result = results[resultIndex]
            if result.letter == String(guess) && result.result == .Yellow {
              result.result = .Red
              results[resultIndex] = result
              break
            }
          }
        }
        // Check if contains letter
      } else if multipleLettersArray.contains(guess) {
        results.append(LetterResultViewModel(letter: String(guess), result: .Yellow))
        if let multiIndex = multipleLettersArray.firstIndex(where: {$0 == guess}) {
          multipleLettersArray.remove(at: multiIndex)
        }
        // Doesn't contain letter
      } else {
        results.append(LetterResultViewModel(letter: String(guess), result: .Red))
      }
    }
    
    return results
  }
  
  private func isFiveLetters(_ string: String) -> Bool {
    return string.count == 5
  }
  
  private func isPasskode(_ string: String) -> Bool {
    return string == passkode
  }
  
  private func isAWord(_ string: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: string.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: string, range: range, startingAt: 0, wrap: false, language: "en")
    return misspelledRange.location == NSNotFound
  }
  
  private func alreadyGuessed(_ string: String) -> Bool {
    return allGuesses.contains(string)
  }
}
