//
//  ProfileViewController.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/24/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ProfileViewController: UIViewController {
  @IBOutlet private weak var loginButton: FBSDKLoginButton!
  @IBOutlet private weak var tableView: UITableView!
  
  private var tableManager: TableManager!
  private var presenter: ProfilePresenter!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
  }
}

extension ProfileViewController: ProfilePresentable {
  func showError(error: NSError) {
    showAlert(error)
  }
  
  func showSections(sections: [TableSection]) {
    tableManager.sections = sections
  }
  
  func showBookDetails(book: Book) {
    let vc = storyboard?.instantiateViewControllerWithIdentifier("BookDetailsViewController") as! BookDetailsViewController
    vc.book = book
    
    navigationController?.pushViewController(vc, animated: true)
  }
}

private extension ProfileViewController {
  private func configure() {
    title = NSLocalizedString("Profile", comment: "")
    
    configureTableView()
    configurePresenter()
    configureLoginButton()
  }
  
  private func configurePresenter() {
    presenter = ProfilePresenter(presentable: self)
  }
  
  private func configureLoginButton() {
    loginButton.delegate = presenter
  }
  
  private func configureTableView() {
    self.tableManager = TableManager(tableView: tableView)
  }
}
