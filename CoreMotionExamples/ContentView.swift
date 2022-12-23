//
//  ContentView.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    

    @State private var showDriveView = false
    @StateObject var motionManager = MotionManager()
//    @EnvironmentObject var motionTypes: MotionTypes
    @Environment(\.managedObjectContext) var managedObjectContext
    @EnvironmentObject var sheetsState: SheetsState
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var accelerometer: FetchedResults<AccelerometerEntity>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var driverScores: FetchedResults<DriveScoreEntity>


    
//    let coreDataManager = CoreDataManager(modelName: "SensorData")
    
    func getAverageDriverScore (allScores: FetchedResults<DriveScoreEntity>) -> Int {
        var totalScore = 0
        print("ALL SCORES", allScores)
        
        for i in stride(from: 0, to: allScores.count, by: 1){
            let score = allScores[i].value(forKey: "score") as! Int
            totalScore += score
            print("Score", score)
        }
         print(totalScore)
        var averageTotalScore = 0
        if (allScores.count > 0){
            averageTotalScore = totalScore/allScores.count
        }

        print("Average Total Score", averageTotalScore)
        return averageTotalScore
    }
        
    var body: some View {
        let averageDriveScore = getAverageDriverScore(allScores: driverScores)
        let averageDriveGrade = averageDriveScore > 0 ? getDriveScoreGrade(score: averageDriveScore) : "Start your first drive" 
    
        NavigationView {
                VStack(alignment: .center){
                    Text("Driver Score").font(.system(size: 24))
                    Spacer().frame(height: 40)
                    Speedometer(progress: Double(averageDriveScore/10))
                    Spacer().frame(height: 20)
                    Text(String(averageDriveScore)).font(.system(size: 32)).bold()
                    Text(averageDriveGrade).font(.system(size: 24)).bold()
                    Spacer().frame(height: 60)
                    Button(action: {
                        sheetsState.showDrivingView = true
                        motionManager.startAccelerometers()
                    }) {
                        HStack {
                            Image(systemName: "car")
                                .foregroundColor(Color.white)
                            Text("Start Drive")
                        }
                        .padding()
                        .background(Color.pink)
                        .clipShape(Capsule())
                        .foregroundColor(Color.white)
                    }.fullScreenCover(isPresented: $sheetsState.showDrivingView){
                        DrivingView(motionManager: motionManager).environmentObject(sheetsState)
                    }
//                    AccelerometerView(motionManager: motionManager)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        NavigationLink(destination: DrivesListView(driveScores: driverScores)){
                            Text("Drive History")
                        }
                    }
                }
                .navigationBarTitle(Text("PoleSafe"))
                .navigationBarItems(leading: Text("Georgi Manev"))
            }
        }
        
    }
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
