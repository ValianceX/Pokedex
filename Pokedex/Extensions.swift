//
//  Extensions.swift
//  Pokedex
//
//  Created by Sydney Karimi on 9/30/20.
//

import Foundation
import UIKit


extension PokemonGridViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = pokemonCollectionView.bounds
        let heightVal = self.view.frame.height
        let widthVal = self.view.frame.width
        let cellWidth: CGFloat
        let cellsize: CGSize?
        
        if (selectedLayout == 0) {
            cellWidth = (heightVal < widthVal) ? bounds.height/2 : bounds.width/2
            cellsize = CGSize(width: cellWidth - 10, height: cellWidth - 10)
        } else {
            cellWidth = (heightVal < widthVal) ? bounds.height : bounds.width
            cellsize = CGSize(width: cellWidth - 10, height: cellWidth/2 - 10)
        }
        return cellsize!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPokemon = filteredPokemon[indexPath.row]
        performSegue(withIdentifier: "toDetailSegue", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailSegue" {
            let controller = segue.destination as! PokemonDetailsViewController
            controller.pokemon = selectedPokemon
        }
    }
    
}

extension PokemonGridViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        searchBar.endEditing(true)
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let predicateString = searchBar.text!
        displayingPokemon = pokemonArray.filter( {$0.name.contains(predicateString)} )
        displayingPokemon.sort {$0.id < $1.id}
        
        if (predicateString == ""){
            displayingPokemon = filteredPokemon
        }
        
        isSearching = (displayingPokemon.count == 0) ? false: true
        pokemonCollectionView.reloadData()
        
    }
        
}
