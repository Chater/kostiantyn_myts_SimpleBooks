//
//  BookDetailsPresenter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

protocol BookDetailsPresentable: NSObjectProtocol {
  func showError(error: NSError)
  func showSections(sections: [TableSection])
}

final class BookDetailsPresenter {
  private weak var presentable: BookDetailsPresentable!
  private weak var book: Book!
  
  convenience init(presentable: BookDetailsPresentable, book: Book) {
    self.init()
    
    self.presentable = presentable
    self.book = book
    
    buildSections()
  }
}

private extension BookDetailsPresenter {
  private func buildSections() {
    let sections = [TableSection(objects: [book], cellClass: BookHeaderCell())]
    presentable.showSections(sections)
  }
}
