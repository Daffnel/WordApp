//
//  HighScoreFunctions.swift
//  WordApp
//
//  Created by Daniel A on 2025-03-25.
//

import Foundation

struct HighScoreFunctions: Decodable{
    
    let date: String
    let time: String
    let score: Int
    
    
    static func readHighScoreList()->[HighScoreFunctions]{
        guard let url = Bundle.main.url(forResource: "highscorelist", withExtension: "json") else {
            print("Highscore lista inte funnen")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let highScore = try JSONDecoder().decode([HighScoreFunctions].self, from: data)
            return highScore
        } catch {
            print("fel vi avkodning \(error)")
            return []
        }
    }
    
}
