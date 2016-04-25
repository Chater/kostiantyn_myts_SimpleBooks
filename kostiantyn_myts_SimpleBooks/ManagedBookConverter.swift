//
//  ManagedBookConverter.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import UIKit

class ManagedBookConverter {
  class func convert(managedBooks: [ManagedBook]) -> [Book] {
    return managedBooks
      .map { Book(managedBook: $0) }
      .flatMap { $0 }
  }
}
