//
//  TableViewCellProtocol.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/19/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

@objc protocol TableViewCellProtocol {
  var height: CGFloat {get set}
  var cellName: String {get set}
  var object: AnyObject! {get set}
}
