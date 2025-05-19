//
// MARK:   ViewModel
//  ExerciseGym


import Foundation
import SwiftUI

// Экран редактирования упражнения
struct ExerciseEditView: View {
    let category: ExerciseCategory
    let model: WorkoutData
    @Binding var sets: Int
    @Binding var reps: Int
    @Binding var videoName: String
    @Binding var weight: Double
    @Environment(\.dismiss) private var dismiss // close modal
    
    var body: some View {
        NavigationView{
            Form {
                Section(header: Text("Редактировать упражнение")) {
                    Stepper("Подходы: \(sets)", value: $sets, in: 1...10)
                    Stepper("Повторения: \(reps)", value: $reps, in: 1...20)
                    TextField("videoName", text: $videoName)
                    HStack {
                        Text("Вес:")
                        TextField("Вес", value: $weight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button("Save"){
                        model.addExercise(ExerciseModel(id: UUID(), name: String(), description: String(), videoName: videoName, sets: sets, reps: reps, weight: weight, category: category))
                        dismiss()
                    }
                }
            }
        }
       
    }
}

