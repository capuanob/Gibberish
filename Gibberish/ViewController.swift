//
//  ViewController.swift
//  Gibberish
//
//  Created by Bailey Capuano on 11/10/18.
//  Copyright © 2018 CapuanoCodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let bundle = CypherBundle()
    
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var cypherTextField: UITextField!
    
    @IBOutlet weak var decypherTextField: UITextField!
    
    @IBAction func onClickDropButton(_ sender: Any) {
        tblView.isHidden ? animate(toggle: true) : animate(toggle: false)
    }
    
    //Allows for opening and closing of cipher-selection menu
    func animate(toggle: Bool) {
        if toggle {
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.tblView.isHidden = true
            }
        }
    }
    
    //Selector for live decoding / encoding
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let textInput = textField.text {
            let getType = bundle.getType(ofType: btnDrop.currentTitle!, string: textInput)
            
            if getType == "segue" { performSegue(withIdentifier: "toLanguage", sender: nil) }
            decypherTextField.text = getType
        }
    }
    
    
    func setUpTextFields() {
        
        //Allows cyphered text to be written live in decypher text field.
         cypherTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.isHidden = true
        setUpTextFields()
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bundle.availableCyphers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = bundle.availableCyphers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(bundle.availableCyphers[indexPath.row])", for: .normal)
        textFieldDidChange(cypherTextField)
        animate (toggle: false)
    }
}
