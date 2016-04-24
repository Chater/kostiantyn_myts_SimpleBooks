//
//  BookHeaderCell.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class BookHeaderCell: UITableViewCell, TableViewCellProtocol {
  @IBOutlet private weak var coverView: UIImageView!
  @IBOutlet private weak var bookTitleLabel: UILabel!
  
  var height: CGFloat = 200.0
  var cellName: String = "BookHeaderCell"
  var object: AnyObject! {
    didSet {
      updateWithBook(object as! Book)
    }
  }
}

private extension BookHeaderCell {
  private func updateWithBook(book: Book) {
    bookTitleLabel.attributedText =
      book.title
      + "\n" +
      ("by " + book.author).color(.darkGrayColor()).font(UIFont.systemFontOfSize(14))
      + "\n" +
      "Rank: \(book.rank)".color(.darkGrayColor()).font(UIFont.italicSystemFontOfSize(14))
    
    ImageCache.imageForBook(book) {[unowned self]
      image, _ in
      
      if let image = image {
        self.coverView.image = image
      }
    }
  }
}

