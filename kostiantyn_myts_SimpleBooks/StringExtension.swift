//
//  StringExtension.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/21/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

func +(left: String, right: NSAttributedString) -> NSAttributedString {
  let leftString = NSMutableAttributedString(string: left)
  leftString.appendAttributedString(right)
  return leftString
}

func +(left: NSAttributedString, right: String) -> NSAttributedString {
  let leftAttributedString = NSMutableAttributedString(attributedString: left)
  let rightAttributedString = NSAttributedString(string: right)
  leftAttributedString.appendAttributedString(rightAttributedString)
  return leftAttributedString
}

func +(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
  let leftString = NSMutableAttributedString(attributedString: left)
  leftString.appendAttributedString(right)
  return leftString
}

extension String {
  func color(color: UIColor) -> NSAttributedString {
    return NSAttributedString(string: self, attributes: [NSForegroundColorAttributeName: color])
  }
  
  func font(font: UIFont) -> NSAttributedString {
    return NSAttributedString(string: self, attributes: [NSFontAttributeName: font])
  }
}

extension NSAttributedString {
  func color(color: UIColor) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(attributedString: self)
    attributedString.addAttributes([NSForegroundColorAttributeName: color], range: NSRange(location: 0, length: self.length))
    return attributedString
  }
  
  func font(font: UIFont) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(attributedString: self)
    attributedString.addAttributes([NSFontAttributeName: font], range: NSRange(location: 0, length: self.length))
    return attributedString
  }
}

