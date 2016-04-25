//
//  LoginCell.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginCell: UITableViewCell, TableViewCellProtocol {
  @IBOutlet private weak var loginButton: FBSDKLoginButton!
  
  var height: CGFloat = 50.0
  var cellName: String = "LoginCell"
  var object: AnyObject!
}

extension LoginCell: FBSDKLoginButtonDelegate {
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    
    Notifications.FacebookStatusDidChange.post()
  }
  
  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    Notifications.FacebookStatusDidLogout.post()
  }
  
  func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
    return true
  }
}
