//
//  PokemonDetailViewController.swift
//  Pokedex
//  
//  Created by Vivek Rai on 27/08/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    var pokemon: Pokemon!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var weightlabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var lookLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = pokemon.name.capitalized
        
        let img = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = img
        
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
        
        
    }
    
    func updateUI() {
        
        baseAttackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        weightlabel.text = pokemon.weight
        heightLabel.text = pokemon.height
        typeLabel.text = pokemon.type.capitalized
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        descriptionLabel.text = pokemon.description.capitalized
        getImage(_url: pokemon.firstImageUrl, imageview: currentEvoImage)
        getImage(_url: pokemon.secondImageUrl, imageview: nextEvoImage)
        lookLabel.text = pokemon.name.capitalized+" Front and Back Look"
       
    }
    
    func getImage(_url: String, imageview: UIImageView){
        if let url: URL = URL(string: _url){
            let session = URLSession.shared
            let task = session.dataTask(with: url, completionHandler: {
                (data, response, error) in
                if data != nil{
                    let image = UIImage(data: data!)
                    if image != nil {
                        DispatchQueue.main.async(execute: {
                            imageview.image = image
                        })
                    }
                }
            })
            task.resume()
            
        }
       
    }
    
    
    
    
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
       
    }
    
    
}
