//
//  Notifications.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

//FBSDKAccessTokenDidChangeNotification doesnt work for some reasons

enum Notifications: String {
  case FacebookStatusDidChange
  case FacebookStatusDidLogout
  
  func post() {
    NSNotificationCenter.defaultCenter().postNotificationName(rawValue, object: nil)
  }
  
  func addObserver(observer: AnyObject, selector: Selector) {
    NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: rawValue, object: nil)
  }
}
