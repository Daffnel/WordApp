//
//  AboutViewController.swift
//  WordApp
//
//  Created by Jeanette Norberg on 2025-03-25.
//
import AVFoundation

import UIKit

class AboutViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer?

    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var goodLuck: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goodLuck.text = "Good Luck! ⭐️"
        aboutTextView.textColor = .black
        aboutTextView.text = " You choose time for each game, and which direction you want to translate, English -> Swedish or Swedish -> English, you provide the correct translation within the time limit, you earn points and move on to the next word, if you fail to translate a word before time runs out, you lose one life and one point. Start the game with three lives, the game ends when you run out of lives, or time runs out and every word is correct. Try to get the highest score possible!"
       
        
    }

    @IBAction func backButton(_ sender: UIButton) {
        playSound()
        dismiss(animated: true, completion: nil)
    }
    func playSound(){
        // check if user wanted sound or not
        let isSoundOn = UserDefaults.standard.bool(forKey: "soundOn")
        if !isSoundOn{
            return  // sounds off
        }
        // get sound
        guard let url = Bundle.main.url(forResource: "button-click", withExtension: "mp3") else {
            print("Sound file not founf")
            return
        }
        do {
            //play sound
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }catch let error {
            print("Faild to play sound: \(error) ")
        }
        
    }
    

}
