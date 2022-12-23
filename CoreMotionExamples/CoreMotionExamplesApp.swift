//
//  CoreMotionExamplesApp.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import SwiftUI

@main
struct CoreMotionExamplesApp: App {
//    @StateObject private var sheetsState = SheetsState(showDrivingView: false, showCompleteView: false)
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
//                .environmentObject(MotionTypes())
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(SheetsState())
        }
    }
}


class MotionTypes: ObservableObject {
    @Published var motionTypes = ["Device Motion", "Accelerometer", "Gyroscope", "Pedometer", "Magnetometer", "Altitude", "Headphone Motion Manager", "Historical Data", "Movement Disorder", "Fall Detection"]
}
