import Foundation

struct Activity: Codable, Hashable {
    let id: Int
    let name: String
    let description: String
    let points: Int
    let startDate: String
    let endDate: String
    
    public func toListViewModel() -> ListViewModel {
        ListViewModel(title: self.name, subtitle: self.description, addition: String(self.points) + " очков")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case description
        case points
        case startDate = "start_date"
        case endDate = "end_date"
    }
    
    func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(points, forKey: .points)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        }
}

struct ActivityAnswer: Codable, Hashable {
    let answer: String
}

let testActivity = Activity(id: 0, name: "Статья \"Почему я жду смену 334\"", description: "Напишите небольшую статью на тему \"Почему я жду смену 334\". Рекомендуемый объем: 300 - 500 слов", points: 250, startDate: "", endDate: "")

