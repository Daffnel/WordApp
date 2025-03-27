//
//  HighScoreFunctions.swift
//  WordApp
//
//  Created by Daniel A on 2025-03-25.
//

import Foundation

struct HighScoreHandler: Decodable, Encodable{
    
    let date: String
    let time: String
    let score: Int

    // Sätta upp alla fil parametrar kolla om vi har en highscore lista annars skapa en
    static func setFiles()-> URL{
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let url = documentDirectory.appendingPathComponent("scores.json") // Skapa en skrivbar sökväg
    
        //Finns det en highscore lista eller behöver vi skapa en ny?
        if !fileManager.fileExists(atPath: url.path){
            makeHighscorefile(url: url)
            return url
        }
        return url
    }
    
    static func makeHighscorefile(url: URL){
     
        let emptyArray : [HighScoreHandler] = [] //     // tom JSON struktur

        do {
            let data = try JSONEncoder().encode(emptyArray)
                try data.write(to: url)
                print("Skapade en ny highscore-fil!")
            } catch {
                print("Fel vid skapande av highscore-fil: \(error)")
            }
        }
        
    
    
    
    
    

    static func readHighScoreList()->[HighScoreHandler]{
        
        let url = setFiles()
        
           
        do {
            let data = try Data(contentsOf: url)
            let highScore = try JSONDecoder().decode([HighScoreHandler].self, from: data)
            return highScore
        }catch {
            print("fel vi avkodning \(error)")
            return []
        }
   
    }
    
    static func writeToHighScoreList(score: Int){
        
        let url = setFiles()
        
        print(url)
        
        let dateFormatter = DateFormatter()
        let timeFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        timeFormatter.dateFormat = "HH:mm:ss"
        
        let time = timeFormatter.string(from: Date())
        let date = dateFormatter.string(from: Date())
        
        
      
        let score = HighScoreHandler(date: date, time: time, score: score)
        
        var currentHighScoreList: [HighScoreHandler] = []
            
        //Läs in den nuvarande listan så att den skrivs över med nya värden
        
        do {
            let data = try Data(contentsOf: url)
            currentHighScoreList = try JSONDecoder().decode([HighScoreHandler].self, from: data)
            } catch {
                    print("listan skanas eller något anat knass")
            }
        
        //lägg till nya poäng i listan
        
        currentHighScoreList.append(score)
        
            do {
                let data = try JSONEncoder().encode(currentHighScoreList)
                try data.write(to: url)
                print("Skriver till highscore")
                print(currentHighScoreList)
            }catch {
                print("Fel vi skrvining till highscore")
            }
    }
        
        
        
    
    
}
