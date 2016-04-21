//
//  GetGenres.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class GetGenres {
  typealias CompletionHandler = (genres: [Genre]?, error: NSError?) -> Void
  
  class func get(completionHandler: CompletionHandler) {
    APIClient.get(RequestType.Genres.request) {
      response, error in
      
      if let error = error {
        completionHandler(genres: nil, error: error)
      }
      else if let response = response {
        completionHandler(genres: parse(response), error: nil)
      }
      else {
        completionHandler(genres: nil, error: nil)
      }
    }
  }
  
  private class func parse(data: AnyObject) -> [Genre]? {
    guard let results = data["results"] as? [[String: AnyObject]] else {
      return nil
    }
    
    return results
      .map { Genre(dictionary: $0) }
      .flatMap { $0}
  }
}
