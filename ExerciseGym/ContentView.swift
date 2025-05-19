//
//  ContentView.swift
//  ExerciseGym


import SwiftUI

struct ContentView: View {
    @StateObject private var workoutData = WorkoutData() // Данные упражнений
    let columns = [GridItem(.adaptive(minimum: 150))] // Сетка для отображения категорий
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(ExerciseCategory.allCases, id: \.self) { category in
                        NavigationLink(destination: ExerciseListView(workoutData: workoutData, category: category)) {
                            VStack {
                                Image(category.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                Text(category.rawValue) // ✔️ Исправлено
                                    .font(.headline)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Категории упражнений")
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
