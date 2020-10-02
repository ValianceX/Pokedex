//
//  ViewController.swift
//  Pokedex
//
//  Created by Sydney Karimi on 9/19/20.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var pokedexIconImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pokemonLogoImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startButton.layer.cornerRadius = 10
        startButton.layer.borderWidth = 1.0
        startButton.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
        pokedexIconImage.image = UIImage(named: "pokedex icon.png")
        pokemonLogoImage.image = UIImage(named: "pokemonLogo.png")
    }

    @IBAction func onStartButton(_ sender: Any) {
        performSegue(withIdentifier: "toCollectionSegue", sender: self)
    }
 
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeScreenSegue" {
            let controller = segue.destination as! PokemonDetailsViewController
            controller.pokemon = pokemon
        }
    }
 */
}

