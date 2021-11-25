//
//  ViewController.swift
//  100 Days of Swift Project 6 Challenge
//
//  Created by Seb Vidal on 25/11/2021.
//

import UIKit

class ViewController: UITableViewController {
    
    var items: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        title = "Shopping List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearAll))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem)),
                                              UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))]
    }
    
    @objc func clearAll() {
        items.removeAll()
        tableView.reloadData()
    }
    
    @objc func addItem() {
        let alertController = UIAlertController(title: "Add Item", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak self, weak alertController] action in
            guard let item = alertController?.textFields?[0].text else {
                return
            }
            
            self?.add(item: item)
        }
        
        alertController.addAction(addAction)
        present(alertController, animated: true)
    }
    
    func add(item: String) {
        if isValid(item) {
            items.append(item)
            
            let indexPath = IndexPath(row: items.count - 1, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    func isValid(_ item: String) -> Bool {
        return item.count > 0
    }
    
    @objc func shareTapped() {
        let itemsString = "Shopping List:\n" + items.joined(separator: "\n")
        
        let shareSheet = UIActivityViewController(activityItems: [itemsString], applicationActivities: [])
        shareSheet.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItems?.last
        
        present(shareSheet, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].capitalized

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell?.accessoryType == UITableViewCell.AccessoryType.none {
            cell?.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            cell?.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

