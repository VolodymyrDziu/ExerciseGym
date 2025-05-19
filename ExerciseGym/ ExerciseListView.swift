
import SwiftUI

struct ExerciseListView: View {
    @ObservedObject var workoutData: WorkoutData
    let category: ExerciseCategory
    @State private var showingAddExerciseView = false

    var body: some View {
        List {
            Section {
                ForEach(workoutData.getExercises(for: category), id: \.id) { exercise in
                    NavigationLink(destination: ExerciseDetailView(exercise: exercise, category: category)) {
                        Text(exercise.name)
                    }
                }.onDelete(perform: workoutData.deletExercise)
            }
            
          
        }
        .navigationTitle(category.iconName)
        .sheet(isPresented: $showingAddExerciseView) {
            AddExerciseView(workoutData: workoutData, category: category)
        }
        .toolbar {
            Button("Add") {
                
                showingAddExerciseView = true
            }
            Image(systemName: "plus")
        }
    }
}
