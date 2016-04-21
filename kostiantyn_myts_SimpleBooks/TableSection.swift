//
//  TableSection.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class TableSection: NSObject {
  typealias SelectBlock = (cell: UITableViewCell, object: AnyObject) -> Void
  
  private var objects: [AnyObject]!
  private var cellClass: TableViewCellProtocol!
  private var selectBlock: SelectBlock?
  
  convenience init(objects: [AnyObject], cellClass: TableViewCellProtocol, selectBlock: SelectBlock? = nil) {
    self.init()
    
    self.objects = objects
    self.cellClass = cellClass
    self.selectBlock = selectBlock
  }
}

extension TableSection: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    var cell: UITableViewCell!

    let nibs = NSBundle.mainBundle().loadNibNamed(cellClass.cellName, owner: nil, options: nil)
    if let aCell = nibs[0] as? UITableViewCell {
      cell = aCell
    }
    
    (cell as! TableViewCellProtocol).object = objects[indexPath.row]
    
    return cell
  }
}

extension TableSection: UITableViewDelegate {
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return cellClass.height
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    if let selectBlock = selectBlock, let cell = tableView.cellForRowAtIndexPath(indexPath) {
      selectBlock(cell: cell, object: objects[indexPath.row])
    }
  }
}
