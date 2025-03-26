//
//  HighScoreViewController.swift
//  WordApp
//
//  Created by Daniel A on 2025-03-25.
//

import Foundation
import UIKit

class HighScoreViewController: UIViewController,
                               UITableViewDataSource,
                               UITableViewDelegate{
    
    @IBOutlet var tableView: UITableView!
   
    
    var highScore: [HighScoreFunctions] = HighScoreFunctions.readHighScoreList()
    
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
       return  highScore.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        let date = highScore[indexPath.row].date
        let score = highScore[indexPath.row].score
        
        var content = cell.defaultContentConfiguration() // Hämtar default värden 'highScoreCell' kan innehålla 2 text och en bild
        
        content.text = date
        
        switch score{
        case 0..<50:
            content.image = UIImage(systemName: "cloud.rain")
        case 50..<100:
            content.image = UIImage(systemName: "cloud.sun")
        case 100...:
            content.image = UIImage(systemName: "sun.max")
        default:
            content.image = UIImage(systemName: "face.smile")
        }
        
        content.secondaryText = String("Antal poäng: \(score)")
        
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
