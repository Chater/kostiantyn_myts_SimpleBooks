//
//  BooksViewController.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class BooksViewController: UITableViewController {
  private var tableManager: TableManager!
  private var presenter: BooksPresenter!
  
  var genre: Genre!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
}

extension BooksViewController: BooksPresentable {
  func setLoading(loading: Bool) {
    tableView.setLoading(loading)
  }
  
  func showError(error: NSError) {
    showAlert(error) {
      self.presenter.reload()
    }
  }
  
  func showSections(sections: [TableSection]?) {
    refreshControl?.endRefreshing()
    self.tableManager.sections = sections
  }
  
  func showBookDetails(book: Book) {
    let vc = storyboard?.instantiateViewControllerWithIdentifier("BookDetailsViewController") as! BookDetailsViewController
    vc.book = book
    
    navigationController?.pushViewController(vc, animated: true)
  }
}

private extension BooksViewController {
  private func configure() {
    title = genre.name
    
    configurePresenter()
    configureTableView()
    configurePullToRefresh()
  }
  
  private func configurePresenter() {
    self.presenter = BooksPresenter(presentable: self, genre: genre)
  }
  
  private func configureTableView() {
    self.tableManager = TableManager(tableView: tableView)
  }
  
  private func configurePullToRefresh() {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(presenter, action: #selector(presenter.reload), forControlEvents: .ValueChanged)
    self.refreshControl = refreshControl
  }
}

