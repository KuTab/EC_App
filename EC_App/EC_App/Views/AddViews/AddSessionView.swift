import SwiftUI

struct AddSessionView: View {
    @ObservedObject var viewModel: SessionViewModel = SessionViewModel.shared
    @Binding var isPresented: Bool
    @Binding var refetch: Bool
    
    var body: some View {
        VStack {
            Text("Создать смену")
                .font(.system(size: 25))
                .bold()
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Навзание")
                        TextField("", text: $viewModel.name)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Номер смены")
                        TextField("", text: $viewModel.number)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Дата заезда")
                        TextField("", text: $viewModel.startDate)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Дата отъезда")
                        TextField("", text: $viewModel.endDate)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Описание")
                        TextEditor(text: $viewModel.description)
                            .frame(minHeight: 300)
                    }.padding()
                        .shadow(radius: 1)
                }
                
                Button {
                    viewModel.createSession()
                    refetch.toggle()
                    isPresented.toggle()
                } label: {
                    Text("Создать сессию")
                }.buttonStyle(.bordered)
            }
        }
    }
}
