import SwiftUI

struct ActivityCreationView: View {
    @StateObject var viewModel: TaskViewModel = TaskViewModel.shared
    @State var activitiesList: [Activity] = []
    @State var activityCreationIsShowed: Bool = false
    @State var bottomSheetIsPresented: Bool = false
    @State var presentedActivity: Activity = testActivity
    @State var refetch: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Text("Задания")
                    .font(.system(size: 25))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                Button {
                    activityCreationIsShowed.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .frame(maxWidth: .infinity, alignment: .trailing)

            }.padding(.horizontal, 20)
            
            ScrollView {
                ForEach(activitiesList, id: \.self) { activity in
                    ActivityCellView(activity: activity)
                        .onTapGesture {
                            presentedActivity = activity
                            bottomSheetIsPresented.toggle()
                        }
                }
            }
        }.onAppear(perform: fetchActivities)
            .sheet(isPresented: $bottomSheetIsPresented) {
                ActivityDetailView(activity: $presentedActivity, submitable: false, isPresented: $bottomSheetIsPresented)
            }
            .sheet(isPresented: $activityCreationIsShowed) {
                AddTaskView(isShowed: $activityCreationIsShowed, refetch: $refetch)
                    .padding(.top)
            }
            .onChange(of: refetch) { newValue in
                if newValue {
                    fetchActivities()
                    refetch = false
                }
            }
    }
    
    private func fetchActivities() {
        APIManger.shared.allTasksRequest { result in
            switch result {
            case .success(let activities):
                activitiesList = activities
                print("success: \(activities)")
            case .failure(let error):
                print(error)
            }
        }
    }
}

struct ActivityCreationView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityCreationView()
    }
}
