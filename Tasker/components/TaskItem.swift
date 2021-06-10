//
//  TaskItem.swift
//  Tasker
//
//  Created by Felix Tesche on 31.05.21.
//

import SwiftUI

struct TaskItem: View {
    
    @EnvironmentObject var taskStore : TaskStore
    @State var task : Task
    
    var body: some View {
        HStack {
            Button(action: {
                task.isDone = !task.isDone
                
                taskStore.update(taskID: task.id)
            }) {
                if(task.isDone) {
                    Image(systemName: "record.circle")
                } else {
                    Image(systemName: "circle")
                }
            }
            Text(task.task)
        }
    }
}

struct TaskItem_Previews: PreviewProvider {
    static var previews: some View {
        TaskItem(task: Task(taskDB: TaskDB()))
    }
}
