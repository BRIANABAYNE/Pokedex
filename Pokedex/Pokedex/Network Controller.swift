//
//  Network Controller.swift
//  Pokedex
//
//  Created by Briana Bayne on 6/15/23.
//

import Foundation


@available(iOS 16.0, *)
class NetworkController {
    
    func fetchPokedex(with searchTerm: String, completion: @escaping(Pokedex?) -> Void) {
        // Base URL
        guard let baseURL = URL(string:"https://pokeapi.co/api/v2/") else {completion(nil); return}
        let finalURL = baseURL.appending(path: "/pokemon/\(searchTerm)")
        
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
                
                // Data task with url
            }
        }.resume()
    }
    
    func fetchSpriteImage() {
        
    }
    
    
}



