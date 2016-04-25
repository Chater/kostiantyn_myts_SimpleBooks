//
//  RemoveLikedBooks.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class RemoveLikedBooks: NSObject {
  typealias CompletionHandler = () -> Void
  
  class func remove(completionHandler: CompletionHandler) {
    BookStore.removeAll()
    completionHandler()
  }
}
