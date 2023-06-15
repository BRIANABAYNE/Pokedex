//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Karl Pfister on 2/3/22.
//

import UIKit

@available(iOS 16.0, *)
class PokemonViewController: UIViewController {

    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonSpriteImageView: UIImageView!
    @IBOutlet weak var pokemonMovesTableView: UITableView!
    
    // property
    var pokemon: Pokedex?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonMovesTableView.dataSource = self
        pokemonSearchBar.delegate = self

    }
    func updateUI(with image: UIImage) {
        guard let pokemon = pokemon else { return }
        DispatchQueue.main.async {
            self.pokemonSpriteImageView.image = image
            self.pokemonMovesTableView.reloadData()
            self.pokemonNameLabel.text = pokemon.name
            self.pokemonIDLabel.text = "\(pokemon.id)"
        }
    }
}// End


@available(iOS 16.0, *)
extension PokemonViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon?.moves.count ?? 0 // Nil- coalecing
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moveCell", for: indexPath)
        
        cell.textLabel?.text = pokemon?.moves[indexPath.row]
        
        return cell
    }
}


@available(iOS 16.0, *)
extension PokemonViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkController().fetchPokedex(with: searchText) { pokedex in
            guard let pokedex = pokedex else {return}
            self.pokemon = pokedex
            NetworkController().fetchSpriteImage(pokemon: pokedex) { image in
                guard let image = image else {return}
                self.updateUI(with: image)
            }
           
            
        }
    }
}

