import Foundation

struct Achievement: Decodable, Hashable {
    let name: String
    let description: String
    let score: String
    
    public func toListViewModel() -> ListViewModel {
        ListViewModel(title: self.name, subtitle: self.description, addition: self.score)
    }
}

let testAchievement = Achievement(name: "Активити", description: "Вы были одним из самых активных на смене 323", score: "200 очков")
let testAchievementList = [testAchievement, testAchievement, testAchievement]
