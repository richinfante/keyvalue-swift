//
//  KeyValue.swift
//
//  Created by Richard Infante on 1/17/16.
//  Copyright © 2016 richinfante. All rights reserved.
//

import Foundation
import UIKit

///Key value pair class
class KeyValuePair {
    var key : String
    var value: String
    
    init(key: String, value: String){
        self.key = key
        self.value = value
    }
}

class KeyValueViewer : UITableViewController {
    
    ///Hold key value pairs
    var data: [KeyValuePair] = [KeyValuePair]()
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return data.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "keyvaluecell")
        cell.textLabel!.text = data[indexPath.row].key
        cell.detailTextLabel!.text = data[indexPath.row].value
        return cell
    }
    
    ///Set the keys and values in this view.
    ///Orders them alphabetically by key.
    func setDictionary(dict: [String: String]){
        for (key, value) in dict {
            data.append(KeyValuePair(key: key, value: value))
        }
        self.sort()
    }
    
    ///Replaces keys with specified values.
    ///Can be used to localize data structures.
    func localizeKeys(dict: [String:String]){
        for (key, value) in dict {
            for item in data {
                if item.key == key {
                    item.key = value
                }
            }
        }
        self.sort()
    }
    
    ///Sort key viewer by keys alphabetically.
    func sort(){
        data.sortInPlace(){$0.key < $1.key}
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
}
