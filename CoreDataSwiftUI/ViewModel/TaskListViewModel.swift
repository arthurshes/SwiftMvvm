//
//  TaskListViewModel.swift
//  CoreDataSwiftUI
//
//  Created by Артур Шестаков on 15.03.2023.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject{
    
    var title:String = ""
@Published var tasks:[TaskViewModel]=[]
    
    func getAllTasks(){
       tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
    
    func delete(task:TaskViewModel){
        let exitingTask = CoreDataManager.shared.getTaskById(id: task.id)
        if  let exitingTask = exitingTask{
            CoreDataManager.shared.deleteTask(tasks: exitingTask)
        }
    }
    
    func save(){
        
        let task = Tasks(context: CoreDataManager.shared.viewContext)
        task.title = title
        
        CoreDataManager.shared.save()
        
    }
}
struct TaskViewModel{
    let task:Tasks
    
    var id: NSManagedObjectID{
        return task.objectID
    }
    
    var title:String{
        return task.title ?? ""
    }
}
