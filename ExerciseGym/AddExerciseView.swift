import SwiftUI

struct AddExerciseView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var workoutData: WorkoutData
    let category: ExerciseCategory
    
    @State var name = ""
    @State private var description = ""
    @State private var videoName = ""
    @State private var sets = 3
    @State private var reps = 12
    @State private var weight = 0.0
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название")) {
                    TextField("Название упражнения", text: $name)
                }
                
                Section(header: Text("Описание")) {
                    TextField("Описание упражнения", text: $description)
                }
                
                Section(header: Text("Видео")) {
                    TextField("Название видеофайла", text: $videoName)
                }
                
                Section(header: Text("Подходы и повторения")) {
                    Stepper("Подходы: \(sets)", value: $sets, in: 1...10)
                    Stepper("Повторения: \(reps)", value: $reps, in: 1...20)
                }
                
                Section(header: Text("Вес")) {
                    TextField("Вес", value: $weight, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: {
                        // Создаем новое упражнение (надо выбрать категорию, например, .chest для теста)
                        let newExercise = ExerciseModel(
                            name: name,
                            description: description,
                            videoName: videoName,
                            sets: sets,
                            reps: reps,
                            weight: weight,
                            category: category // тут нужно передавать категорию из контекста или через параметр
                        )
                        workoutData.addExercise(newExercise)
                        dismiss()
                    }) {
                        Label("Добавить упражнение", systemImage: "plus")
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .disabled(name.isEmpty || description.isEmpty || videoName.isEmpty)
                }
            }
            .navigationTitle("Добавить упражнение")
        }
    }
}

