import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel = TaskViewModel.shared
    @Binding var isShowed: Bool
    @Binding var refetch: Bool
    
    var body: some View {
        VStack {
            Text("Создать задание")
                .font(.system(size: 25))
                .bold()
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Навзание")
                        TextField("", text: $viewModel.title)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Дата начала")
                        TextField("", text: $viewModel.startDate)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Дата окончания")
                        TextField("", text: $viewModel.endDate)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Описание")
                        TextEditor(text: $viewModel.description)
                            .frame(minHeight: 300)
                    }.padding()
                        .shadow(radius: 1)
                    
                    VStack(alignment: .leading) {
                        Text("Очки")
                        TextField("", value: $viewModel.points, format: .number).keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                        .shadow(radius: 1)
                }
                
                Button {
                    viewModel.addTask()
                    refetch.toggle()
                    isShowed.toggle()
                } label: {
                    Text("Создать задание")
                }.buttonStyle(.bordered)
            }
        }
    }
}
