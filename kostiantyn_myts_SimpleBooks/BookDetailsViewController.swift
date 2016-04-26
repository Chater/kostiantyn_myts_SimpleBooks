//
//  BookDetailsViewController.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit
import FBSDKShareKit

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
  
  func openShareDialog() {
    let shareContent = FBSDKShareLinkContent()
    shareContent.contentTitle = book.title + " by " + book.author
    shareContent.imageURL = book.imageURL
    shareContent.contentDescription = book.amazonURL.absoluteString
    
    let dialog = FBSDKShareDialog()
    dialog.fromViewController = self
    dialog.shareContent = shareContent
    dialog.mode = .FeedWeb
    
    dialog.show()
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
