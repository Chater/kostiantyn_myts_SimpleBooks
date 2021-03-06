//
//  GenresViewController.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class GenresViewController: UITableViewController {
  private var tableManager: TableManager!
  private var presenter: GenresPresenter!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
}

extension GenresViewController: GenresPresentable {
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
  
  func showGenreDetails(genre: Genre) {
    let vc = storyboard?.instantiateViewControllerWithIdentifier("BooksViewController") as! BooksViewController
    vc.genre = genre
    
    navigationController?.pushViewController(vc, animated: true)
  }
}

private extension GenresViewController {
  private func configure() {
    title = NSLocalizedString("Genres", comment: "")
    
    configurePresenter()
    configureTableView()
    configurePullToRefresh()
  }
  
  private func configurePresenter() {
    self.presenter = GenresPresenter(presentable: self)
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

