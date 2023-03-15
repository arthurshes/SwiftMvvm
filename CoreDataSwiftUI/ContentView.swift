//
//  ContentView.swift
//  CoreDataSwiftUI
//
//  Created by Артур Шестаков on 15.03.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var taskListVM = TaskListViewModel()
    
    func deleteTask(at offset:IndexSet){
        offset.forEach { index in
            let task = taskListVM.tasks[index]
            taskListVM.delete(task: task)
        }
        taskListVM.getAllTasks()
    }
    
    
    var body: some View {
        VStack {
            HStack{
                TextField("Введите название",text: $taskListVM.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save"){
                    taskListVM.save()
                    taskListVM.getAllTasks()
                }
            }
            
            List{
                ForEach(taskListVM.tasks,id: \.id){
                    task in
                    Text(task.title)
                }.onDelete(perform: deleteTask)
            }
            
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            taskListVM.getAllTasks()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
