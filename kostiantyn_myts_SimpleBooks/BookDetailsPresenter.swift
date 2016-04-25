//
//  BookDetailsPresenter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit
import FBSDKCoreKit


protocol BookDetailsPresentable: NSObjectProtocol {
  func showError(error: NSError)
  func showSections(sections: [TableSection])
  func openShareDialog()
}

final class BookDetailsPresenter {
  private weak var presentable: BookDetailsPresentable!
  private weak var book: Book!
  
  convenience init(presentable: BookDetailsPresentable, book: Book) {
    self.init()
    
    self.presentable = presentable
    self.book = book
    
    configureNotifications()
    
    buildSections()
  }
}

private extension BookDetailsPresenter {
  @objc private func buildSections() {
    var sections = [TableSection]()
    
    sections.append(TableSection(objects: [book], cellClass: BookHeaderCell()))
    
    if (FBSDKAccessToken.currentAccessToken() != nil) {
      let shareSection = TableSection(objects: [NSLocalizedString("Share on Facebook", comment: "")], cellClass: TextCell()) {[unowned self]
        _, _ in
        self.presentable.openShareDialog()
      }
      sections.append(shareSection)
      
      let likeTitle = book.isLiked() ? NSLocalizedString("Unlike", comment: "") : NSLocalizedString("Like", comment: "")
      sections.append(TableSection(objects: ["\(likeTitle) \(book.title)"], cellClass: TextCell()) {[unowned self]
        _, _ in
        self.changeBookLikeStatus()
        })
    }
    else {
      sections.append(TableSection(objects: [""], cellClass: LoginCell()))
    }
    
    presentable.showSections(sections)
  }
}

private extension BookDetailsPresenter {
  private func changeBookLikeStatus() {
    ChangeBookLikeStatus.change(book) {[unowned self]
      liked in
      
      self.buildSections()
    }
  }
}

private extension BookDetailsPresenter {
  func configureNotifications() {
    Notifications.FacebookStatusDidChange.addObserver(self, selector: #selector(buildSections))
    Notifications.FacebookStatusDidLogout.addObserver(self, selector: #selector(buildSections))
    Notifications.LikedBooksDidChange.addObserver(self, selector: #selector(buildSections))
  }
}
