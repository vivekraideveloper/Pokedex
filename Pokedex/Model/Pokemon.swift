//
//  Pokemon.swift
//  Pokedex
//
//  Created by Vivek Rai on 27/08/18.
//  Copyright © 2018 Vivek Rai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon{
    
    private var _name: String = ""
    private var _pokedexId : Int = 0
    private var _description: String = ""
    private var _type: String = ""
    private var _defense: String = ""
    private var _height: String = ""
    private var _weight: String = ""
    private var _attack: String = ""
    private var _nextEvoTxt: String = ""
    private var _pokemonURL: String = ""
    private var _firstImageUrl : String = ""
    private var _secondImageUrl : String = ""
    
    var firstImageUrl : String{
        if _firstImageUrl == ""{
            _firstImageUrl = ""
        }
        return _firstImageUrl
    }
    
    var secondImageUrl : String{
        if _secondImageUrl == ""{
            _secondImageUrl = ""
        }
        return _secondImageUrl
    }
    
    
    var description : String{
        if _description == ""{
            _description = ""
        }
        return _description
    }
    
    var type : String{
        if _type == ""{
            _type = ""
        }
        return _type
    }
    
    var defense : String{
        if _defense == ""{
            _defense = ""
        }
        return _defense
    }
    
    var height : String{
        if _height == ""{
            _height = ""
        }
        return _height
    }
    
    var weight : String{
        if _weight == ""{
            _weight = ""
        }
        return _weight
    }
    
    var attack : String{
        if _attack == ""{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoTxt : String{
        if _nextEvoTxt == ""{
            _nextEvoTxt = ""
        }
        return _nextEvoTxt
    }
    
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
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        
       
                    
        Alamofire.request(self._pokemonURL, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    print("Sucess! Got the Pokemon data")
                    print(response.result.value!)
                    
                    let json : JSON = JSON(response.result.value!)
                    
//                    Weight
                    if let weight = json["weight"].int{
                        self._weight = "\(weight)"
                    }
                    
//                    Height
                    if let height = json["height"].int{
                        self._height = "\(height)"
                    }
                    
//                    Attack
                    if let attack = json["base_experience"].int{
                        self._attack = "\(attack)"
                    }
                    
//                    Defense
                    if let defense = json["order"].int{
                        self._defense = "\(defense)"
                    }
                    
//                    Types
                    if let types = json["types"][0]["type"]["name"].string{
                        self._type = types
                        
                    }
                    if json["types"].count > 1{
                        for x in 1..<json["types"].count{
                            if let name = json["types"][x]["type"]["name"].string{
                                self._type += "/\(name.capitalized)"
                            }
                        }
                    }else{
                        self._type = "Normal"
                    }
                    
//                    Abilities
                    if let ability = json["abilities"][0]["ability"]["name"].string{
                        self._description = ability
                        
                    }
                    if json["abilities"].count > 1{
                        for x in 1..<json["abilities"].count{
                            if let name = json["abilities"][x]["ability"]["name"].string{
                                self._description += "/\(name.capitalized)"
                            }
                        }
                    }else{
                        self._description = "No Abilities Found"
                    }
                    
//                    Image Url
                    if let firstImageUrl = json["sprites"]["front_default"].string{
                        self._firstImageUrl = firstImageUrl
                    }
                    if let secondImageUrl = json["sprites"]["back_default"].string{
                        self._secondImageUrl = secondImageUrl
                    }
        
                    
                    print("Prinitng Details!")
                    print(self._weight)
                    print(self._height)
                    print(self._type)
                    print(self._description)
                   
                    
                } else {
                    print("Error Ocurred: \(String(describing: response.result.error))")
                }
                completed()
        }
    }
}

