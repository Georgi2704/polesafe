//
//  DrivingView.swift
//  CoreMotionExamples
//
//  Created by Georgi Manev on 9.01.23.
//

import SwiftUI

struct DrivingView: View {
    @EnvironmentObject var sheetsState: SheetsState
    @ObservedObject var motionManager: MotionManager
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var showCompleteView = false
    @State var driveScoreObject: DriveScoreObject = DriveScoreObject(id: 0, date: "", duration: "", grade: "", score: "")

    var body: some View {
        if !showCompleteView{
            VStack{
                Text("Driving ...")
                    .font(.system(size: 36)).bold()
                Spacer().frame(height: 60)
                Button(action: {
                    motionManager.stopAccelerometers()
                    driveScoreObject = DataController().batchAddAccelerometer(data: motionManager.getAccelerometerData(), context: managedObjectContext)
                    showCompleteView = true
                }) {
                    HStack {
                        Image(systemName: "stop.fill")
                            .foregroundColor(Color.white)
                        Text("Stop Drive")
                    }
                    .padding()
                    .background(Color.pink)
                    .clipShape(Capsule())
                    .foregroundColor(Color.white)
                }
            }
        }
        else {
            VStack{
                Text("Drive Completed !")
                    .font(.system(size: 36)).bold()
                Spacer().frame(height: 50)
                Text("Your Score: ")
                    .font(.system(size: 30))
                Text(driveScoreObject.score)
                    .font(.system(size: 50)).bold()
                Spacer().frame(height: 30)
                Text("Your Grade: ")
                    .font(.system(size: 36))
                Text(driveScoreObject.grade)
                    .font(.system(size: 46)).bold()
                Button(action: {
                    sheetsState.showDrivingView = false
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
}
//struct DrivingView_Previews: PreviewProvider {
//    static var previews: some View {
//        DrivingView()
//    }

