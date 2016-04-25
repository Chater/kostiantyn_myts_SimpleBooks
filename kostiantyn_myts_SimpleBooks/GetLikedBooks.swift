//
//  GetLikedBooks.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class GetLikedBooks: NSObject {
  typealias CompletionHandler = (books: [Book]?) -> Void
  
  class func get(completionHandler: CompletionHandler) {
    if let managedBooks = BookStore.getAll() where managedBooks.count > 0 {
      completionHandler(books: ManagedBookConverter.convert(managedBooks))
    }
    else {
      completionHandler(books: nil)
    }
  }
}
