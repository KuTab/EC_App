import SwiftUI

struct ActivityResponseView: View {
    @State var responseList: [ActivityResponse] = []
    @State var refetch: Bool = false
    
    var body: some View {
        VStack {
            Text("Ответы")
                .font(.system(size: 25))
                .bold()
                .frame(maxWidth: .infinity, alignment: .center)
            
            
            ScrollView {
                ForEach(responseList, id: \.self) { response in
                    ResponseCellView(response: response, refetch: $refetch)
                }
            }
        }.onAppear(perform: fetchResponses)
            .onChange(of: refetch) { newValue in
                if newValue {
                    fetchResponses()
                }
                refetch = false
            }
    }
    
    private func fetchResponses() {
        APIManger.shared.taskResponsesRequest { result in
            switch result {
            case .success(let responses):
                responseList = responses
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ActivityResponseView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityResponseView()
    }
}
