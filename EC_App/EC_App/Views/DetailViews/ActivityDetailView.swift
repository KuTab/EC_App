import SwiftUI

struct ActivityDetailView: View {
    @Binding var activity: Activity
    var submitable: Bool
    @Binding var isPresented: Bool 
    @State var answer: String = ""
    var body: some View {
        VStack {
            Text(activity.name)
                .bold()
                .font(.system(size: 25))
                .padding()
            Text(activity.description)
                .padding()
            Text(String(activity.points) + " очков")
                .padding()
            if submitable {
                Text("Ответ")
                    .padding()
                TextEditor(text: $answer)
                    .shadow(radius: 1)
                    .padding()
                Button {
                    submitAnswer()
                    isPresented.toggle()
                } label: {
                    Text("Отправить ответ")
                }.buttonStyle(.bordered)
                    .padding()
            }
        }
    }
    
    private func submitAnswer() {
        let taskAnswer = ActivityAnswer(answer: self.answer)
        APIManger.shared.submitTaskRequest(id: String(activity.id),answer: taskAnswer) { result in
            switch result {
            case.success(_):
                print("Task submitted")
            case .failure(let error):
                print(error)
            }
        }
    }
}
