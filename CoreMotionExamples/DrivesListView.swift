//
//  DrivesListView.swift
//  CoreMotionExamples
//
//  Created by Georgi Manev on 9.01.23.
//

import SwiftUI

struct DrivesListView: View {
    var driveScores: FetchedResults<DriveScoreEntity>
    @Environment(\.managedObjectContext) var managedObjectContext

    
    var body: some View {
        List {
            ForEach(driveScores) { item in
                    HStack {
                        VStack (alignment: .leading, spacing: 6) {
                            Text("Polestar 3")
                                .bold()
                            Text(String(item.value(forKey: "score") as! Int))
                            + Text(" ")
                            + Text(item.value(forKey: "grade") as! String).foregroundColor(getColor(grade: item.value(forKey: "grade") as! String))
                        }
                        Spacer()
                        Text(calcTime(date: stringToDate(dateString: item.value(forKey: "date") as! String)))
                            .foregroundColor(.gray)
                            .italic()
                    }
            }
            .listStyle(.plain)
            Button("Reset Data"){
                DataController().deleteAll(context: managedObjectContext)
            }.foregroundColor(Color.blue)
        }
        .listStyle(.plain)
    }
}

//struct DrivesListView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrivesListView()
//    }
//}
