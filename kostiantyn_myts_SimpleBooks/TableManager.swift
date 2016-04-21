//
//  TableManager.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class TableManager: NSObject {
  private weak var tableView: UITableView!
  
  var sections: [TableSection]? {
    didSet {
      self.tableView.reloadData()
    }
  }
  
  convenience init(tableView: UITableView, sections: [TableSection]? = nil) {
    self.init()
    
    self.tableView = tableView
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    self.sections = sections
    
    self.tableView.reloadData()
  }
}

extension TableManager: UITableViewDataSource {
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return sections?.count ?? 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection sectionIndex: Int) -> Int {
    guard let section = sections?[sectionIndex] else {
      return 0
    }
    
    return section.tableView(tableView, numberOfRowsInSection: sectionIndex)
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return (sections![indexPath.section] as TableSection).tableView(tableView, cellForRowAtIndexPath: indexPath)
  }
}

extension TableManager: UITableViewDelegate {
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    sections?[indexPath.section].tableView(tableView, didSelectRowAtIndexPath: indexPath)
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    guard let section = sections?[indexPath.section] else {
      return 0
    }
    
    return section.tableView(tableView, heightForRowAtIndexPath: indexPath)
  }
}
