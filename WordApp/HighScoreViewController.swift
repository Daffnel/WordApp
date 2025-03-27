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
    
    @IBOutlet var sortSwitch: UISwitch!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var buttonHome: UIButton!
    var highScore: [HighScoreHandler] = HighScoreHandler.readHighScoreList()
    var sortedHighScoreList: [HighScoreHandler] = []
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
            
            sortedHighScoreList = HighScoreHandler.sortHighScoreList(sortByDate: false, highScore: highScore)
        
    }
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    
        return  sortedHighScoreList.count
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        
        let date = sortedHighScoreList[indexPath.row].date
        let score = sortedHighScoreList[indexPath.row].score
        
        var content = cell.defaultContentConfiguration() // Hämtar default värden 'highScoreCell' kan innehålla 2 text och en bild
        
        content.text = date
        
       //mer än 10 poäng vinn en silvestjärna
        switch score{
        case 10...:
            content.image = UIImage(named: "silverStar")
        default:
            content.image = UIImage(named: "emptyImage")
        }
        
        content.secondaryText = String("Antal poäng: \(score)")
        
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    @IBAction func sortedSwitchChanged(_ sender: UISwitch) {
        if sender.isOn{
            print("Switch på")
            sortedHighScoreList = HighScoreHandler.sortHighScoreList(sortByDate: true, highScore: highScore)
            tableView.reloadData()  // ladda om tabelvien
        } else {
            print("Switch av")
            sortedHighScoreList = HighScoreHandler.sortHighScoreList(sortByDate: false, highScore: highScore)
            tableView.reloadData()
        }
    }
    
    @IBAction func ButtonHome(_ sender: Any) {
        if let homeVC = storyboard?.instantiateViewController(withIdentifier:"viewcontroller"){
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true, completion: nil)
        }
        
    }
    
}
