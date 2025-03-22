import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct ContentView: View {
    @State private var todoItems: [TodoItem] = []
    @State private var newTaskTitle: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("New task", text: $newTaskTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    let newTask = TodoItem(title: newTaskTitle, isCompleted: false)
                    todoItems.append(newTask)
                    newTaskTitle = ""
                }) {
                    Text("Add")
                }
            }
            List {
                ForEach(todoItems) { item in
                    HStack {
                        Text(item.title)
                        Spacer()
                        if item.isCompleted {
                            Image(systemName: "checkmark")
                        }
                    }
                    .onTapGesture {
                        if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
                            todoItems[index].isCompleted.toggle()
                        }
                    }
                }
                .onDelete { indexSet in
                    todoItems.remove(atOffsets: indexSet)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
