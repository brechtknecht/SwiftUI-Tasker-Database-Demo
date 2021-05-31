//
//  Task.swift
//  Tasker
//
//  Created by Felix Tesche on 25.05.21.
//

import Foundation
import RealmSwift


@objcMembers class TaskDB: Object {
    dynamic var id      = 0
    dynamic var task    = ""
    
    override static func primaryKey() -> String? {
        "id"
    }
}

enum TaskDBKeys : String {
    case id     = "id"
    case task   = "task"
}

struct Task : Identifiable, Hashable {
    let id          : Int
    let task        : String
    
    init(taskDB: TaskDB) {
        id      = taskDB.id
        task    = taskDB.task
    }
}
