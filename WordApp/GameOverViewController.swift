//
//  GameOverViewController.swift
//  WordApp
//
//  Created by Jeanette Norberg on 2025-03-26.
//
import AVFoundation
import UIKit

class GameOverViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var usedLifeLabel: UILabel!
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var poinstLabel: UILabel!
    @IBOutlet var highScoreButton: UIButton!
    
    var score: Int = 0 // receivs points from gameViewController
    var leftlives: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        poinstLabel.text = " \(score) points"
        poinstLabel.font = UIFont.systemFont(ofSize: 50)
        
        usedLifeLabel.text = createLifeEmoji(lives: leftlives)
        
        let highScores = HighScoreHandler.readHighScoreList()
        
        if let highestScore = highScores.map({ $0.score }).max() {
               bestScoreLabel.text = "\(highestScore) points"
           } else {
               bestScoreLabel.text = "No high scores yet"
           }
        bestScoreLabel.font = UIFont.systemFont(ofSize: 40)

    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        playSound(named: "button-click")
        if let startVC = storyboard?.instantiateViewController(withIdentifier: "viewcontroller")  {
            startVC.modalPresentationStyle = .fullScreen
            present(startVC, animated: true, completion: nil)
        }
    }
    
    func playSound(named soundName: String) {
        let isSoundOn = UserDefaults.standard.bool(forKey: "soundIn")
        if !isSoundOn{
            return
        }

        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
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
    
    func createLifeEmoji(lives: Int) -> String {
        switch lives {
        case 3:
            return "❤️❤️❤️"
        case 2:
            return "❤️❤️"
        case 1:
            return "❤️"
        default:
            return "☠️" // No more lives left
        }
    }
   
    @IBAction func buttonShowHighScore(_ sender: Any) {
    
            playSound(named: "button-click")
           if let highScoreVC = storyboard?.instantiateViewController(withIdentifier: "highScoreViewController") {
                highScoreVC.modalPresentationStyle = .fullScreen
                present(highScoreVC, animated: true, completion: nil)
                
            }
        }
}
