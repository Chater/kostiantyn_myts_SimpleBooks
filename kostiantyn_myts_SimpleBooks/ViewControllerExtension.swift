//
//  ViewControllerExtension.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

extension UIViewController {
  func showAlert(error: NSError, recoveryHandler: (() -> ())? ) {
    let actionController = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: error.description, preferredStyle: .ActionSheet)
    
    let cancelAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .Cancel, handler: nil)
    actionController.addAction(cancelAction)
    
    if let recoveryHandler = recoveryHandler {
      let tryAgainAction = UIAlertAction(title: NSLocalizedString("Try again", comment: ""), style: .Default) {
        _ in
          recoveryHandler()
      }
      actionController.addAction(tryAgainAction)
    }
    
    self.presentViewController(actionController, animated: true, completion: nil)
  }
}

