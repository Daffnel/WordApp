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
    
    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var poinstLabel: UILabel!
    
    var score: Int = 0 // receivs points from gameViewController
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        poinstLabel.text = " \(score) points"
        poinstLabel.font = UIFont.systemFont(ofSize: 50)
        
        // lägg till highscore här!
        bestScoreLabel.text = "points"
        bestScoreLabel.font = UIFont.systemFont(ofSize: 30)
        

    }
    

    @IBAction func playAgainButton(_ sender: UIButton) {
        playSound(named: "button-click")
        if let startVC = storyboard?.instantiateViewController(withIdentifier: "viewcontroller")  {
            startVC.modalPresentationStyle = .fullScreen
            present(startVC, animated: true, completion: nil)
        }
    }
    
    func playSound(named soundName: String) {
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
   
}
