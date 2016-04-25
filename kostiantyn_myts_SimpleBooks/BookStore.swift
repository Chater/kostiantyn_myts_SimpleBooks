//
//  BookStore.swift
//  kostiantyn_myts_SimpleBooks
//
//  Created by Chater on 4/25/16.
//  Copyright © 2016 Kostia Myts. All rights reserved.
//
import UIKit
import CoreData

class BookStore {
  
  static let sharedStore = BookStore()

  lazy private var applicationDocumentsDirectory: NSURL = {
    let URLs = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
    return URLs[URLs.count - 1] as NSURL
  }()
  
  lazy private var managedObjectContext: NSManagedObjectContext = {
      let moc = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
      moc.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
      moc.persistentStoreCoordinator = self.persistentStoreCoordinator
      return moc
  }()
  
  lazy private var managedObjectModel: NSManagedObjectModel = {
      let url = NSBundle.mainBundle().URLForResource("BookStore", withExtension: "momd")!
      return NSManagedObjectModel(contentsOfURL: url)!
  }()
  
  lazy private var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
    let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
    let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("BookStore.sqlite")
    let options = [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true]
    
    do {
      try persistentStoreCoordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: options)
    }
    catch {
      print(error)
    }
    
    return persistentStoreCoordinator
  }()
  
  private func save() {
    let moc = managedObjectContext
    
    moc.performBlockAndWait {
      if moc.hasChanges
      {
        do {
          try moc.save()
        }
        catch {
          print(error)
        }
      }
    }
  }
  
  deinit {
    save()
  }
}

extension BookStore {
  class func isSaved(book: Book) -> Bool {
    return (managedBookById(book.id) != nil)
  }
  
  class func save(book: Book) {
    let managedBook = NSEntityDescription.insertNewObjectForEntityForName("ManagedBook", inManagedObjectContext: BookStore.sharedStore.managedObjectContext) as! ManagedBook
    
    managedBook.bookId = book.id
    managedBook.title = book.title
    managedBook.author = book.author
    managedBook.desc = book.description
    managedBook.rank = book.rank
    managedBook.amazonURLString = book.amazonURL.absoluteString
    managedBook.imageURLString = book.imageURL.absoluteString
    
    BookStore.sharedStore.save()
  }
  
  class func remove(book: Book) {
    if let managedBook = managedBookById(book.id) {
      let moc = BookStore.sharedStore.managedObjectContext
      moc.deleteObject(managedBook)
      BookStore.sharedStore.save()
    }
  }
  
  class func managedBookById(id: String) -> ManagedBook? {
    let fetchRequest = NSFetchRequest(entityName: "ManagedBook")
    let predicate = NSPredicate(format: "bookId == %@", id)
    fetchRequest.predicate = predicate
    
    let moc = BookStore.sharedStore.managedObjectContext
    
    do {
      let managedBooks = try moc.executeFetchRequest(fetchRequest) as? [ManagedBook]
      if managedBooks?.count > 1 {
        assertionFailure("Too many object!")
        return nil
      }
      else {
        return managedBooks?.first
      }
    }
    catch {
      return nil
    }
  }
  
  class func getAll() -> [ManagedBook]? {
    let moc = BookStore.sharedStore.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "ManagedBook")
    
    do {
      return try moc.executeFetchRequest(fetchRequest) as? [ManagedBook]
    } catch {
      return nil
    }
  }
  
  class func removeAll() {
    let moc = BookStore.sharedStore.managedObjectContext
    
    getAll()?.forEach {
      managedBook in
      
      moc.deleteObject(managedBook)
    }
    
    BookStore.sharedStore.save()
  }
}