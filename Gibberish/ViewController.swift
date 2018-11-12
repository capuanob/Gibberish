//
//  ViewController.swift
//  Gibberish
//
//  Created by Bailey Capuano on 11/10/18.
//  Copyright © 2018 CapuanoCodes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    let bundle = CypherBundle()
    private var displayingPlaceholder = true
    private var stack = languageStack()
    
    @IBOutlet weak var btnDrop: UIButton!
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var cypherView: UITextView!
    
    @IBOutlet weak var decypherView: UITextView!
    
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
    @objc func textViewDidChange(_ textView: UITextView) {
      
        if cypherView == textView {
            if let textInput = textView.text {
                permanentData.isEncoding = 1
                decypherView.text = bundle.getType(ofType: btnDrop.currentTitle!, string: textInput)
            }
        } else {
            if let textInput = textView.text {
                permanentData.isEncoding = -1
                cypherView.text = bundle.getType(ofType: btnDrop.currentTitle!, string: textInput)
            }
        }
    }

    @IBAction func createOwnPressed(_ sender: Any) {
         performSegue(withIdentifier: "toLanguage", sender: nil)
    }
    
    func createNewProfile(order arr: [String]) {
        AvailableCyphers.list.append("Custom Profile")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnDrop.setTitle(AvailableCyphers.list[0], for: .normal)
        tblView.isHidden = true
        //setUpTextFields()
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AvailableCyphers.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = AvailableCyphers.list[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnDrop.setTitle("\(AvailableCyphers.list[indexPath.row])", for: .normal)
        textViewDidChange(cypherView)
        animate (toggle: false)
    }
}
