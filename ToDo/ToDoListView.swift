//
//  ToDoListView.swift
//  ToDo
//
//  Created by RAMESH on 17/07/24.
//

import SwiftUI
import RealmSwift

struct ToDoListView: View {
    @ObservedResults(ToDo.self) var toDos
    @State private var name = ""
    @State private var searchFilter = ""
    @FocusState private var focus: Bool?
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                   TextField("New ToDo", text: $name)
                        .focused($focus,equals: true)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button(action: {
                        let newToDo = ToDo(name: name)
                        $toDos.append(newToDo)
                        name = ""
                        focus = nil
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                    })
                    .disabled(name.isEmpty)
                }
                .padding()
                List() {
                    ForEach(toDos.sorted(by: [SortDescriptor(keyPath: "completed"),
                                             SortDescriptor(keyPath: "urgency", ascending: false)])) { todo in
                       ToDoListRow(toDo: todo)
                    }
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
                .searchable(text: $searchFilter, collection: $toDos, keyPath: \.name) {
                    ForEach(toDos) { toDo in
                        Text(toDo.name)
                            .searchCompletion(toDo.name)
                    }
                }
                
            }
            .animation(.default, value: toDos)
            .navigationTitle("Realm ToDos")
        }
    }
}

#Preview {
    ToDoListView()
}
