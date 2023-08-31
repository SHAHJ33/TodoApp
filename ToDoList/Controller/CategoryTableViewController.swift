//
//  CategoryTableViewController.swift
//  ToDoList
//
//  Created by ShahJee on 30/08/2023.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    @IBAction func HomePressed(_ sender: UIBarButtonItem) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
        // open alert view and take category name
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Category", message: "", preferredStyle: .alert)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new category"
            textField = alertTextField
        }
        
        let alertAction = UIAlertAction(title: "Add Category", style: .default) { action in
            if let validText = textField.text {
                
                let newCategory = Category(context: self.context)
                newCategory.name = validText
                
                self.categoryArray.append(newCategory)
                
                self.saveData()
            }
        }
        
        alert.addAction(alertAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GotoItems", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray[indexPath.row].name
        
        return cell
    }
    
    func saveData() {
        do  {
            try context.save()
        } catch {
            print("Unable to save category data, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadData() {
        do {
            categoryArray = try context.fetch(Category.fetchRequest())
        } catch {
            print("Unable to load category data, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            context.delete(categoryArray[indexPath.row])
            categoryArray.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            saveData()
        } else if editingStyle == .insert {
            
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ItemTableViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory =  categoryArray[indexPath.row]
        }
    }
}
