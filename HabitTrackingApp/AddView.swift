//
//  AddView.swift
//  HabitTrackingApp
//
//  Created by Baymurat Abdumuratov on 12/03/24.
//

import SwiftUI

struct AddView: View {
   
    @State private var type = "Health"
    @State private var priority = "Medium"
    @State private var name = ""
    @Environment(\.dismiss) var dismiss
    
    var activities: Activities
    let types = ["Health", "Work", "Personal Development"]
    let priorities = ["High", "Medium", "Low"]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Enter name of the task", text: $name)
                }
                Picker("Category", selection: $type){
                    ForEach(types, id: \.self){
                        Text($0)
                    }
                }
                
                .pickerStyle(DefaultPickerStyle())
                Section{
                    Text("Select the priority:")
                    Picker("Select the priroty of the task", selection: $priority){
                        
                        
                        // Do not forget to give colors the priorities
                        
                        ForEach(priorities, id: \.self){
                            Text($0)
                        }
                        
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
            .navigationTitle("Add new task")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let task = Activity(name: name, type: type, priority: priority, completionCount: 0)
                        activities.tasks.append(task)
                        dismiss()
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
   
    }
}

#Preview {
    AddView(activities: Activities())
}
