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
    
    @IBOutlet weak var computerIcon: UIButton!
    
    @IBOutlet weak var natureIcon: UIButton!
    
    @IBOutlet weak var foodIcon: UIButton!
    
    
    var  words = EnglishAndSwedishWord()
    
    var dictionaryType: DictionaryType = .sailing
    
    let segueId = "startGameSegue"
    
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
        performSegue(withIdentifier: segueId, sender: self)

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
        
        dictionaryType = .sailing
        
        boatIcon.alpha = 1
        computerIcon.alpha = 0.3
        natureIcon.alpha = 0.3
        foodIcon.alpha = 0.3
    }
    
    
    @IBAction func computerButton(_ sender: UIButton) {
        
        dictionaryType = .computer
        
        boatIcon.alpha = 0.3
        computerIcon.alpha = 1
        natureIcon.alpha = 0.3
        foodIcon.alpha = 0.3
    }
    
    
    @IBAction func natureButton(_ sender: UIButton) {
        
        dictionaryType = .nature
        
        boatIcon.alpha = 0.3
        computerIcon.alpha = 0.3
        natureIcon.alpha = 1
        foodIcon.alpha = 0.3
    }
    
    @IBAction func foodButton(_ sender: UIButton) {
        
        dictionaryType = .cooking
        
        boatIcon.alpha = 0.3
        computerIcon.alpha = 0.3
        natureIcon.alpha = 0.3
        foodIcon.alpha = 1
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.identifier == segueId{
    
                if let destination = segue.destination as?
                    GameViewController{
                    
                    destination.dictionaryType = dictionaryType
                    
                }
    
            }
        }
    
}

