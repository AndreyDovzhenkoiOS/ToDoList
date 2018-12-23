//
//  DatabaseManager.swift
//  ToDoList
//
//  Created by Anrey Dovzhenko on 05.12.2018.
//  Copyright © 2018 Andrey Dovzhenko. All rights reserved.
//

import UIKit
import CoreData

struct DatabaseManager {
    
    // MARK: - Public property
    
    static public let shared = DatabaseManager()
    
    public let context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer.viewContext
    }()
    
    //MARK: - Initialization
    
    private init() {}
    
    public func saveContext() {
        do { try context.save() } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    // MARK: - Public functions
    
    public func addToDatabase(for entityName: String, propertys: [String: Any?]) {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        setProperty(for: object, propertys: propertys)
    }
    
    public func getFromDatabase(for entityName: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            return try context.fetch(request) as! [NSManagedObject]
        } catch {
            return [NSManagedObject]()
        }
    }
    
    public func getFromDatabase(for nameEntity: String, predicate: NSPredicate) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: nameEntity)
        request.predicate = predicate
        do{
            let results = try context.fetch(request) as! [NSManagedObject]
            if !results.isEmpty {return results}
        } catch {print(error.localizedDescription)}
        
        return [NSManagedObject]()
    }
    
    public func removeFromDatabase(with model: NSManagedObject) {
        context.delete(model)
        saveContext()
    }
    
    public func removeAllFromDatabase(for entityName: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            try context.fetch(request).forEach { removeFromDatabase(with: $0 as! NSManagedObject) }
        } catch { fatalError(error.localizedDescription) }
    }
    
    public func setProperty(for object: NSManagedObject, propertys: [String: Any?]) {
        propertys.forEach {
            guard object.responds(to: NSSelectorFromString($0.key)) else { return }
            object.setValue($0.value, forKey: $0.key)
        }
        saveContext()
    }
}
