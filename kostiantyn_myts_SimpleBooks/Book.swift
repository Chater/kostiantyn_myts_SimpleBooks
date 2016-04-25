//
//  Book.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class Book {
  var id: String!
  var title: String!
  var author: String!
  var description: String?
  var rank: UInt!
  var imageURL: NSURL!
  var amazonURL: NSURL!
  
  convenience init(dictionary: [String: AnyObject]) {
    self.init()
    
    self.id = dictionary["primary_isbn10"] as? String
    self.title = dictionary["title"] as? String
    self.author = dictionary["author"] as? String
    self.description = dictionary["description"] as? String
    self.rank = dictionary["rank"] as? UInt
    self.imageURL = NSURL(string: dictionary["book_image"] as! String)
    self.amazonURL = NSURL(string: dictionary["amazon_product_url"] as! String)
  }
}

extension Book {
  convenience init(managedBook: ManagedBook) {
    self.init()
    
    self.id = managedBook.bookId
    self.title = managedBook.title
    self.author = managedBook.author
    self.description = managedBook.desc
    self.rank = managedBook.rank?.unsignedIntegerValue
    self.imageURL = NSURL(string: managedBook.imageURLString!)
    self.amazonURL = NSURL(string: managedBook.amazonURLString!)
  }
  
  func isLiked() -> Bool {
    return BookStore.isSaved(self)
  }
}
