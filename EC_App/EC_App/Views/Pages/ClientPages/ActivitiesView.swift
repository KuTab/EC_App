import SwiftUI

struct ActivitiesView: View {
    @State var activitiesList: [Activity] = []
    @State var bottomSheetIsShowed: Bool = false
    @State var presentedActivity: Activity = testActivity
    
    var body: some View {
        VStack {
            Text("Задания")
                .font(.system(size: 25))
                .bold()
            
            ScrollView {
                ForEach(activitiesList, id: \.self) { activity in
                    ActivityCellView(activity: activity)
                        .onTapGesture {
                            presentedActivity = activity
                            bottomSheetIsShowed.toggle()
                        }
                }
            }
        }.onAppear(perform: fetchActivities)
            .sheet(isPresented: $bottomSheetIsShowed) {
                ActivityDetailView(activity: $presentedActivity, submitable: true, isPresented: $bottomSheetIsShowed)
                    .padding(.top)
            }
    }
    
    private func fetchActivities() {
        APIManger.shared.tasksRequest { result in
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

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
