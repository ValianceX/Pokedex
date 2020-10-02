//
//  AdvancedSearchViewController.swift
//  Pokedex
//
//  Created by Sydney Karimi on 9/30/20.
//
import Foundation
import UIKit

class AdvancedSearchViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var type1Button: UIButton!
    @IBOutlet weak var type2Button: UIButton!
    
    @IBOutlet weak var attackMin: UITextField!
    @IBOutlet weak var attackMax: UITextField!
    @IBOutlet weak var defenseMin: UITextField!
    @IBOutlet weak var defenseMax: UITextField!
    @IBOutlet weak var spAttackMin: UITextField!
    @IBOutlet weak var spAttackMax: UITextField!
    @IBOutlet weak var spDefenseMin: UITextField!
    @IBOutlet weak var spDefenseMax: UITextField!
    @IBOutlet weak var healthMin: UITextField!
    @IBOutlet weak var healthMax: UITextField!
    @IBOutlet weak var speedMin: UITextField!
    @IBOutlet weak var speedMax: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    
    var attackMinValue = 0
    var attackMaxValue = 255
    var defenseMinValue = 0
    var defenseMaxValue = 255
    var spAttackMinValue = 0
    var spAttackMaxValue = 255
    var spDefenseMinValue = 0
    var spDefenseMaxValue = 255
    var healthMinValue = 0
    var healthMaxValue = 255
    var speedMinValue = 0
    var speedMaxValue = 255
    var type1Value = ""
    var type2Value = ""
    
    var pokemonTypes = PokemonGenerator.getPokemonTypes()
    var whichButton: String?
    
    func cleanValues() {
        attackMinValue = Int(attackMin.text ?? "") ?? 0
        attackMaxValue = Int(attackMax.text ?? "") ?? 255
        defenseMinValue = Int(defenseMin.text ?? "") ?? 0
        defenseMaxValue = Int(defenseMax.text ?? "") ?? 255
        spAttackMinValue = Int(spAttackMin.text ?? "") ?? 0
        spAttackMaxValue = Int(spAttackMax.text ?? "") ?? 255
        spDefenseMinValue = Int(spDefenseMin.text ?? "") ?? 0
        spDefenseMaxValue = Int(spDefenseMax.text ?? "") ?? 255
        healthMinValue = Int(healthMin.text ?? "") ?? 0
        healthMaxValue = Int(healthMax.text ?? "") ?? 255
        speedMinValue = Int(speedMin.text ?? "") ?? 0
        speedMaxValue = Int(speedMax.text ?? "") ?? 255
        
        
        if (attackMinValue < 0) { attackMinValue = 0 }
        if (defenseMinValue < 0) { defenseMinValue = 0 }
        if (spAttackMinValue < 0) { spAttackMinValue = 0 }
        if (spDefenseMinValue < 0) { spDefenseMinValue = 0 }
        if (healthMinValue < 0) { healthMinValue = 0 }
        if (speedMinValue < 0) { speedMinValue = 0 }
        
        if (attackMaxValue > 255) { attackMaxValue = 255 }
        if (defenseMaxValue > 255) { defenseMaxValue = 255 }
        if (spAttackMaxValue > 255) { spAttackMaxValue = 255 }
        if (spDefenseMaxValue > 255) { spDefenseMaxValue = 255 }
        if (healthMaxValue > 255) { healthMaxValue = 255 }
        if (speedMaxValue > 255) { speedMaxValue = 255 }
    }
    
    func cleanTypes() {
        if (type1Button.titleLabel?.text == "None" || type1Button.titleLabel?.text == "Type 1") {
            type1Value = ""
        } else {
            type1Value = type1Button.titleLabel?.text ?? ""
        }
        
        if (type2Button.titleLabel?.text == "None" || type2Button.titleLabel?.text == "Type 2") {
            type2Value = ""
        } else {
            type2Value = type2Button.titleLabel?.text ?? ""
        }
    }
    
    func createFilters() -> [String:[Int]] {
        cleanValues()
        
        return ["attack": [attackMinValue, attackMaxValue],
                "defense": [defenseMinValue, defenseMaxValue],
                "spAttack": [spAttackMinValue, spAttackMaxValue],
                "spDefense": [spDefenseMinValue, spDefenseMaxValue],
                "health": [healthMinValue, healthMaxValue],
                "speed": [speedMinValue, speedMaxValue]]
    }
    
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        
        pokemonTypes.insert("None", at: 0)
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func type1Pressed(_ sender: Any) {
        if pickerView.isHidden {
            pickerView.isHidden = false
            whichButton = "type1"
        }
    }
    
    @IBAction func type2Pressed(_ sender: Any) {
        if pickerView.isHidden {
            pickerView.isHidden = false
            whichButton = "type2"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return pokemonTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pokemonTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (whichButton == "type1") {
            type1Button.setTitle(pokemonTypes[row], for: .normal)
        } else {
            type2Button.setTitle(pokemonTypes[row], for: .normal)
        }
        pickerView.isHidden = true
        pickerView.selectRow(0, inComponent: 0, animated: false)
    }
    
    @IBAction func onFilterButton(_ sender: Any) {
        performSegue(withIdentifier: "toHomeSegue", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeSegue" {
            let controller = segue.destination as! PokemonGridViewController
            controller.filterName = nameTextField.text ?? ""
            let filters = createFilters()
            controller.filters = filters
            cleanTypes()
            controller.filterType1 = type1Value
            controller.filterType2 = type2Value
        }
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
