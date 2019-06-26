//
//  FirstViewController.swift
//  ToDos
//
//  Created by Reginald McDonald on 2019-06-21.
//  Copyright © 2019 Reginald McDonald. All rights reserved.
//

import UIKit


class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var todos: DataStor!;
    @IBOutlet weak var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.size();
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell");
        let todo = todos.getItem(at: indexPath.row);
        cell.textLabel?.text = todo.text;
        if todo.completed {
            cell.backgroundColor = .green;
        }
        return cell;
    }
    

    override func viewDidLoad() {
        super.viewDidLoad();
        todos = DataStor.getInstance();
        // Do any additional setup after loading the view.
    }
    
    func update() {
        table.reloadData();
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        todos.update();
        table.reloadData();
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.removeItem(at: indexPath.row);
            table.deleteRows(at: [indexPath], with: .fade);
        } else if editingStyle == .insert {
            print("editing");
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingAction = UIContextualAction(style: .normal, title: "complete", handler: {
            (UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.table.cellForRow(at: indexPath)?.backgroundColor = .green;
            self.todos.complete(at: indexPath.row);
            success(true);
        })
        editingAction.image = UIImage(named: "tick");
        return UISwipeActionsConfiguration(actions: [editingAction]);
    }

}

