//
//  ProfilePresenter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/24/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit
import FBSDKLoginKit

protocol ProfilePresentable: NSObjectProtocol {
  func showError(error: NSError)
  func showSections(sections: [TableSection])
  func showBookDetails(book: Book)
}

class ProfilePresenter: NSObject {
  private weak var presentable: ProfilePresentable!
  private weak var book: Book!
  
  convenience init(presentable: ProfilePresentable) {
    self.init()
    
    self.presentable = presentable
    
    buildSections()
  }
}

extension ProfilePresenter: FBSDKLoginButtonDelegate {
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
    
    buildSections()
  }
  
  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    print("loginButtonDidLogOut")
    cleanUpLikedBooks()
  }
  
  func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
    return true
  }
}

private extension ProfilePresenter {
  private func buildSections() {
    
  }
  
  private func cleanUpLikedBooks() {
    
  }
}