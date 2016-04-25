//
//  ChangeBookLikeStatus.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class ChangeBookLikeStatus: NSObject {
  typealias CompletionHandler = (liked: Bool) -> Void
  
  class func change(book: Book, completionHandler: CompletionHandler) {
    if BookStore.isSaved(book) {
      BookStore.remove(book)
      completionHandler(liked: false)
    }
    else {
      BookStore.save(book)
      completionHandler(liked: true)
    }
    
    Notifications.LikedBooksDidChange.post()
  }
}
