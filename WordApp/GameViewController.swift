//
//  GameViewController.swift
//  WordApp
//
//  Created by David Kalitzki on 2025-03-25.
//
import AVFoundation
import UIKit

class GameViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var buttonHighScore: UIButton!
    
    var words = EnglishAndSwedishWord()
    var translateToSwedish = UserDefaults.standard.bool(forKey: "translationDirection")

    
    var question: String = ""
    var rightanswer: String = ""
    var points: Int = 0
    var lives: Int = 3
    
    var timer: Timer?
    var totalTime = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // playSound(named: "clock-ticking",loops: -1)
        
        answerLabel.becomeFirstResponder()
        lifeLabel.text = "❤️❤️❤️"
        
        randomWord()
        
        countdown()
        
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        playSound(named: "button-click")
        
        makeGuess()
        answerLabel.text = ""
    }
    
    func randomWord() {
        let dictionaryType = DictionaryType.sailing
        let displayWord = words.getRandomEnglishWord(dictionaryType)
        
        if translateToSwedish {
                     // English to Swedish
                     if let englishWord = displayWord?.english, let swedishWord = displayWord?.swedish {
                         question = englishWord
                         rightanswer = swedishWord
                     }
                 } else {
                     // Swedish to English
                     if let englishWord = displayWord?.english, let swedishWord = displayWord?.swedish {
                         question = swedishWord
                         rightanswer = englishWord
                     }
                 }

        
        questionLabel.text = question
        
    }
    
    func newRound(){
        randomWord()
        countdown()
    }
    
    func makeGuess(){
        if answerLabel.text?.lowercased() == rightanswer.lowercased() {
            print("Rätt!")
            points += 1
            pointsLabel.text = String("\(points) points")
            newRound()
            
        } else {
            print("Fel")
            minusPoints()
            lives -= 1
            if lives == 2 {
                lifeLabel.text = "❤️❤️"
                newRound()
                playSound(named: "clock-ticking", loops: -1)
            }
            if lives == 1 {
                lifeLabel.text = "❤️"
                newRound()
                playSound(named: "clock-ticking", loops: -1)
            }
            if lives == 0 {
                timer?.invalidate()
                lifeLabel.text = ""
                gameOver(DidLose: true)
            }
        }
    }
    
    func countdown(){
     timer?.invalidate() // Stop previus timer
     totalTime = 10
     timerLabel.text = String(totalTime)
        
     playSound(named: "clock-ticking",loops: -1) // play sound in loop
        
     timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
         self.totalTime -= 1
         self.timerLabel.text = String(self.totalTime)
         
         if self.totalTime <= 0 {
            self.stopTickingSound() // stop loop and play times up sound
            self.playSound(named: "times-up")
            timer.invalidate()// Stop timer
            self.gameOver(DidLose: true) // Games over when time runs out
         }
     }
    }
    
    @IBAction func buttonhighScorepressed(_ sender: Any) {
        playSound(named: "button-click")
       if let highScoreVC = storyboard?.instantiateViewController(withIdentifier: "highScoreViewController") {
            highScoreVC.modalPresentationStyle = .fullScreen
            present(highScoreVC, animated: true, completion: nil)
            
        }  
    }
    
    func playSound(named soundName: String, loops: Int = 0) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print(" No sound found ")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = loops
            audioPlayer?.play()
        }catch let error {
            print("Faild to play sound: \(error) ")
        }
    }
  
    func stopTickingSound(){
        audioPlayer?.stop()
        audioPlayer = nil
    }
  
    func restartGame(){
        pointsLabel.text = "0"
        randomWord()
        countdown()
    }
    
    func minusPoints(){
        if points > 0 {
            points -= 1
        } else {
            points = 0
        }
        pointsLabel.text = "\(points) points"
    }
    
    func gameOver(DidLose: Bool){
        if DidLose{
            if let gameOverVC = storyboard?.instantiateViewController(withIdentifier: "gameoverViewcontroller")as? GameOverViewController {
                gameOverVC.modalPresentationStyle = .fullScreen
                gameOverVC.score = points // sends points value to gameOverViewController
                gameOverVC.leftlives = lives
                present(gameOverVC, animated: true, completion: nil)
                HighScoreFunctions.writeToHighScoreList(score: points)
            }
        }
            
        else {
           //  kanske lägga till liv här
        }
    }
   
    
}
