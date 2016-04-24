//
//  Cache.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class ImageCache {
  typealias CompletionHandler = (image: UIImage?, error: NSError?) -> Void
  
  private static let MemoryCapacity = 100 * 1024 * 1024
  private static let DiscCapacity = 100 * 1024 * 1024
  private static let DiskPath = "ImageCache"
  
  static let sharedURLCache = NSURLCache(memoryCapacity: MemoryCapacity, diskCapacity: DiscCapacity, diskPath: DiskPath)
}

extension ImageCache {
  class func imageForBook(book: Book, completionHandler: CompletionHandler) {
    let request = NSURLRequest(URL: book.imageURL)
    
    if let cachedResponse = ImageCache.sharedURLCache.cachedResponseForRequest(request) {
      completionHandler(image: UIImage(data: cachedResponse.data), error: nil)
    }
    else {
      download(request, completionHandler: completionHandler)
    }
  }
}

private extension ImageCache {
  class private func download(request: NSURLRequest, completionHandler: CompletionHandler) {
    APIClient.download(request) {
      response, URL, error in
      
      if let error = error {
        completionHandler(image: nil, error: error)
      }
      else if let URL = URL, let response = response, let data = NSData(contentsOfURL: URL) {
        cache(request, response: response, data: data)
        
        completionHandler(image: UIImage(data: data), error: nil)
      }
      else {
        completionHandler(image: nil, error: nil)
      }
    }
  }
  
  class private func cache(request: NSURLRequest, response: NSURLResponse, data: NSData) {
    let cachedResponse = NSCachedURLResponse(response: response, data: data)
    ImageCache.sharedURLCache.storeCachedResponse(cachedResponse, forRequest: request)
  }
}