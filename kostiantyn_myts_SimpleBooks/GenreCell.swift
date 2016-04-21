//
//  GenreCell.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell, TableViewCellProtocol {
  var height: CGFloat = 50.0
  var cellName: String = "GenreCell"
  var object: AnyObject! {
    didSet {
      updateWithGenre(object as! Genre)
    }
  }
}

private extension GenreCell {
  private func updateWithGenre(genre: Genre) {
    textLabel?.text = genre.name
  }
}
