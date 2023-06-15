//
//  Pokedex.swift
//  Pokedex
//
//  Created by Briana Bayne on 6/15/23.
//

import Foundation

// class needs properties and init
class Pokedex {
    
    let name: String
    let id:Int
    let moves: [String] // goal !! Not matching API
    let spritePath: String
    let height: Int
    
    
    // Designiated Init
    init(name: String, id: Int, moves: [String], spritePath: String, height: Int) {
        self.name = name
        self.id = id
        self.moves = moves
        self.spritePath = spritePath
        self.height = height
        
    }
} // end of class


// MARK: - Extension
extension Pokedex {
    
    convenience init?(topLevelDictonary: [String:Any]) {
        
        guard let name = topLevelDictonary["name"] as? String,
              let id = topLevelDictonary["id"] as? Int,
              let height = topLevelDictonary["height"] as? Int,
              let spriteDict = topLevelDictonary["sprites"] as? [String:Any],
              let spritePath = spriteDict["front_shiny"] as? String,
              let movesArray = topLevelDictonary["moves"] as? [[String:Any]] else {return nil}
        
        var tempMoves: [String] = []  // temp array for moves becasue we are going deeper in the dict
        
        for moves in movesArray {
            guard let moveDict = moves["move"] as? [String:Any],
                  let name = moveDict["name"] as? String else {return nil}
            tempMoves.append(name)
            
        }
        
        self.init(name: name, id: id, moves: tempMoves, spritePath: spritePath, height: height)
        
    }
    
    
}


