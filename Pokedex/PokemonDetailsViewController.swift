//
//  PokemonDetailsViewController.swift
//  Pokedex
//
//  Created by Sydney Karimi on 9/22/20.
//

import UIKit

class PokemonDetailsViewController: UIViewController {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var indexNumberLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    @IBOutlet weak var statsHeaderLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var spAttackLabel: UILabel!
    @IBOutlet weak var spDefenseLabel: UILabel!
    @IBOutlet weak var healthLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var evolvesFromLabel: UILabel!
    @IBOutlet weak var evolvesIntoLabel: UILabel!
    @IBOutlet var detailScreenView: UIView!
    
    
    
    var pokemon: Pokemon! = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailScreenView.backgroundColor = PokemonGenerator.getColor(type: pokemon.types[0].rawValue)
        
        let imageUrlString = pokemon.imageUrl
        let imageUrl:URL = URL(string: imageUrlString) ?? URL(string: PokemonGenerator.getBackupImageString()) as! URL
        pokemonImageView.loadImage(withUrl: imageUrl)
        
        
        let types = pokemon.types
        var typeString = ""
        if types.count == 1 {typeString = types[0].rawValue}
        else if types.count == 2 {typeString = types[0].rawValue + "/" + types[1].rawValue}

        
        
        indexNumberLabel.text = String(pokemon.id)
        pokemonNameLabel.text = pokemon.name
        pokemonTypeLabel.text = typeString
        //implement the thingy for the image
        attackLabel.text = "Attack: " + String(pokemon.attack)
        defenseLabel.text = "Defense: " + String(pokemon.defense)
        spAttackLabel.text = "Sp. Att.: " + String(pokemon.specialAttack)
        spDefenseLabel.text = "Sp. Def.: " + String(pokemon.specialDefense)
        healthLabel.text = "Health: " + String(pokemon.health)
        speedLabel.text = "Speed: " + String(pokemon.speed)
        totalLabel.text = "Total: " + String(pokemon.total)
        //iimplement evolvesFromLabel
        //implement evolvesIntoLabel

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIImageView {
    func loadImage(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}
