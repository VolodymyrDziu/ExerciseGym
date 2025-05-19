import Foundation
import SwiftUI
// Модель для категории упражнений
enum ExerciseCategory: String, CaseIterable, Identifiable, Codable {
    case chest = "Грудь"
    case back = "Спина"
    case legs = "Ноги"
    case choulders = "shoulders"
    case arms = "Руки"
    case glutes = "glutes"
    
    var id : String {self.rawValue}
    
    var iconName: String {
        switch self{
        case.chest: return "chest"
        case.back: return "upperback"
        case.legs: return "legs"
        case.choulders: return "shoulders"
        case.arms: return "biceps"
        case.glutes: return "glutes"
        }
    }
   
}


// Модель для упражнения
struct ExerciseModel: Codable, Identifiable {
    var id = UUID() // Уникальный идентификатор
    let name: String // Название упражнения
    let description: String // Описание упражнения
    var videoName: String // Название видеофайла
    var sets: Int // Количество подходов
    var reps: Int // Количество повторений
    var weight: Double // Вес
    let category: ExerciseCategory
}

