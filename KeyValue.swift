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
    var localizedKey: String?
    var keyForDisplay : String {
        get {
            if let localizedKey = localizedKey {
                return localizedKey
            }else{
                return key
            }
        }
    }
    var value: String
    
    init(key: String, value: String){
        self.key = key
        self.value = value
    }
}

class Section {
    var title : String
    var keys : [String]
    
    init(title: String, keys: [String]){
        self.title = title
        self.keys = keys
    }
}

class KeyValueViewer : UITableViewController {
    
    ///Hold key value pairs
    var data: [KeyValuePair] = [KeyValuePair]()
    var sections: [Section] = [Section]()
    
    func numberOfMatchingRows(section: Section) -> [KeyValuePair]{
        var matches : [KeyValuePair] = [KeyValuePair]();
        for item in data {
            for regex in section.keys {
                if let _ = item.key.rangeOfString(regex, options: .RegularExpressionSearch) {
                    matches.append(item)
                    break
                }
            }
        }
        return matches
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == sections.count {
            return "All Items"
        }
        return sections[section].title
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count + 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections.count == 0 || section == sections.count{
            return data.count
        }else{
            return numberOfMatchingRows(sections[section]).count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "keyvaluecell")
        if sections.count == 0 || indexPath.section == sections.count {
            let item = data[indexPath.row]
            cell.textLabel!.text = item.keyForDisplay
            cell.detailTextLabel!.text = item.value
            return cell
        }else {
            let item = numberOfMatchingRows(sections[indexPath.section])[indexPath.row]
            cell.textLabel!.text = item.keyForDisplay
            cell.detailTextLabel!.text = item.value
            return cell
        }
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
                    item.localizedKey = value
                }
            }
        }
        self.sort()
    }
    
    func sortBySections(dict: [String: [String]]) {
        for (title, keys) in dict {
            sections.append(Section(title: title, keys: keys))
        }
        self.sort()
    }
    
    ///Sort key viewer by keys alphabetically.
    func sort(){
        data.sortInPlace(){
            $0.keyForDisplay < $1.keyForDisplay
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }
}