//
//  GameViewController.swift
//  WordApp
//
//  Created by David Kalitzki on 2025-03-25.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var buttonHighScore: UIButton!
    
    var words = EnglishAndSwedishWord()
    
    var question: String = ""
    var rightanswer: String = ""
    var points: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        answerLabel.becomeFirstResponder()
        
        randomWord()
        
        countdown()
        
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        makeGuess()
        
    }
    
    func randomWord() {
        let dictionaryType = DictionaryType.sailing
        let displayWord = words.getRandomEnglishWord(dictionaryType)
        
        if let englishWord = displayWord?.english {
            question = englishWord
        } else {return
        }
        
        if let swedishWord = displayWord?.swedish {
            rightanswer = swedishWord
        } else {return
        }
        
        questionLabel.text = question
        
    }
    
    
    
    func makeGuess(){
        if answerLabel.text == rightanswer {
            print("Rätt!")
            points += 1
            pointsLabel.text = String(points)
            
            
        } else {
            print("Fel")
        }
    }
    
    func countdown(){
        let totalTime = 10
        for i in 0...totalTime {
            Timer.scheduledTimer(withTimeInterval: Double(i), repeats: false) { timer in
                self.timerLabel.text = String(totalTime - i)
            }
            
        }
        
    }
    
    
    @IBAction func buttonhighScorepressed(_ sender: Any) {
        
       if let highScoreVC = storyboard?.instantiateViewController(withIdentifier: "highScoreViewController") {
            highScoreVC.modalPresentationStyle = .fullScreen
            present(highScoreVC, animated: true, completion: nil)
            
        }  
    }
    
}
