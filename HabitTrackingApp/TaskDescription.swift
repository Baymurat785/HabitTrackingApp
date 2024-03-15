//
//  TaskDescription.swift
//  HabitTrackingApp
//
//  Created by Baymurat Abdumuratov on 12/03/24.
//

import SwiftUI

struct TaskDescription: View {
   
    let name: String
    let type: String
    let priority: String
    @State var customColor: Color = Color.red
    @Binding  var completionCount: Int
 
    
    init() {
            self.name = "Task"
            self.type = "Work"
            self.priority = "Medium"
            _completionCount = .constant(0)
        }
    
    init(name: String, type: String, priority: String, completionCount: Binding<Int>) {
        self.name = name
        self.type = type
        self.priority = priority
        _completionCount = completionCount
    }

    var body: some View {
        
        NavigationStack{
            VStack{
                HStack(spacing: 40){
                    VStack{
                        Text("\(name)")
                            .font(.largeTitle)
                        
                        Text("\(type)")
                            .font(.headline)
                    }
                    
                    Circle()
                        .stroke(customColor, lineWidth: 35)
                        .frame(width: 100, height: 150)
                        .padding()
                        .overlay {
                            Text("\(priority)")
                                .bold()
                        }
                    
                }
                Spacer()
                VStack{
                    Rectangle()
                        .frame(width: 200, height: 200)
                        
                        .overlay(
                            RadialGradient(gradient:Gradient(colors: [Color.red, Color.blue]) , center: .bottom, startRadius: 10, endRadius: 200)
                                )
                        .clipShape(.rect(cornerRadius: 40))
                        .overlay {
                            Text("\(completionCount)")
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(.white)
                        }
                    HStack(spacing: 30){
                        Button {
                            decrementValue()
                        } label: {
                            Image(systemName: "minus.square.fill")
                                .resizable()
                                .frame(width: 75, height: 75)
                        }
                        
                        Button {
                            incrementValue()
                        } label: {
                            Image(systemName: "plus.app.fill")
                            
                                .resizable()
                                .frame(width: 75, height: 75)
                            
                        }

                    }
                    
                }
                Spacer()
                
            }
            
            .navigationTitle("Description of Task")
            .padding()
            Spacer()
               
        }
        
        .onAppear(perform: {
            if priority == "Medium"{
                customColor = Color.yellow
            }else if priority == "Low"{
                customColor = Color.green
            }else{
                customColor = Color.red
            }
        })
        
    }
    
    func incrementValue(){
        completionCount += 1
  
    }
    
    func decrementValue(){
        completionCount = max(0, completionCount - 1)
  
    }
}

#Preview {
    TaskDescription()
}
