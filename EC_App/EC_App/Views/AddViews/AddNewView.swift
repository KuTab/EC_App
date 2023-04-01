import SwiftUI

struct AddNewView: View {
    @ObservedObject var viewModel: NewViewModel = NewViewModel.shared
    @Binding var isShowed: Bool
    @Binding var refetch: Bool
    
    var body: some View {
        VStack {
            Text("Создать новость")
                .font(.system(size: 25))
                .bold()
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("Заголовок")
                        TextField("", text: $viewModel.title)
                            .textFieldStyle(.roundedBorder)
                    }.padding()
                    
                    VStack(alignment: .leading) {
                        Text("Контент")
                        TextEditor(text: $viewModel.content)
                            .frame(minHeight: 300)
                    }.padding()
                        .shadow(radius: 1)
                }
                
                Button {
                    viewModel.postNew()
                    refetch.toggle()
                    isShowed.toggle()
                } label: {
                    Text("Создать новость")
                }.buttonStyle(.bordered)
            }
        }
    }
}
