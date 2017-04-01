//
//  Parser.swift
//  Platimi
//
//  Created by Božidar on 28/03/2017.
//  Copyright © 2017 Božidar. All rights reserved.
//

import SwiftyJSON
class Parser {

    func parseTest(json: JSON) -> [Pokemon]? {
        var pokemons = [Pokemon]()
        if let jsonPokemons = json["results"].array {
            for pokemon in jsonPokemons {
                pokemons.append(Pokemon(name: pokemon["name"].string, url: pokemon["url"].string))
            }
        }
        return pokemons
    }
    
}
