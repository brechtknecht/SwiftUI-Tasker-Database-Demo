//
//  TaskStore.swift
//  Backstage
//
//  Created by Felix Tesche on 25.05.21.
//

import Foundation
import RealmSwift

final class TaskStore: ObservableObject {
    private var results: Results<TaskDB>
    
    // Das ist die Variable mit der wir im Interface auf alle Tasks Zugreifen können
    // Dafür muss der Property Wrapper:
    /// @EnvironmentObject var taskStore : TaskStore
    // eingebunden werden
    
    var tasks: [Task] {
        results.map(Task.init)
    }
    
    // Initialisiert die Realm Datenbank
    // Wird in ContentView.swift aufgerufen und ist
    // dann global als @Environment Object aufrufbar
    init(realm: Realm) {
        results = realm.objects(TaskDB.self)
    }
    
    // Findet einen bestimmten Task
    // Dafür wird nur die ID des Tasks benötigt
    func findByID (id: Int) -> TaskDB! {
        do {
            return try Realm().object(ofType: TaskDB.self, forPrimaryKey: id)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
}

// MARK: - CRUD Actions
extension TaskStore {
    
    // Erstellt einen neuen Task mit einem angegebenen Namen
    // Per default wird der isDone Bool auf false gesetzt
    func create(task: String) {
        
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let refDB = TaskDB()
            
            let id = UUID().hashValue
            refDB.id = id
            refDB.task = task
            refDB.isDone = false
            
            try realm.write {
                realm.add(refDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
    
    
    // Updated eine gegebene Task. Dafür wird die ID benötigt,
    // welche in der Datenbank danach sucht und dann nach den mitgegebenen
    // Parametern aktualisiert.
    /// text und isDone sind hierbei optional
    func update(taskID: Int, text: String? = nil, isDone: Bool? = nil) {
        // TODO: Add Realm update code below
        objectWillChange.send()
        
        let previousTask = self.findByID(id: taskID)!
                
        do {
            let realm = try Realm()
            
            try realm.write {
                let updatedTask = TaskDB()
                updatedTask.id     = taskID
                
                if(text == nil) {
                    updatedTask.task = previousTask.task
                } else {
                    updatedTask.task = text!
                }
                
                if(isDone == nil) {
                    updatedTask.isDone = previousTask.isDone
                } else {
                    updatedTask.isDone = isDone!
                }
                
                updatedTask.isDone = isDone ?? false
                
                realm.add(updatedTask, update: .modified)
            }
            
        } catch let err {
            print(err.localizedDescription)
        }
    }
    
    func delete(indexSet: IndexSet) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            indexSet.forEach ({ index in
                try! realm.write {
                    realm.delete(self.results[index])
                }
            })
        } catch let err {
            print(err.localizedDescription)
        }
    }
}

