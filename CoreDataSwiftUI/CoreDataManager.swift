//
//  CoreDataManager.swift
//  CoreDataSwiftUI
//
//  Created by Артур Шестаков on 15.03.2023.
//

import Foundation
import CoreData

class CoreDataManager{
    
let persistenContainet: NSPersistentContainer
static let shared = CoreDataManager()
    var viewContext : NSManagedObjectContext{
        return persistenContainet.viewContext
    }
    
    func getTaskById(id:NSManagedObjectID)-> Tasks? {
        do{
            return try viewContext.existingObject(with: id) as? Tasks
        }catch{
            return nil
        }
    }
    
    
    func deleteTask(tasks:Tasks){
        viewContext.delete(tasks)
        save()
    }
    
    func save(){
        do{
         try viewContext.save()
        } catch{
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getAllTasks() -> [Tasks] {
        let request: NSFetchRequest <Tasks> = Tasks.fetchRequest()
        do{
         return try viewContext.fetch(request)
        }catch{
            print(error)
            return []
        }
    }
    
  private  init() {
     persistenContainet = NSPersistentContainer(name: "TaskModel")
        persistenContainet.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Error stack data \(error)")
            }
        }
    }
}
