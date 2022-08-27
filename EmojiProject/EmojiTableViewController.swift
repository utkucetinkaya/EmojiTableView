//
//  EmojiTableViewController.swift
//  EmojiProject
//
//  Created by Utku Çetinkaya on 17.08.2022.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    // MARK: - Properties
    var emojis: [Emoji] = [
        Emoji(symbol: "😀", name: "Grinning Face",
              description: "A typical smiley face.", usage: "happiness"),
        Emoji(symbol: "😕", name: "Confused Face",
              description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
        Emoji(symbol: "😍", name: "Heart Eyes",
              description: "A smiley face with hearts for eyes.",
              usage: "love of something; attractive"),
        Emoji(symbol: "👮", name: "Police Officer",
              description: "A police officer wearing a blue cap with a gold badge.",
              usage: "person of authority"),
        Emoji(symbol: "🐢", name: "Turtle",
              description: "A cute turtle.",
              usage: "Something slow"),
        Emoji(symbol: "🐘", name: "Elephant",
              description: "A gray elephant.",
              usage: "good memory"),
        Emoji(symbol: "🍝", name: "Spaghetti",
              description: "A plate of spaghetti.",
              usage: "spaghetti"),
        Emoji(symbol: "🎲", name: "Die",
              description: "A single die.",
              usage: "taking a risk, chance; game"),
        Emoji(symbol: "⛺️", name: "Tent",
              description: "A small tent.",
              usage: "camping"),
        Emoji(symbol: "📚", name: "Stack of Books",
              description: "Three colored books stacked on each other.",
              usage: "homework, studying"),
        Emoji(symbol: "💔", name: "Broken Heart",
              description: "A red, broken heart.",
              usage: "extreme sadness"),
        Emoji(symbol: "💤", name: "Snore",
              description: "Three blue \'z\'s.",
              usage: "tired, sleepiness"),
        Emoji(symbol: "🏁", name: "Checkered Flag",
              description: "A black-and-white checkered flag.",
              usage: "completion")
    ]
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEmojiEdit" {
            
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            
            let selectedEmoji = emojis[selectedIndexPath.row]
            
            let navigationController = segue.destination as! UINavigationController
            
            let editEmojiController = navigationController.topViewController as! NewEmojiTableViewController
            
            editEmojiController.emoji = selectedEmoji
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let emoji = emojis[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell") as! EmojiTableViewCell
        
        cell.update(with: emoji)
        
        return cell
    }
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedEmoji = emojis[indexPath.row]
        performSegue(withIdentifier: "toEmojiEdit", sender: nil)
        print("\(selectedEmoji.symbol) \(indexPath)")
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let movedEmoji = emojis.remove(at: sourceIndexPath.row)

        emojis.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    // MARK: - Actions
    
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    @IBAction func unwindFromNewEmoji(_ segue: UIStoryboardSegue) {
        
        guard segue.identifier == "saveUnwind",
            let sourceViewController = segue.source as? NewEmojiTableViewController,
            let newEmoji = sourceViewController.emoji else { return }
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
           
            emojis[selectedIndexPath.row] = newEmoji
            
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        }else {

            let newIndexPath = IndexPath(row: emojis.count, section: 0)
        
            emojis.append(newEmoji)
            
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
