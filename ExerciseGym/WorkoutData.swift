import Foundation
import SwiftUI


class WorkoutData: ObservableObject {
  
    @Published var exercises: [ExerciseModel]
    init() {
        let loaded = Self.loadExercises()
        if loaded.isEmpty {
            exercises  = [
                
                ExerciseModel(name: "Грудь", description: "Exercise for chest", videoName: "chest", sets: 3, reps: 12, weight: 80, category: .chest),
                ExerciseModel(name: "Спина", description: "Exercise for back", videoName: "upper", sets: 3, reps: 12, weight: 70, category: .back),
                ExerciseModel(name: "Ноги", description: "Exercise for Ног", videoName: "", sets: 4, reps: 15, weight: 70, category: .legs),
                ExerciseModel(name: "choulders", description: "Exercise for choulders", videoName: "", sets: 4, reps: 12, weight: 90, category: .choulders),
                ExerciseModel(name: "Руки", description: "Exercise for Рук", videoName: "", sets: 4, reps: 12, weight: 60, category: .arms),
                ExerciseModel(name: "glutes", description: "Exercise for glutes", videoName: "", sets: 4, reps: 12, weight: 50, category: .glutes),
            ]
        }else {
            exercises = loaded
        }
    }
 
    func addExercise(_ exercise: ExerciseModel) {
         exercises.append(exercise)
         saveExercises()
     }


     func saveExercises() {
           let encoder = JSONEncoder()
           if let encoded = try? encoder.encode(exercises) {
               UserDefaults.standard.set(encoded, forKey: "savedExercises")
               print("encoder-->",encoder)
               print("encoded-->",encoded)
           }
      
       }
    
    func deletExercise(at indexSet: IndexSet){
           exercises.remove(atOffsets: indexSet)
           saveExercises()
        print("delet--> ",indexSet)
       }
    
    private static func loadExercises() -> [ExerciseModel]{
        guard let data = UserDefaults.standard.data(forKey: "savedExercises"),
              let decoded = try? JSONDecoder().decode([ExerciseModel].self, from: data) else {
            return []
        }
      print("-data--> ",data)
        return decoded

    }
    
    
    func getExercises(for category: ExerciseCategory) -> [ExerciseModel] {
        return exercises.filter{ $0.category == category }
    }
    
    
    
}
