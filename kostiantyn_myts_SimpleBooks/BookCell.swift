//
//  BookCell.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell, TableViewCellProtocol {
  var height: CGFloat = 60.0
  var cellName: String = "BookCell"
  var object: AnyObject! {
    didSet {
      updateWithBook(object as! Book)
    }
  }
}

private extension BookCell {
  private func updateWithBook(book: Book) {
    textLabel?.text = book.title + " \(book.rank)"
  }
}