import Foundation

class TaskViewModel: ObservableObject {
    static let shared = TaskViewModel()
    
    @Published var title: String = ""
    @Published var description: String = ""
    @Published var points: Int = 0
    @Published var startDate: String = ""
    @Published var endDate: String = ""
    
    public func addTask() {
        let formattedStartDate = startDate.replacingOccurrences(of: ".", with: "-") + "T22:35:39.471Z"
        let formattedEndDate = endDate.replacingOccurrences(of: ".", with: "-") + "T22:35:39.471Z"
        let task = Activity(id: 0, name: self.title, description: self.description, points: self.points, startDate: formattedStartDate, endDate: formattedEndDate)
        
        APIManger.shared.addTaskRequest(task: task) { result in
            switch result {
            case .success(_):
                print("task added")
            case .failure(let error):
                print(error)
            }
        }
    }
}
