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
    @IBOutlet weak var swedishFlag: UILabel!
    @IBOutlet weak var boatIcon: UIButton!
    @IBOutlet weak var computerIcon: UIButton!
    @IBOutlet weak var natureIcon: UIButton!
    @IBOutlet weak var foodIcon: UIButton!
    @IBOutlet weak var soundOnOff: UISwitch!
    @IBOutlet var sliderPlaytime: UISlider!
    @IBOutlet var labelSliderPlaytime: UILabel!
    
    var  words = EnglishAndSwedishWord()
    var translateToSwedish: Bool = true
    var dictionaryType: DictionaryType = .sailing
    let segueId = "startGameSegue"
    var guesstime: Int = 0
    let timerStartTime = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        swedishFlag.text = "🇬🇧  👉🏼  🇸🇪"
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(flagTapped))
        swedishFlag.isUserInteractionEnabled = true
        swedishFlag.addGestureRecognizer(tapGesture)
        
        let isSoundOn = UserDefaults.standard.bool(forKey: "soundOn")
               soundOnOff.isOn = isSoundOn
        
        initializeSlider()
        
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
        if let gameVC = storyboard?.instantiateViewController(withIdentifier: "gameViewController") as? GameViewController {
            gameVC.translateToSwedish = translateToSwedish // Send translation direction
            navigationController?.pushViewController(gameVC, animated: true)
            print(guesstime)
        }
        performSegue(withIdentifier: segueId, sender: self)
    }
    
    @IBAction func soundOnOff(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "soundOn")
    }
    
    func playSound() {
        // check if user wanted sound by switch
        let isSoundOn = UserDefaults.standard.bool(forKey: "soundOn") // sounds on
        
        if !isSoundOn {
            return   // sounds off
        }
        // get sound if user wanted sound
        guard let url = Bundle.main.url(forResource: "button-click", withExtension: "mp3") else {
            print(" No sound found ")
            return
        }
        
        do {
            //play sound
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }catch let error {
            print("Failed to play sound: \(error) ")
        }
    }
    
    @objc func flagTapped() {
        //Switch languege
        translateToSwedish.toggle()
        
        // update label
        if translateToSwedish {
            swedishFlag.text = "🇬🇧  👉🏼  🇸🇪"
        } else {
            swedishFlag.text = "🇬🇧  👈🏼  🇸🇪"
        }
        
        // Save users choise
        UserDefaults.standard.set(translateToSwedish, forKey: "translationDirection")
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
                destination.translateToSwedish = translateToSwedish
            }
        }
    }
    
    @IBAction func timeSlider(_ sender: UISlider) {
        
        let seconds = Int(round(sliderPlaytime.value / 5) * 5)
        
        guesstime = seconds
        
        UserDefaults.standard.set(seconds, forKey: "gameTime")
        labelSliderPlaytime.text = "\(seconds) seconds to guess"
        
    }
    
    func initializeSlider(){
        sliderPlaytime.maximumValue = 120
        sliderPlaytime.minimumValue = 1
        sliderPlaytime.isContinuous = true
        sliderPlaytime.value = Float(timerStartTime)
        labelSliderPlaytime.text = "\(timerStartTime) seconds to guess"

    }
}
