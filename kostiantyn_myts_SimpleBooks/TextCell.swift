//
//  TextCell.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell, TableViewCellProtocol {
  var height: CGFloat = 50.0
  var cellName: String = "TextCell"
  var object: AnyObject! {
    didSet {
      updateWithText(object as! String)
    }
  }
}

private extension TextCell {
  private func updateWithText(text: String) {
    textLabel?.text = text
  }
}
