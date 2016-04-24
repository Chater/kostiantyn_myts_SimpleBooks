//
//  BookDetailsViewController.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class BookDetailsViewController: UITableViewController {
  private var tableManager: TableManager!
  private var presenter: BookDetailsPresenter!
  
  @IBOutlet private weak var coverView: UIImageView!
  
  var book: Book! {
    didSet {
      title = book.title
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
}

extension BookDetailsViewController: BookDetailsPresentable {
  func showError(error: NSError) {
    showAlert(error)
  }
  
  func showSections(sections: [TableSection]) {
    tableManager.sections = sections
  }
}

private extension BookDetailsViewController {
  private func configure() {
    configureTableView()
    configurePresenter()
  }
  
  private func configurePresenter() {
    self.presenter = BookDetailsPresenter(presentable: self, book: book)
  }
  
  private func configureTableView() {
    self.tableManager = TableManager(tableView: tableView)
  }
}
