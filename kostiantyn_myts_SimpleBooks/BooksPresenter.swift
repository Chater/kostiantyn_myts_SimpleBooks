//
//  BooksPresenter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

protocol BooksPresentable: NSObjectProtocol {
  func setLoading(loading: Bool)
  func showError(error: NSError)
  func showSection(section: TableSection)
  func showBookDetails(book: Book)
}

class BooksPresenter {
  private weak var presentable: BooksPresentable!
  private weak var genre: Genre!
  
  convenience init(presentable: BooksPresentable, genre: Genre) {
    self.init()
    
    self.presentable = presentable
    self.genre = genre
    
    getBooks()
  }
}

extension BooksPresenter {
  func reload() {
    getBooks()
  }
}

private extension BooksPresenter {
  private func getBooks() {
    self.presentable.setLoading(true)
    
    GetBooks.get(genre) {[unowned self]
      books, error in
      self.presentable.setLoading(false)
      
      if let error = error {
        self.presentable.showError(error)
      }
      else if let books = books {
        let section = TableSection(objects: books, cellClass: BookCell()) {[unowned self]
          cell, object in

          self.presentable.showBookDetails(object as! Book)
        }
        
        self.presentable.showSection(section)
      }

    }
  }
}
