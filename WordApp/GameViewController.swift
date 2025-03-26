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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var questionLabel: UITextField!
    @IBOutlet weak var answerLabel: UITextField!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet var buttonHighScore: UIButton!
    
    var words = EnglishAndSwedishWord()
    
    var question: String = ""
    var rightanswer: String = ""
    var points: Int = 0
    
    var timer: Timer?
    var totalTime = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        answerLabel.becomeFirstResponder()
        
        randomWord()
        
        countdown()
        
    }
    @IBAction func buttonPressed(_ sender: UIButton) {
        playSound()
        
        makeGuess()
        answerLabel.text = ""
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
    
    func newRound(){
        randomWord()
        countdown()
    }
    
    func makeGuess(){
        if answerLabel.text == rightanswer {
            print("Rätt!")
            points += 1
            pointsLabel.text = String(points)
            newRound()
            
        } else {
            print("Fel")
        }
    }
    
    func countdown(){
     timer?.invalidate() // Stop previus timer
     totalTime = 10
     timerLabel.text = String(totalTime)
     
     timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
         self.totalTime -= 1
         self.timerLabel.text = String(self.totalTime)
         
         if self.totalTime <= 0 {
             timer.invalidate() // Stop timer
             self.gameOver(DidLose: true) // Games over when time runs out
         }
     }
    }
  
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        restartGame()
    }
    
    @IBAction func buttonhighScorepressed(_ sender: Any) {
        
       if let highScoreVC = storyboard?.instantiateViewController(withIdentifier: "highScoreViewController") {
            highScoreVC.modalPresentationStyle = .fullScreen
            present(highScoreVC, animated: true, completion: nil)
            
        }  
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "button-click", withExtension: "mp3") else {
            print(" No sound found ")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }catch let error {
            print("Faild to play sound: \(error) ")
        }
    }
    
    func gameOverPopUp(isGameOver: Bool){
        let alertTitle = isGameOver ? "Game Over " : "Times up!"
        let alertMessage = isGameOver ? "Better luck next Time! ": "You got \(points) points!"
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let actionTitle = isGameOver ? "OK" : "Play again"
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
    }
    
    func goToStartScreen(){
        if let startVC = storyboard?.instantiateViewController(withIdentifier: "viewcontroller"){
            startVC.modalPresentationStyle = .fullScreen
            present(startVC, animated: true, completion: nil)
        }
           
    }
    func restartGame(){
        pointsLabel.text = "0"
        randomWord()
        countdown()
        
    }
    func gameOver(DidLose: Bool){
        if DidLose{
            gameOverPopUp(isGameOver: true)
            HighScoreFunctions.writeToHighScoreList(score: points)  //DA
        }else {
            gameOverPopUp(isGameOver: false)
        }
    }
   
    
}
