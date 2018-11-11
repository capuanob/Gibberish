//
//  LanguageViewController.swift
//  Gibberish
//
//  Created by Bailey Capuano on 11/10/18.
//  Copyright © 2018 CapuanoCodes. All rights reserved.
//

import UIKit

struct permanentData {
     static var chosenCiphers = [String]()
     static var selectIndex = 0
     static var isEncoding = 1
}

class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    let placeholder = ["Currently in development,", "Come back soon!"]
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeholder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = placeholder[indexPath.row]
        return cell
    }
  
    
    @IBAction func done(_ sender: Any) {
        performSegue(withIdentifier: "goHome", sender: nil)
    }
    
    @IBAction func trash(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

