import Foundation

struct Session: Codable, Hashable {
    var id: Int
    var number: String
    var startDate: String
    var endDate: String
    var description: String
    var name: String
    
    public func toListViewModel() -> ListViewModel {
        let formattedDate = String(self.startDate.prefix(10)).replacingOccurrences(of: "-", with: ".")
        let elements = formattedDate.split(separator: ".")
        let finalStartDate = elements[2] + "." + elements[1] + "." + elements[0]
        return ListViewModel(title: self.number , subtitle: self.name, addition: finalStartDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case number
        case name
        case startDate = "start_date"
        case endDate = "end_date"
        case description
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(number, forKey: .number)
        try container.encode(description, forKey: .description)
        try container.encode(name, forKey: .name)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
    }
}

let testSession = Session(id: 0, number: "353", startDate: "25.06.2023", endDate: "30.06.2023", description: "Смена в Звенигородском", name: "АК в будущем")
