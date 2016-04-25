//
//  ManagedBook.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//

import Foundation
import CoreData

class ManagedBook: NSManagedObject {
  @NSManaged var bookId: String?
  @NSManaged var title: String?
  @NSManaged var author: String?
  @NSManaged var desc: String?
  @NSManaged var rank: NSNumber?
  @NSManaged var amazonURLString: String?
  @NSManaged var imageURLString: String?
  @NSManaged var storedImageName: String?
}