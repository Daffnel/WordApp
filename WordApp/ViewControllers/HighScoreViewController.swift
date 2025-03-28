//
//  HighScoreViewController.swift
//  WordApp
//
//  Created by Daniel A on 2025-03-25.
//

import Foundation
import UIKit
import AVFoundation


class HighScoreViewController: UIViewController,
                               UITableViewDataSource,
                               UITableViewDelegate{
    
    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var buttonHome: UIButton!
    @IBOutlet var buttonSortList: UIButton!
    
    var sortedTurn: Bool = false
    var highScore: [HighScoreHandler] = HighScoreHandler.readHighScoreList()
    var sortedHighScoreList: [HighScoreHandler] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       sortedHighScoreList = HighScoreHandler.sortHighScoreList(turn: sortedTurn, highScoreList: highScore)
        tableView.reloadData()
        
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
    
    // swipe left to remove a cell record
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
            
        if editingStyle == .delete {
            sortedHighScoreList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    @IBAction func buttonHome(_ sender: Any) {
        playSound()
        if let homeVC = storyboard?.instantiateViewController(withIdentifier: "viewcontroller") {
            homeVC.modalPresentationStyle = .fullScreen
            present(homeVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonSortList(_ sender: Any) {
        playSound()
        sortedTurn.toggle()
        viewDidLoad()
    
    }
    
    func playSound(){
        //check if user wants sound
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
            // play sound
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }catch let error {
            print("Faild to play sound: \(error) ")
        }
        
    }
    
    
    
    
}
