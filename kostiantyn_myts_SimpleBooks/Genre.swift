//
//  Genre.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class Genre {
  var name: String!
  var encodedName: String!
  
  convenience init(dictionary: [String: AnyObject]) {
    self.init()
    
    self.name = dictionary["list_name"] as? String
    self.encodedName = dictionary["list_name_encoded"] as? String
  }
}
