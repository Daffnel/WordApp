//
//  ViewController.swift
//  WordApp
//
//  Created by David Kalitzki on 2025-03-24.
//
import AVFoundation

import UIKit

class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
   
    @IBOutlet var button: UIButton!

    @IBOutlet weak var englishFlag: UILabel!
    
    @IBOutlet weak var swedishFlag: UILabel!
    
    @IBOutlet weak var boatIcon: UIButton!
    
    var  words = EnglishAndSwedishWord()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        swedishFlag.text = "🇬🇧  👉🏼  🇸🇪"
       // englishFlag.text = " 👈🏼 🇬🇧"
        
    }
    
    @IBAction func aboutButton(_ sender: Any) {
        playSound()
        if let aboutVC = storyboard?.instantiateViewController(withIdentifier: "aboutViewController") {
            aboutVC.modalPresentationStyle = .fullScreen
            present(aboutVC, animated: true, completion: nil) 
        }
    }
    @IBAction func buttonClick(_ sender: Any) {
        playSound()
       // let dictionaryType = DictionaryType.sailing
       // let displayWord = words.getRandomEnglishWord(dictionaryType)
       
        
        
    //    englishWordLabel.text =  displayWord?.english
        
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
    
    
    @IBAction func boatButton(_ sender: UIButton) {
        boatIcon.alpha = 0.5
    }
    
    
    @IBAction func computerButton(_ sender: UIButton) {
    }
    
    
    @IBAction func natureButton(_ sender: UIButton) {
    }
    
    @IBAction func foodButton(_ sender: UIButton) {
    }
    
    
}

