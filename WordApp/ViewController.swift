//
//  ViewController.swift
//  WordApp
//
//  Created by David Kalitzki on 2025-03-24.
//

import UIKit
/*Andra filen jag ändrar i för att test github*/

class ViewController: UIViewController {

    @IBOutlet var englishWordLabel: UITextField!
    @IBOutlet var button: UIButton!

    var  words = EnglishAndSwedishWord()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func buttonClick(_ sender: Any) {
        
       
        
        let dictionaryType = DictionaryType.sailing
        let displayWord = words.getRandomEnglishWord(dictionaryType)
       
        
        
        englishWordLabel.text =  displayWord?.english
        
    }
    
}

