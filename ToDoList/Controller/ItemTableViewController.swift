//
//  ItemTableViewController.swift
//  ToDoList
//
//  Created by ShahJee on 30/08/2023.
//

import UIKit
import CoreData

class ItemTableViewController: UITableViewController {
    
    var selectedCategory: Category? {
        didSet {
            navigationItem.title = selectedCategory?.name
            loadData()
        }
    }
    
    var itemArray = [Item]()
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("Unable to save data, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadData() {
        
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        request.predicate = predicate
        
        do {
            itemArray = try context.fetch(request)
        } catch {
            print("Unable to load data, \(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Task", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new Task"
            textField = alertTextField
        }
        
        let alertAction = UIAlertAction(title: "Add Task", style: .default) { action in
            if let validText = textField.text {
                
                let newItem = Item(context: self.context)
                newItem.name = validText
                newItem.done = false
                newItem.parentCategory = self.selectedCategory
                
                self.itemArray.append(newItem)
                
                self.saveData()
            }
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            context.delete(itemArray[indexPath.row])
            itemArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveData()
        } else if editingStyle == .insert {

        }
    }
}
