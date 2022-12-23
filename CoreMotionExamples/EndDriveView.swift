//
//  EndDriveView.swift
//  CoreMotionExamples
//
//  Created by Georgi Manev on 9.01.23.
//

import SwiftUI

struct EndDriveView: View {
    @EnvironmentObject var sheetsState: SheetsState
    @ObservedObject var motionManager: MotionManager
    @Environment(\.managedObjectContext) var managedObjectContext
    var latestDrive: DriveScoreObject

    var body: some View {
        VStack{
            let v = print("LatestDrive", latestDrive.grade)
            let gz = print("LatestDrive", latestDrive.score)

            Button(action: {
                sheetsState.showCompleteView = false
            }) {
                HStack {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.white)
                    Text("Continue")
                }
                .padding()
                .background(Color.pink)
                .clipShape(Capsule())
                .foregroundColor(Color.white)
        }
    }
}
}

//struct EndDriveView_Previews: PreviewProvider {
//    static var previews: some View {
//        EndDriveView()
//    }
//}
