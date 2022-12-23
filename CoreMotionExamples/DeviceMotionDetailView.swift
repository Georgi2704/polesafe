//
//  DeviceMotionDetailView.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import SwiftUI
import CoreMotion

struct DeviceMotionDetailView: View {
//    @Environment(\.managedObjectContext) var managedObjectContext

    var motionType: String
    @ObservedObject var motionManager:MotionManager
    
    var body: some View {
        List{
            NavigationLink("Attitude", destination: DeviceMotionTypeDetailView(motionType: "Attitude", motionManager: motionManager))
            NavigationLink("Heading", destination: DeviceMotionTypeDetailView(motionType: "Heading", motionManager: motionManager))
            NavigationLink("Magnetic Field", destination: DeviceMotionTypeDetailView(motionType: "Magnetic Field", motionManager: motionManager))
            NavigationLink("User Acceleration", destination: DeviceMotionTypeDetailView(motionType: "User Acceleration", motionManager: motionManager))
            NavigationLink("Rotation Rate", destination: DeviceMotionTypeDetailView(motionType: "Rotation Rate", motionManager: motionManager))
            NavigationLink("Gravity", destination: DeviceMotionTypeDetailView(motionType: "Gravity", motionManager: motionManager))
            NavigationLink("Sensor Location", destination: DeviceMotionTypeDetailView(motionType: "Sensor Location", motionManager: motionManager))
        }.onAppear(perform: motionManager.startDeviceMotion)
    }


   

}


struct DeviceMotionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceMotionDetailView(motionType: "Device Motion", motionManager: MotionManager())
    }
}
