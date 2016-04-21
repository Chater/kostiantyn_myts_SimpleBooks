//
//  Requests.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

private let baseURI = "http://api.nytimes.com/svc/books/"
private let responseFormat = ".json"
private let version = "v3"
private let secretKey = "81a4c39c8d9c4e5d9e1a1bf75e661276:4:75045148"

enum RequestType {
  case Genres
  case Books(Genre)
  
  var URL: NSURL {
    switch self {
    case .Genres:
//      http://api.nytimes.com/svc/books/v3/lists/names.json?api-key=sample-key
      return NSURL(string: baseURI + version + "/lists/names" + responseFormat + "?api-key=" + secretKey)!
    
//      http://api.nytimes.com/svc/books/v3/lists/hardcover-fiction.json?api-key=sample-key
    case .Books(let genre):
      return NSURL(string: baseURI + version + "/lists/" + genre.encodedName + responseFormat + "?api-key=" + secretKey)!

    }
  }
  
  var request: NSURLRequest {
    return NSURLRequest(URL: self.URL)
  }
}