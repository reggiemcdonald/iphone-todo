//
//  SecondViewController.swift
//  ToDos
//
//  Created by Reginald McDonald on 2019-06-21.
//  Copyright © 2019 Reginald McDonald. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController,  UITextFieldDelegate {
    private var dataStor: DataStor!;
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStor = DataStor.getInstance();
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let newTodoObj = textField.text;
        if let todo = newTodoObj {
            dataStor.addItem(todo: todo);
            textField.text = "";
            
        }
    }
    

}

