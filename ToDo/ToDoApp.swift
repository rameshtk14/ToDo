//
//  ToDoApp.swift
//  ToDo
//
//  Created by RAMESH on 17/07/24.
//

import SwiftUI

@main
struct ToDoApp: App {
    var body: some Scene {
        WindowGroup {
            ToDoListView()
                .onAppear() {
                    print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
                }
        }
    }
}
