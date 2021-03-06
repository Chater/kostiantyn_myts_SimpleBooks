//
//  APIClient.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class APIClient {
  typealias CompletionHandler = (response: AnyObject?, error: NSError?) -> Void
  typealias DownloadCompletionHandler = (response: NSURLResponse?, URL: NSURL?, error: NSError?) -> Void
  
  private static let sharedClient = APIClient()
  
  private let session: NSURLSession = {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    config.URLCache = ImageCache.sharedURLCache
    
    return NSURLSession(configuration: config, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
  }()
}


extension APIClient {
  class func get(request: NSURLRequest, completion: CompletionHandler) {
    print("Request to: \(request.URL)")
    
    let task: NSURLSessionDataTask = APIClient.sharedClient.session.dataTaskWithRequest(request) {
      (data, response, error) -> Void in
      
      if error != nil {
        completion(response: nil, error: error)
        return
      }
      
      guard let data = data else {
        completion(response: nil, error: NSError(domain: "Error", code: -999, userInfo: nil))
        return
      }
      
      do {
        let JSON = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions())
        completion(response: JSON, error: nil)
      }
      catch let error as NSError {
        completion(response: nil, error: error)
      }
    }
    
    task.resume()
  }
  
  class func download(request: NSURLRequest, completion: DownloadCompletionHandler) {
    let task: NSURLSessionDownloadTask = APIClient.sharedClient.session.downloadTaskWithRequest(request) {
      (URL, response, error) -> Void in
      if error != nil {
        completion(response: nil, URL: nil, error: error)
        return
      }
      
      completion(response: response, URL: URL, error: error)
    }
    
    task.resume()
  }
  
  
}
