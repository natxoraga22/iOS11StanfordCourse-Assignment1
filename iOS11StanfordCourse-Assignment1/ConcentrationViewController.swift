//
//  ConcentrationViewController.swift
//  iOS11StanfordCourse-Assignment1
//
//  Created by Natxo Raga Llorens on 12/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import UIKit


class ConcentrationViewController: UIViewController {

    // Model
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // View
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var themes = ["Halloween" : ["🦇", "😱", "🙀", "😈", "🎃", "👻", "🍭", "🍬", "🍎", "🧛🏻‍♂️", "🧟‍♂️"],
                  "AnimalFaces" : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷", "🐵"],
                  "Animals" : ["🦆", "🦅", "🦋", "🐌", "🐞", "🐢", "🐍", "🦑", "🦐", "🦀", "🐬", "🐅", "🦍", "🐘", "🐪", "🦒", "🐄", "🐖", "🐏", "🐓", "🐇"],
                  "Sports" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸", "🏒", "🏑", "🏏"],
                  "Faces" : ["😂", "☺️", "😇", "🙃", "😜", "🤨", "🤩", "😏", "😫", "😭", "🤬", "🤯", "😱", "🤫", "🤥", "🙄", "😴", "🤤", "😵", "🤧", "🤒"],
                  "Winter" : ["🤧", "🌂", "🌨", "⛈", "❄️", "⛄️", "☔️", "⛷", "🏂", "🎄", "🎅🏼"]]
    var emojiChoices = [String]()
    var emoji = [Int:String]()
    
    
    override func viewDidLoad() {
        newGame()
    }
    
    func newGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        //set random theme
        let themeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        emojiChoices = themes[Array(themes.keys)[themeIndex]]!
        emoji.removeAll()
        
        //update UI
        updateViewFromModel()
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        let cardNumber = cardButtons.index(of: sender)
        game.chooseCard(at: cardNumber!)
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        //cards
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        //flips & score
        flipCountLabel.text = "Flips\n\(game.flipCount)"
        scoreLabel.text = "Score\n\(game.score)"
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }

}

