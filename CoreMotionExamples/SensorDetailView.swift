//
//  SensorDetailView.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import SwiftUI
import Charts


struct SensorDetailView: View {
    
    var motionType: String
    @ObservedObject var motionManager: MotionManager
    
    var body: some View {
            switch motionType {
            case "Accelerometer" :
                AccelerometerView(motionManager: motionManager)
            default:
                Text("\(motionType) to be implemented")
            }
    }
}

struct SensorDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SensorDetailView(motionType: "Accelerometer", motionManager: MotionManager())
    }
}
