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
  
  private static let sharedClient = APIClient()
  
  private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
  
  class func get(request: NSURLRequest, completion: CompletionHandler) {
    print(request.URL)
    let task: NSURLSessionDataTask = APIClient.sharedClient.session.dataTaskWithRequest(request) {
      (data, response, error) -> Void in
      
      if error != nil {
        completion(response: nil, error: error)
      }
      
      guard let data = data else {
        //TODO: return new error
        completion(response: nil, error: nil)
        return
      }
      
      let response = NSString(data: data, encoding: NSUTF8StringEncoding)
      print(response)
      
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
}
