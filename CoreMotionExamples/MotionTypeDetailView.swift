//
//  MotionTypeDetailView.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import SwiftUI

struct MotionTypeDetailView: View {
    
    var motionType: String
    @ObservedObject var motionManager: MotionManager
//    @Environment(\.managedObjectContext) var managedObjectContext

        
    var body: some View {
        VStack{
            if motionType == "Device Motion" {
                DeviceMotionDetailView(motionType: motionType, motionManager: motionManager)
            } else {
                SensorDetailView(motionType: motionType, motionManager: motionManager)
            }
        }
        .navigationTitle(motionType)
    }
}

struct MotionTypeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MotionTypeDetailView(motionType: "Device Motion", motionManager: MotionManager())
    }
}
