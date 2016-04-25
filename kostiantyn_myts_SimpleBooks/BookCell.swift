//
//  BookCell.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell, TableViewCellProtocol {
  @IBOutlet private weak var coverView: UIImageView!
  @IBOutlet private weak var bookTitleLabel: UILabel!
  
  var height: CGFloat = 70.0
  var cellName: String = "BookCell"
  var object: AnyObject! {
    didSet {
      updateWithBook(object as! Book)
    }
  }
}

private extension BookCell {
  private func updateWithBook(book: Book) {
    bookTitleLabel.attributedText = book.title + ("\nby " + book.author).color(.darkGrayColor()).font(.systemFontOfSize(14))
    
    ImageCache.imageForBook(book) {[weak self]
      image, _ in
      
      if let image = image {
        self?.coverView.image = image
      }
    }
  }
}