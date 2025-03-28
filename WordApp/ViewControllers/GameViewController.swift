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
    var timerAudioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var thumbsUpLabel: UILabel!
    @IBOutlet weak var lifeLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
  
    var words = EnglishAndSwedishWord()
    var translateToSwedish: Bool = true
    var dictionaryType: DictionaryType?
    var isTimerSoundPlaying = false

    var question: String = ""
    var rightanswer: String = ""
    var points: Int = 0
    var lives: Int = 3
    
    var timer: Timer?
    var totalTime = UserDefaults.standard.integer(forKey: "gameTime")
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        answerLabel.becomeFirstResponder()
        lifeLabel.text = "❤️❤️❤️"
        thumbsUpLabel.text = ""
        
        randomWord()
        countdown()
        
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        playSound(named: "button-click")
        makeGuess()
        answerLabel.text = ""
    }
    
    func randomWord() {
        var displayWord: EnglishAndSwedishWord?
        
        if let dictionaryType = dictionaryType {
                    displayWord = words.getRandomEnglishWord(dictionaryType)
                } else {return
                }

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
        thumbsUpLabel.text = ""
        randomWord()
        countdown()
    }
    
    func makeGuess(){
        if answerLabel.text?.lowercased() == rightanswer.lowercased() {
            print("Rätt!")
            points += 1
            pointsLabel.text = String("\(points) points")
            showThumbsUp()
         
        } else {
            print("Fel")
            minusPoints()
            lives -= 1

            if lives == 2 {
                lifeLabel.text = "❤️❤️"
                showThumbsDown()
                playTimerSound()
            }
            if lives == 1 {
                lifeLabel.text = "❤️"
                showThumbsDown()
                playTimerSound()
            }
            if lives == 0 {
                timer?.invalidate()
                lifeLabel.text = ""
                gameOver(DidLose: true)
                stopTickingSound()
            }
        }
    }
    
    func countdown(){
     timer?.invalidate() // Stop previus timer
     timerLabel.text = String(totalTime)
        
     playTimerSound() // play sound in loop
        
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
  
    func playTimerSound() {
        // check if user wants sound or not
        let isSoundOn = UserDefaults.standard.bool(forKey: "soundOn")
        if !isSoundOn{
            return  // sounds off
        }
        // get sound
        guard let url = Bundle.main.url(forResource: "clock-ticking", withExtension: "mp3") else {
            print("TimerSound missing")
            return
        }
        do {
            //play sound
            timerAudioPlayer = try AVAudioPlayer(contentsOf: url)
            timerAudioPlayer?.numberOfLoops = -1 // loops infinity
            timerAudioPlayer?.play()
        } catch let error {
            print("could not play timer sound: \(error)")
        }
    }

   func stopTickingSound(){
       timerAudioPlayer?.stop()
        timerAudioPlayer = nil
    }
    
    func playSound(named soundName: String) {
        // check if user wants sound or not
        let isSoundOn = UserDefaults.standard.bool(forKey: "soundOn")
        if !isSoundOn{
            return   // sounds off
        }
        // get sound
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("sound is missing")
            return
        }
        do {
            // play sound
            audioPlayer = try AVAudioPlayer(contentsOf: url)
           audioPlayer?.play()
        } catch let error {
            print("could not play sound: \(error)")
        }
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
                HighScoreHandler.writeToHighScoreList(score: points)
            }
        }
    }
    
    func showThumbsUp() {
        thumbsUpLabel.text = "👍"
        // show thumb up when right answer for 0,5 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                   self.newRound()
               }
    }
    func showThumbsDown(){
        thumbsUpLabel.text = "👎"
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                   self.newRound()
               }
    }
  
}
