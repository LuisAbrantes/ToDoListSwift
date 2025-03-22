import SwiftUI

struct TodoItem: Identifiable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
}

struct ContentView: View {
    @State private var todoItems: [TodoItem] = []
    @State private var newTaskTitle: String = ""
    
    // Cores personalizadas
    let primaryColor = Color(red: 0.3, green: 0.8, blue: 0.6)
    let secondaryColor = Color(red: 0.2, green: 0.6, blue: 0.5)
    let backgroundColor = Color(.systemGray6)
    
    var body: some View {
        ZStack {
            // Cor de fundo
            backgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                // Título
                Text("My ToDo List")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(primaryColor)
                    .padding(.top)
                
                // Campo de adicionar tarefa
                HStack {
                    TextField("Add a new task", text: $newTaskTitle)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    
                    Button(action: {
                        let newTask = TodoItem(title: newTaskTitle, isCompleted: false)
                        todoItems.append(newTask)
                        newTaskTitle = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(secondaryColor)
                            .font(.system(size: 30))
                    }
                }
                .padding()
                
                // Lista de tarefas
                List {
                    ForEach(todoItems) { item in
                        TaskCard(item: item) {
                            if let index = todoItems.firstIndex(where: { $0.id == item.id }) {
                                todoItems[index].isCompleted.toggle()
                            }
                        }
                    }
                    .onDelete { indexSet in
                        todoItems.remove(atOffsets: indexSet)
                    }
                    .listRowBackground(backgroundColor) // Cor de fundo para cada linha
                }
                .listStyle(PlainListStyle())
                
                Spacer()
            }
            .padding()
        }
    }
}

struct TaskCard: View {
    let item: TodoItem
    let toggleCompletion: () -> Void
    
    var body: some View {
        HStack {
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? Color.green : Color.gray)
                .onTapGesture {
                    toggleCompletion()
                }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 3)
    }
}

#Preview {
    ContentView()
}
