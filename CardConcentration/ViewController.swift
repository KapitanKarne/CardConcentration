//
//  ViewController.swift
//  CardConcentration
//
//  Created by Ralph Jazer Rebong on 6/18/19.
//  Copyright © 2019 Ralph Jazer Rebong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    var emojiChoices: Array<String> = []
    var cardBackColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    var flipCount = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(flipCount)"
        }
    }
    
    var selectedCardNumber = 0
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var resetButtonOutlet: UIButton!
    
    //var emojiChoices = ["👻","🎃","👻","🎃","👠","👠"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            print("cardNumber = \(cardNumber)")
            if (selectedCardNumber != cardNumber) {
                animateButtons(withButton: sender)
            }
            selectedCardNumber = cardNumber
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        
    }
    
    func setTheme() {
        let themes = Themes()
        let randomIndex = Int(arc4random_uniform(UInt32(themes.themeList.count)))
        self.emojiChoices = themes.themeList[randomIndex]
        cardBackColor = getRandomColor()
        scoreCountLabel.textColor = cardBackColor
        resetButtonOutlet.setTitleColor(cardBackColor, for: .normal)
        updateViewFromModel()
    }
    
    func getRandomColor() -> UIColor {
        let colorPalette = [#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1),#colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
        let randomIndex = Int(arc4random_uniform(UInt32(colorPalette.count)))
        
        return colorPalette[randomIndex]
    }
    
    func animateButtons(withButton button: UIButton) {
        
        UIView.transition(with: button, duration: 0.5, options: .transitionFlipFromLeft, animations: {
            
        }, completion: nil)
        
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : cardBackColor
                
            }
        }
    }
    
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {

        if emoji[card.identifier] == nil {
            if emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
            
        }
        
        return emoji[card.identifier] ?? "?"
    }
    
   
    @IBAction func reset(_ sender: UIButton) {
        game.resetGame()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        setTheme()
        flipCount = 0
    }
    

}

