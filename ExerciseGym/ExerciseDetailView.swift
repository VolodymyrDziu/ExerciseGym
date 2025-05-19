//
//  ExerciseDetailView.swift
//  ExerciseGym
//
//  Created by Volodymyr Dziubenko on 09.03.2025.
//

import SwiftUI
import AVKit
struct ExerciseDetailView: View {
  @State  var exercise: ExerciseModel
    @State private var showDetail = false
    let category: ExerciseCategory
    var body: some View {
        VStack {
            if let url = Bundle.main.url(forResource: exercise.videoName, withExtension: "mp4") {
                VideoPlayer(player: AVPlayer(url: url))
                    .frame(height: 300)
                    .cornerRadius(10)
            } else {
                Text("Видео не найдено")
                    .frame(height: 200)
            }
            
            Text(exercise.description)
                .font(.body)
                .padding()
            
            HStack {
                VStack {
                    Text("Подходы")
                    Text("\(exercise.sets)")
                }
                Spacer()
                VStack {
                    Text("Повторения")
                    Text("\(exercise.reps)")
                }
                Spacer()
                VStack {
                    Text("Вес")
                    Text("\(exercise.weight, specifier: "%.1f") кг")
                }
                .padding()
            }
            
            
            Spacer()
            RestTimerView()
        }
        .padding()
        .navigationTitle(exercise.name)
        .toolbar {
            Button("Edit"){
                showDetail.toggle()
            }
        }.sheet(isPresented: $showDetail){
            ExerciseEditView(category: category, model: WorkoutData(), sets: $exercise.sets, reps: $exercise.reps, videoName: $exercise.videoName, weight: $exercise.weight)
        }
    }
}


