//
//  GenresPresenter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

protocol GenresPresentable: NSObjectProtocol {
  func setLoading(loading: Bool)
  func showError(error: NSError)
  func showSection(section: TableSection)
  func showGenreDetails(genre: Genre)
}

class GenresPresenter {
  private weak var presentable: GenresPresentable!
  
  convenience init(presentable: GenresPresentable) {
    self.init()
    
    self.presentable = presentable
    
    getGenres()
  }
}

extension GenresPresenter {
  func reload() {
    getGenres()
  }
}

private extension GenresPresenter {
  private func getGenres() {
    presentable.setLoading(true)
    
    GetGenres.get() {[unowned self]
      genres, error in
      self.presentable.setLoading(false)
      
      if let error = error {
        self.presentable.showError(error)
      }
      else if let genres = genres {
        let section = TableSection(objects: genres, cellClass: GenreCell()) {
          cell, object in
          self.presentable.showGenreDetails(object as! Genre)
        }
        
        self.presentable.showSection(section)
      }
    }

  }
}
