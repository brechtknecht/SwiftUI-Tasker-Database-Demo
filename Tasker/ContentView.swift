//
//  ContentView.swift
//  Tasker
//
//  Created by Felix Tesche on 25.05.21.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var taskStore : TaskStore
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            Section {
                List{
                    ForEach(taskStore.tasks, id: \.id) { task in
                        Text(task.task)
                    }.onDelete(perform: self.delete)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .navigationBarTitle(Text("Tasker"))
            .navigationBarItems(trailing:
                Button("Add Task") {
                    showingSheet.toggle()
                }
            )
        }
        .sheet(isPresented: $showingSheet) {
            CreateTaskSheet()
        }
    }
    
    func delete (with indexSet: IndexSet) {
        taskStore.delete(indexSet: indexSet)
    }
}

struct CreateTaskSheet: View {
    @Environment (\.presentationMode) var presentationMode
    
    @EnvironmentObject var taskStore : TaskStore
    
    @State var taskName : String = ""

    var body: some View {
        Form {
            VStack(spacing: 20) {
                TextField("Enter your new Task", text: $taskName)
            }
            Button("Create new Task") {
                taskStore.create(task: taskName)
                presentationMode.wrappedValue.dismiss()
            }
        }
        
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
