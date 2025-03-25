//
//  Dictionary.swift
//  WordApp
//
//  Created by Daniel A on 2025-03-24.
//

import Foundation


enum DictionaryType{
    case simple
    case computer
    case nature
    case cooking
    case sailing
}

struct EnglishAndSwedishWord: Decodable{   //Decodable protokoll för JSON Hantering
    var english: String = ""
    var swedish: String = ""
    
    
    /**   Läser in orden ifrån en JSON fil och retunerar dessa i en Dictionary variabel
        - Bundel.main är huvudfilsystemet i projektet
        - Data(contentsOf: url) läser in hela fieln i ett Data objekt
        - JSONDecoder().decode([String: String].self, from: data)  skapar en JSONDecoder insatans som avkoads med .decode till en Struct
            - Type vilken av de tre ordlistorna
     */
    func  readWordsFromDictionary(_ type: DictionaryType) -> [EnglishAndSwedishWord]?{
        
        var dictionaryName: String
        
        switch type{
        case .computer:
            dictionaryName = "computer_words"
        case .simple:
            dictionaryName = "word"
        case .nature:
            dictionaryName = "nature"
        case .cooking:
            dictionaryName = "cooking"
        case .sailing:
            dictionaryName = "sailing"
       
        }
        
              
        guard let url = Bundle.main.url(forResource: dictionaryName, withExtension: "json") else {
              print("Filen hittas inte")
               return nil
           }
           
           do {
               let data = try Data(contentsOf: url)
               let words = try JSONDecoder().decode([EnglishAndSwedishWord].self, from: data)
               return words
           } catch {
               print("Fel vid avkodning: \(error)")
               return nil
           }
    }
    
    /**
                Retunerar en Struct med ett slumpmässigt ord på engelska och svenska
     
     */
    func getRandomEnglishWord(_ type: DictionaryType)-> EnglishAndSwedishWord? {
        
        guard let ordlista =  readWordsFromDictionary(type), !ordlista.isEmpty else {
            print("ordlista tom")
            return nil
        }
               
        let randomWord =  ordlista.randomElement()
        return randomWord
       
    }
}

