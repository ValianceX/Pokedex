//
//  PokemonGenerator.swift
//  Pokedex
//
//  Created by SAMEER SURESH on 9/25/16.
//  Updated by ANMOL PARANDE on 01/25/2020
//  Copyright © 2020 mdn. All bights reserved.
//

import Foundation
import UIKit

class PokemonGenerator {
    
    static func getPokemonTypes() -> [String] {
        return ["Bug", "Grass", "Dark", "Ground", "Dragon", "Ice", "Electric", "Normal", "Fairy", "Poison", "Fighting", "Psychic", "Fire", "Rock", "Flying", "Steel", "Ghost", "Water", "Unknown"]
    }
    
    static func getColor(type:String) -> UIColor {
        let colors = ["Bug": UIColor.init(red: 114/255, green: 148/255, blue: 81/255, alpha: 1),
                  "Grass": UIColor.init(red: 89/255, green: 171/255, blue: 82/255, alpha: 1),
                  "Dark": UIColor.init(red: 64/255, green: 51/255, blue: 30/255, alpha: 1),
                  "Ground": UIColor.init(red: 148/255, green: 123/255, blue: 81/255, alpha: 1),
                  "Dragon": UIColor.init(red: 85/255, green: 53/255, blue: 181/255, alpha: 1),
                  "Ice": UIColor.init(red: 149/255, green: 234/255, blue: 237/255, alpha: 1),
                  "Electric": UIColor.init(red: 247/255, green: 221/255, blue: 89/255, alpha: 1),
                  "Normal": UIColor.init(red: 173/255, green: 153/255, blue: 147/255, alpha: 1),
                  "Fairy": UIColor.init(red: 237/255, green: 123/255, blue: 199/255, alpha: 1),
                  "Poison": UIColor.init(red: 142/255, green: 35/255, blue: 253/255, alpha: 1),
                  "Fighting": UIColor.init(red: 148/255, green: 61/255, blue: 30/255, alpha: 1),
                  "Psychic": UIColor.init(red: 209/255, green: 54/255, blue: 127/255, alpha: 1),
                  "Fire": UIColor.init(red: 184/255, green: 42/255, blue: 42/255, alpha: 1),
                  "Rock": UIColor.init(red: 173/255, green: 154/255, blue: 90/255, alpha: 1),
                  "Flying": UIColor.init(red: 165/255, green: 161/255, blue: 199/255, alpha: 1),
                  "Steel": UIColor.init(red: 133/255, green: 133/255, blue: 133/255, alpha: 1),
                  "Ghost": UIColor.init(red: 105/255, green: 73/255, blue: 138/255, alpha: 1),
                  "Water": UIColor.init(red: 38/255, green: 116/255, blue: 212/255, alpha: 1),
                  "Unknown": UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)]
        return colors[type]!
    }
    
    static func getBackupImageString() -> String {
        return "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/12ecb7ae-7059-48df-a4f8-2e3fb7858606/d47rmjf-de88a574-49c8-4dcf-9df4-7e11722e8bec.png/v1/fill/w_454,h_340,q_80,strp/who_s_that_pokemon__by_amitlu89_d47rmjf-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3siaGVpZ2h0IjoiPD0zNDAiLCJwYXRoIjoiXC9mXC8xMmVjYjdhZS03MDU5LTQ4ZGYtYTRmOC0yZTNmYjc4NTg2MDZcL2Q0N3JtamYtZGU4OGE1NzQtNDljOC00ZGNmLTlkZjQtN2UxMTcyMmU4YmVjLnBuZyIsIndpZHRoIjoiPD00NTQifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.h30ApRqrtJHs1_YpIQAGAoNuAlHr5D9vfR4H0mpyQEQ"
    }
    
    static func getPokemonArray() -> [Pokemon] {
        guard let path = Bundle.main.path(forResource: "pokemons", ofType: "json") else { print("Couldn't find Pokemon filepath")
            return []
        }
        guard let jsonData = try? NSData(contentsOfFile: path) as Data else {
            print("Couldn't load file")
            return []
        }
        
        let decoder = JSONDecoder()
        
        // Generally this is bad practice, but we need this decoding for the app to load, and the force unwrap will tell us why the error is occurring
        return try! decoder.decode([Pokemon].self, from: jsonData)
    }
}
