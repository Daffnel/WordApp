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
   
    
    var highScore: [HighScoreHandler] = HighScoreHandler.readHighScoreList()
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
       return  highScore.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        let date = highScore[indexPath.row].date
        let score = highScore[indexPath.row].score
        
        var content = cell.defaultContentConfiguration() // Hämtar default värden 'highScoreCell' kan innehålla 2 text och en bild
        
        content.text = date
        
        switch score{    // mer än 10 poäng få en liten stjärna 
        case 10...:
            content.image = UIImage(named:  "silverStar")
        default:
            content.image = UIImage(named: "emptyImage")
        }
        
        content.secondaryText = String("Antal poäng: \(score)")
        
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
