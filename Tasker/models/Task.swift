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
    dynamic var isDone  = false
    
    override static func primaryKey() -> String? {
        "id"
    }
}

enum TaskDBKeys : String {
    case id     = "id"
    case task   = "task"
    case isDone = "isDone"
}

struct Task : Identifiable, Hashable {
    let id          : Int
    let task        : String
    var isDone      : Bool
    
    init(taskDB: TaskDB) {
        id      = taskDB.id
        task    = taskDB.task
        isDone  = taskDB.isDone
    }
}
