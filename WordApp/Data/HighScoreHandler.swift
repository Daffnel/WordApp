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

  
    /**
     Creates a url link to the highscore file, checks if the file exists, otherwise it is created.
    
     - Returns: url  link to saved high score file
    */
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
    
    /**
     Creates the High score file.
    
     - Parameter url:  link to high score file
     */
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
        
    
    
    /**
     Reads an high score file as an JSON object, decodes it to object of HighScoreFunctions struct instance.
     If the list exceeds 100 entries all old entrie over 100 is deleted.
    
     - Returns: [HighScoreFunctions]
     */
    static func readHighScoreList()->[HighScoreHandler]{
        
        let url = setFiles()
        
           
        do {
            let data = try Data(contentsOf: url)
            var highScore = try JSONDecoder().decode([HighScoreHandler].self, from: data)
            
            if highScore.count > 100{               //Blir listan längre än 100 poster ta bort den äldsta
                for i in 0...(highScore.count - 100) {
                highScore.remove(at: i)
                }
            }
                
            return highScore
        }catch {
            print("fel vi avkodning \(error)")
            return []
        }
   
    }
    /**
     Saves the high score list into an JSON file adds today's date and current time.
    
     - Parameter score: number of points i game
    */
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
                    print("listan skanas eller något annat knass")
            }
        
        //lägg till nya poäng i listan
        
        currentHighScoreList.append(score)
        
            do {
                let data = try JSONEncoder().encode(currentHighScoreList)
                try data.write(to: url)
                print("Skriver till highscore")
                print(currentHighScoreList)
            }catch {
                print("Fel vi skrivning till highscore")
            }
    }
    /**
     Sorts the highscore list by either highest score or by date.
     
    - Parameters:
            - sortByDate: true, sorting by date else by score
            - highscore: Array of type [HighScoreFunctions]
    - Returns: Array of [HighScoreFunctions]
    */
    
    static func sortHighScoreList(sortByDate: Bool, highScore: [HighScoreHandler]) -> [HighScoreHandler]{
        
        var sortedHighScoreList: [HighScoreHandler]
        
        if(sortByDate){
            sortedHighScoreList = highScore.sorted { $0.date > $1.date}
        } else {
             sortedHighScoreList = highScore.sorted {$0.score > $1.score}  //jämför första elemtet mot det andra
            }
        return sortedHighScoreList
    }
    
    
}
