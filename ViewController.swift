//
//  ViewController.swift
//  Apple pie
//
//  Created by Chiori Suzuki on 2020/12/10.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["buccaneer", "swift", "glorious",
    "incandescent", "bug", "program"]
    
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
    }

    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0{
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord{
            totalWins += 1
        } else {
            updateUI()
        }
    }

    func updateUI(){
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        
    }
    
    func newRound(){
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word:newWord, incorrectMovesRemaining:
            incorrectMovesAllowed, guessedLetters: [])
            updateUI()
        } else {
            enableLetterButtons(false)
        }

    }
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }

    
}

