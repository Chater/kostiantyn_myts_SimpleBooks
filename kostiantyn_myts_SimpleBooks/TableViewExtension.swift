//
//  TableViewExtension.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

extension UITableView {
  //TODO: make loading view in the center of table view
  func setLoading(loading: Bool) {
    if !loading {
      tableFooterView = nil
      return
    }
    
    let activityIndicator = UIActivityIndicatorView(frame: CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)))
    activityIndicator.startAnimating()
    activityIndicator.activityIndicatorViewStyle = .WhiteLarge
    activityIndicator.color = .blackColor()
    
    tableFooterView = activityIndicator
  }
}
