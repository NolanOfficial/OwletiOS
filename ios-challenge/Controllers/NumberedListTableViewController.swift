//
//  NumberedListTableViewController.swift
//  ios-challenge
//
//  Created by Scott Marchant on 4/16/19.
//  Copyright © 2019 Owlet Baby Care Inc. All rights reserved.
//

import UIKit

class NumberedListTableViewController: UITableViewController {
    
    private var listOfNumbers: [Int] = []
    
    // Removed the concurrent attribute, tableview will load out of order otherwise
    private let serialQueue = DispatchQueue(label: "AsynchronousListGenerator",
                                    qos: .unspecified)
    
    // Table View in order to register cell
    @IBOutlet var customTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Registering the cell (Wanted to make a custom cell but didn't know if that was allowed)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        // Removed multiple reload data's. If data loading is done correctly, it can be done within one call
        // Also kept it at 2 seconds, rather than 5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            for number in 1...100 {
                self.serialQueue.async {
                    self.listOfNumbers.append(number)
                    DispatchQueue.main.async {
                         self.tableView.reloadData()
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfNumbers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        let listItem = listOfNumbers[indexPath.row]

        cell.textLabel!.text = String(listItem)

        return cell
    }
}
