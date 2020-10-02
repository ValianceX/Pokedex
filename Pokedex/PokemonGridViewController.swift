//
//  PokemonGridViewController.swift
//  Pokedex
//
//  Created by Sydney Karimi on 9/29/20.
//

import UIKit

class PokemonGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var advancedSearchButton: UIButton!
    @IBOutlet weak var pokemonCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    //var flowLayout2: UICollectionViewFlowLayout!
    var selectedLayout = 0
    
    @IBOutlet weak var clearButton: UIButton!
    
    let pokemonArray = PokemonGenerator.getPokemonArray()
    var filteredPokemon = PokemonGenerator.getPokemonArray()
    var displayingPokemon: [Pokemon] = []
    var selectedPokemon: Pokemon?
    var isSearching = false
    var filterName = ""
    var filterType1 = ""
    var filterType2 = ""
    var filters = ["attack": [0, 255],
                   "defense": [0, 255],
                   "spAttack": [0, 255],
                   "spDefense": [0, 255],
                   "health": [0, 255],
                   "speed": [0, 255]]
        
    
    func pokemonForIndexPath(for indexPath: IndexPath) -> Pokemon {
        return displayingPokemon[indexPath.row]
    }
    
    func getFilteredPokemon() -> [Pokemon] {
       
        if (filterName != "") {
            filteredPokemon = pokemonArray.filter( {$0.name.lowercased().contains(filterName.lowercased())} )
        }
        
        if (filterType1 != "") {
            filteredPokemon = filteredPokemon.filter( {$0.types[0].rawValue.contains(filterType1)} )
        }
        
        if (filterType2 != "") {
            filteredPokemon = filteredPokemon.filter( {$0.types.count > 1} )
            filteredPokemon = filteredPokemon.filter( {$0.types[1].rawValue.contains(filterType2)} )
        }
        
        filteredPokemon = filteredPokemon.filter{$0.attack > filters["attack"]![0] && $0.attack < filters["attack"]![1]}
        filteredPokemon = filteredPokemon.filter{$0.attack > filters["defense"]![0] && $0.attack < filters["defense"]![1]}
        filteredPokemon = filteredPokemon.filter{$0.attack > filters["spAttack"]![0] && $0.attack < filters["spAttack"]![1]}
        filteredPokemon = filteredPokemon.filter{$0.attack > filters["spDefense"]![0] && $0.attack < filters["spDefense"]![1]}
        filteredPokemon = filteredPokemon.filter{$0.attack > filters["health"]![0] && $0.attack < filters["health"]![1]}
        filteredPokemon = filteredPokemon.filter{$0.attack > filters["speed"]![0] && $0.attack < filters["speed"]![1]}
        
        return filteredPokemon
    }
    
    
    
    override func viewDidLoad() {
        clearButton.layer.cornerRadius = 10
        advancedSearchButton.layer.cornerRadius = 10
        filteredPokemon = getFilteredPokemon()
        displayingPokemon = filteredPokemon
        
        super.viewDidLoad()
        pokemonCollectionView.dataSource = self
        pokemonCollectionView.delegate = self
        
        // Do any additional setup after loading the view.
        
    }
    @IBAction func segmentChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                print("First segmented selected")
                selectedLayout = 0
                pokemonCollectionView.collectionViewLayout.invalidateLayout()
                break
            case 1:
                print("Second segment selected")
                selectedLayout = 1
                pokemonCollectionView.collectionViewLayout.invalidateLayout()
                break
            default:
                print("none")
        }
    }
    
    
    @IBAction func onAdvancedButton(_ sender: Any) {
        performSegue(withIdentifier: "toAdvSearch", sender: Any?.self)
    }
    
    // MARK: - CollectionView Functions
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    @IBAction func onClearButton(_ sender: Any) {
        filteredPokemon = pokemonArray
        displayingPokemon = pokemonArray
        pokemonCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayingPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokemonCell", for: indexPath) as! pokemonCollectionViewCell
        // let cellIndex = indexPath.item
        let cellPokemon = pokemonForIndexPath(for: indexPath)
        pokemonCell.pokemonNameLabel.text = cellPokemon.name
        pokemonCell.pokemonNumberLabel.text = String(cellPokemon.id)
        pokemonCell.backgroundColor = PokemonGenerator.getColor(type: cellPokemon.types[0].rawValue)
        
        let imageUrlString = cellPokemon.imageUrl
        let imageUrl: URL = URL(string: imageUrlString) ?? URL(string: PokemonGenerator.getBackupImageString())!
        pokemonCell.pokemonImageView.loadImage(withUrl: imageUrl)
        
        pokemonCell.contentView.layer.cornerRadius = 10
        pokemonCell.contentView.layer.borderWidth = 1.3
        pokemonCell.contentView.layer.borderColor = UIColor.white.cgColor


        return pokemonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     
        let searchView: UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath)
        return searchView
    }
    
    
}

