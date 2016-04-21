//
//  Book.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class Book {
  var title: String!
  var description: String?
  var rank: Int!
  var imageURL: NSURL!
  var amazonURL: NSURL!
  
  convenience init(dictionary: [String: AnyObject]) {
    self.init()
    
    self.title = dictionary["title"] as? String
    self.description = dictionary["description"] as? String
    self.rank = dictionary["rank"] as? Int
    self.imageURL = NSURL(string: dictionary["book_image"] as! String)
    self.amazonURL = NSURL(string: dictionary["amazon_product_url"] as! String)
  }
}
