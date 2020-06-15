//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Vaishali on 2020-06-13.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryArray : Results<CategoryRealm>?
    
//    CoreData context
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories added"
        
        return cell
    }
    
    //MARK: - Tableview delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        to delete a row from sql database
        //        context.delete(itemArray[indexPath.row])
        //        itemArray.remove(at: indexPath.row)
        
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPAth = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArray?[indexPAth.row]
        }
        
    }
    
    
    //MARK: - Data manipulation methods
    
//    save data using CoreData
//    func saveCategories() {
//            do {
//                try context.save()
//            } catch {
//                print("Error saving Category. \(error)")
//            }
//            tableView.reloadData()
//        }

    func save(category: CategoryRealm) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving data. \(error)")
        }
        tableView.reloadData()
    }
    
//    reading data using CoreData
//    func loadCategories() {
//        let request : NSFetchRequest<Category> = Category.fetchRequest()
//        do {
//            categoryArray = try context.fetch(request)
//        } catch {
//            print("Error reading Categories. \(error)")
//        }
//        tableView.reloadData()
//    }
    
    func loadCategories() {
        categoryArray = realm.objects(CategoryRealm.self)
        tableView.reloadData()
    }
    
    

    //MARK: - Add new categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
            let alert = UIAlertController(title: "Add New Todoey Category", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
                //What will happen once the user clicks Add Category button on alert
//                creating new data using CoreData
//                let newCategory = Category(context: self.context)
                let newCategory = CategoryRealm()

                newCategory.name = textField.text!
                
                self.save(category: newCategory)
            }
            
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create a new Category"
                textField = alertTextField
            }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
        
    }
}

