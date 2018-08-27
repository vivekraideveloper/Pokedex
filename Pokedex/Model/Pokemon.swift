//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vivek Rai on 27/08/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    
    private var _name: String!
    private var _pokedexId : Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoTxt: String!
    private var _pokemonURL: String!
    
    var name : String{
        return _name
    }
    
    var pokedexId : Int{
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "https://pokeapi.co/api/v2/pokemon/\(self.pokedexId)/"
    }
    
    func downloadPokemonDetail(completed: DownloadComplete) {
        Alamofire.request(_pokemonURL, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("Sucess! Got the Pokemon data")
                    print(response.result.value!)
                   
                    
                } else {
                    print("Error Ocurred: \(String(describing: response.result.error))")
                }
        }
    }
}
