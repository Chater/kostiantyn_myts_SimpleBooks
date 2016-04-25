//
//  ProfilePresenter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/24/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit
import FBSDKCoreKit
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
    
    Notifications.LikedBooksDidChange.addObserver(self, selector: #selector(buildSections))
  }
}

extension ProfilePresenter: FBSDKLoginButtonDelegate {
  func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {

    Notifications.FacebookStatusDidChange.post()

    buildSections()
  }

  func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
    Notifications.FacebookStatusDidLogout.post()
    
    cleanUpLikedBooks()
  }

  func loginButtonWillLogin(loginButton: FBSDKLoginButton!) -> Bool {
    return true
  }
}

private extension ProfilePresenter {
  @objc private func buildSections() {
    GetLikedBooks.get() {[unowned self]
      books in
      if let books = books {
        let section = TableSection(objects: books, cellClass: BookCell()) {
          cell, object in
          self.presentable.showBookDetails(object as! Book)
        }
        
        self.presentable.showSections([section])
      }
      else {
        self.presentable.showSections([])
      }
    }
  }
  
  private func cleanUpLikedBooks() {
    RemoveLikedBooks.remove() {[unowned self]
      in
      self.buildSections()
    }
  }
}