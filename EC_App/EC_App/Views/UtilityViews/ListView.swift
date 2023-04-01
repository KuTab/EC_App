import SwiftUI

struct ListView: View {
    @State
    var viewModel: ListViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .bold()
                .padding(.vertical, 5)
            Text(viewModel.subtitle)
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
            Text(viewModel.addition)
                .padding(.vertical, 5)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(.gray.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel(title: "Test", subtitle: "Test", addition: "Test"))
    }
}
