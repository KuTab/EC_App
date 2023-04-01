import SwiftUI

struct ResponseCellView: View {
    var response: ActivityResponse
    @Binding var refetch: Bool
    var body: some View {
        VStack {
            Text(response.userEmail ?? "")
                .bold()
                .padding(.vertical, 5)
            Text(response.answer ?? "")
                .padding(.vertical, 5)
                .padding(.horizontal, 5)
            Button {
                confirm()
            } label: {
                Text("Засчитать")
            }.buttonStyle(.bordered)
                .padding()
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
        .background(.gray.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
    
    private func confirm() {
        APIManger.shared.checkTaskRequest(id: String(response.id ?? 0)) { result in
            switch result {
            case.success(_):
                print("success")
                refetch = true
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ResponseCellView_Previews: PreviewProvider {
    static var previews: some View {
        ResponseCellView(response: testActivityResponse, refetch: .constant(false))
    }
}
