//
//  NewEmojiTableViewController.swift
//  EmojiProject
//
//  Created by Utku Çetinkaya on 23.08.2022.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {

    // MARK: - UI Elements
    
    @IBOutlet var symbolTextField : UITextField!
    @IBOutlet var nameTextField : UITextField!
    @IBOutlet var descriptionTextField : UITextField!
    @IBOutlet var usageTextField : UITextField!

    // MARK: - Properties
    var emoji: Emoji?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
        }
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let symbol = symbolTextField.text!
        let name = nameTextField.text!
        let description = descriptionTextField.text!
        let usage = usageTextField.text!
        
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }
}
