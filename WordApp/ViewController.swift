//
//  ViewController.swift
//  WordApp
//
//  Created by David Kalitzki on 2025-03-24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var swedenFlag: UILabel!
   
    @IBOutlet weak var englishFlag: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loggo image
        let imageView = UIImageView()
        imageView.image = UIImage(named: "WordApp-loggo")
        imageView.frame = CGRect(x: 100, y: 30, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        swedenFlag.text = " 🇸🇪 "
        englishFlag.text = " 🇬🇧 "
       
        
        
    }

   
  
    
}

