//
//  ContentView.swift
//  HabitTrackingApp
//
//  Created by Baymurat Abdumuratov on 12/03/24.
//

import SwiftUI

struct Activity: Codable, Hashable, Identifiable, Equatable{
    
    let id = UUID()
    let name: String
    let type: String
    let priority: String
    var completionCount: Int
    
}
@Observable
class Activities{
    var tasks = [Activity](){
        didSet{
            if let encoded = try? JSONEncoder().encode(tasks){
                UserDefaults.standard.set(encoded, forKey: "Tasks")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Tasks"){
            if let decodeTasks = try? JSONDecoder().decode([Activity].self, from: savedItems){
                tasks = decodeTasks
            }
        }
    }
    
    func updateActivity(id: UUID, newCount: Int){
        if let index = tasks.firstIndex(where: { $0.id == id }){
            tasks[index].completionCount = newCount
        }
    }
}

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach($activities.tasks){ $activity in
                    NavigationLink {
                        TaskDescription(name: activity.name, type: activity.type, priority: activity.priority, completionCount: $activity.completionCount)
                    } label: {
                        VStack{
                            HStack{
                                VStack{
                                    Text(activity.name)
                                        .font(.headline)
                                    Text(activity.type)
                                        .font(.caption)
                                }
                                Spacer()
                                Text(activity.priority)
                            }
                            
                        }
                    }

                    
                }
                .onDelete(perform: { indexSet in
                    removeTask(indexSet: indexSet)
                })
            }
            .navigationTitle("Habit Tracking")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Image(systemName: "plus" )
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddView, content: {
            AddView(activities: activities)
        })
        
    }
    
    func removeTask(indexSet: IndexSet){
        activities.tasks.remove(atOffsets: indexSet)
    }
}

#Preview {
    ContentView()
}
