//
//  GetBooks.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class GetBooks: NSObject {
  typealias CompletionHandler = (books: [Book]?, error: NSError?) -> Void
  
  class func get(genre: Genre, completionHandler: CompletionHandler) {
    APIClient.get(RequestType.Books(genre).request) {
      response, error in
      if let error = error where error.code != NSURLErrorNotConnectedToInternet {
        completionHandler(books: nil, error: error)
      }
      else if let response = response {
        completionHandler(books: parse(response), error: nil)
      }
      else {
        completionHandler(books: nil, error: nil)
      }
    }
  }
  
  private class func parse(data: AnyObject) -> [Book]? {
    guard let results = data["results"] as? [String: AnyObject] else {
      return nil
    }
    
    guard let books = results["books"] as? [[String: AnyObject]] else {
     return nil
    }
    
    return books
      .map { Book(dictionary: $0) }
      .flatMap { $0}
  }
}
