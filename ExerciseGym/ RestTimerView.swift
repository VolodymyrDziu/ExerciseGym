//
//   RestTimerView.swift
//  ExerciseGym
//
//  Created by Volodymyr Dziubenko on 09.03.2025.
//

import SwiftUI
import AudioToolbox
import AVFAudio



struct RestTimerView: View {
    @State private var timeRemaining: Int
    @State private var timerIsRunning = false
    @State private var showEditTimeView = false
    @State private var newTime: Int
    @State private var audioPlayer: AVAudioPlayer?
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // Инициализатор с начальным значением времени
    init(initialTime: Int = 60) {
        _timeRemaining = State(initialValue: initialTime)
        _newTime = State(initialValue: initialTime)
    }
    
    var body: some View {
        VStack {
            // Отображение оставшегося времени
            Text("Отдых: \(timeRemaining) сек")
                .font(.title)
                .onReceive(timer) { _ in
                    if timerIsRunning && timeRemaining > 0 {
                        timeRemaining -= 1
                        if timeRemaining == 0 {
                            // Воспроизводим звуковой сигнал
                            playTrainHorn()
                            //AudioServicesPlaySystemSound(1021)
                            
                            timerIsRunning = false // Останавливаем таймер
                        }
                    }
                }
          
            
            // Кнопки управления таймером
            HStack {
                Button(timerIsRunning ? "Стоп" : "Старт") {
                    timerIsRunning.toggle()
                }
                .padding()
                
                Button("Сброс") {
                    resetTimer()
                }
                .padding()
            }
            
            // Кнопка для редактирования времени
            Button("Изменить время") {
                showEditTimeView = true
            }
            .padding()
            .sheet(isPresented: $showEditTimeView) {
                EditTimeView(newTime: $newTime, onSave: updateTimer)
            }
        }
    }
    
    func playTrainHorn() {
            guard let url = Bundle.main.url(forResource: "race_start", withExtension: "mp3")
        else{
                return
            }
           
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Ошибка воспроизведения звука: \(error.localizedDescription)")
            }
        }
    // Сброс таймера
    private func resetTimer() {
        timeRemaining = newTime
        timerIsRunning = false
    }
    
    // Обновление времени таймера
    private func updateTimer() {
        timeRemaining = newTime
        showEditTimeView = false
    }
}

// Экран для редактирования времени
struct EditTimeView: View {
    @Binding var newTime: Int
    var onSave: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Установите время отдыха")) {
                    Stepper("Время: \(newTime) сек", value: $newTime, in: 10...300, step: 10)
                }
            }
            .navigationTitle("Изменить время")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Сохранить") {
                        onSave()
                    }
                }
            }
        }
    }
}
