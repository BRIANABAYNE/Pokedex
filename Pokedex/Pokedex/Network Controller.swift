//
//  Network Controller.swift
//  Pokedex
//
//  Created by Briana Bayne on 6/15/23.
//

import Foundation
import UIKit

@available(iOS 16.0, *)
class NetworkController {
    
    func fetchPokedex(with searchTerm: String, completion: @escaping(Pokedex?) -> Void) {
        // Base URL
        guard let baseURL = URL(string:"https://pokeapi.co/api/v2/") else {completion(nil); return}
        let finalURL = baseURL.appending(path: "/pokemon/\(searchTerm)")
        
        // Data task with url
        URLSession.shared.dataTask(with: finalURL) { pokedexData, _, error in
            
            if let error {
                print("Encounted Error!", error.localizedDescription)
                completion(nil)
            }
            
            guard let data = pokedexData else {completion(nil); return}
            
            do {
                
                guard let topLevelDict = try JSONSerialization.jsonObject(with: data) as? [String:Any] else {completion(nil); return}
                let pokedex = Pokedex(topLevelDictonary: topLevelDict)
                completion(pokedex)
            } catch {
                print("Not perfect", error.localizedDescription)
                completion(nil)
                
            }
        }.resume()
    }
    
    func fetchSpriteImage(pokemon: Pokedex, completion: @escaping (UIImage?) -> Void) {
        
        guard let imageURL = URL(string: pokemon.spritePath) else {completion(nil); return }
        
        URLSession.shared.dataTask(with: imageURL) { data,  _, error in
            
            if let error {
                print("Encounted Error!", error.localizedDescription)
                completion(nil)
            }
            
            
            guard let data = data else {completion(nil); return}
            
            let spriteImage = UIImage(data: data)
            completion(spriteImage)
            
        }.resume()
        
        
        
        
        
    }
}
