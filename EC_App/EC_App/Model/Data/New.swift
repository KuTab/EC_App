import Foundation

struct New: Codable, Hashable {
    let id: Int
    let title: String
    let content: String
    let createdAt: String
    
    func toListViewModel() -> ListViewModel {
        ListViewModel(title: self.title, subtitle: self.content, addition: "")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case content
        case createdAt = "created_at"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(content, forKey: .content)
    }
}

let testNew = New(id: 0, title: "Новые игры в АК", content: "Совсем скоро в нашем лагере вы сможете поиграть в совершенно новые игры!", createdAt: "")

let testNewList = [testNew, testNew, testNew]
