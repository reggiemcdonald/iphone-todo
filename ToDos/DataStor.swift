//
//  DataStor.swift
//  ToDos
//
//  Created by Reginald McDonald on 2019-06-21.
//  Copyright © 2019 Reginald McDonald. All rights reserved.
//

import Foundation

struct Todo:Codable {
    var text: String;
    var completed: Bool;
}

class DataStor {
    var data: Array<Todo>! = Array();
    static var instance: DataStor! = nil;
    
    public static func getInstance() -> (DataStor) {
        if (instance == nil) {
            instance = DataStor();
            return instance;
        } else {
            return instance;
        }
    }
    
    private init() {
        update();
    }
    
    public func addItem(todo: String) -> (Bool) {
        data.append(Todo(text: todo, completed: false));
        commit();
        return true;
    }
    
    public func getItem(at i: Int) -> (Todo) {
        assert(i > -1 && i < data.count);
        return data[i];
    }
    
    public func removeItem(at idx: Int) -> (Bool) {
        if idx > -1 && idx < data.count {
            
            data.remove(at: idx);
            
            commit();
            return true;
        }
        return false;
    }
    
    public func size() -> (Int) {
        return data.count;
    }
    
    public func update() {
        if let dataobj = UserDefaults.standard.object(forKey: "todos") as? Data {
            let dataArr = try! PropertyListDecoder().decode(Array<Todo>.self, from: dataobj);
            self.data = dataArr;
        } else {
            data = [];
            commit();
        }
    }
    
    public func complete(at idx: Int) {
        data[idx].completed = true;
        commit();
    }
    
    public func commit() {
        let saveData = try! PropertyListEncoder().encode(data);
        UserDefaults.standard.set(saveData, forKey:"todos");
    }
}
