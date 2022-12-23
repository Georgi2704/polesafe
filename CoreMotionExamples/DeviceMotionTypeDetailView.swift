//
//  DeviceMotionTypeDetailView.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import SwiftUI
import CoreMotion

struct DeviceMotionTypeDetailView: View {
    
    var motionType:String
    @ObservedObject var motionManager: MotionManager
//    @Environment(\.managedObjectContext) var managedObjectContext

        
    var body: some View {
        VStack{
            if let data = motionManager.deviceMotionData {
                switch motionType{
                case "Attitude" :
                        HStack{
                            Text("Pitch:")
                                .frame(width: 200, height: 200)
                            Text("\(data.attitude.pitch)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Roll:")
                                .frame(width: 200, height: 200)
                            Text("\(data.attitude.roll)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Yaw:")
                                .frame(width: 200, height: 200)
                            Text("\(data.attitude.yaw)")
                                .frame(width: 200, height: 200)
                        }
                case "Heading" :
                        HStack{
                            Text("Heading:")
                                .frame(width: 200, height: 200)
                            Text("\(data.heading)")
                                .frame(width: 200, height: 200)
                        }
                case "Magnetic Field" :
                        HStack{
                            Text("Magnetic Field X")
                                .frame(width: 200, height: 200)
                            Text("\(data.magneticField.field.x)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Magnetic Field Y")
                                .frame(width: 200, height: 200)
                            Text("\(data.magneticField.field.y)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Magnetic Field Z")
                                .frame(width: 200, height: 200)
                            Text("\(data.magneticField.field.z)")
                                .frame(width: 200, height: 200)
                        }
                case "User Acceleration" :
                        HStack{
                            Text("User Acceleration X")
                                .frame(width: 200, height: 200)
                            Text("\(data.userAcceleration.x)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("User Acceleration Y")
                                .frame(width: 200, height: 200)
                            Text("\(data.userAcceleration.y)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("User Acceleration Z")
                                .frame(width: 200, height: 200)
                            Text("\(data.userAcceleration.z)")
                                .frame(width: 200, height: 200)
                        }
                case "Rotation Rate":
                        HStack{
                            Text("Rotation Rate X")
                                .frame(width: 200, height: 200)
                            Text("\(data.rotationRate.x)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Rotation Rate Y")
                                .frame(width: 200, height: 200)
                            Text("\(data.rotationRate.y)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Rotation Rate Z")
                                .frame(width: 200, height: 200)
                            Text("\(data.rotationRate.z)")
                                .frame(width: 200, height: 200)
                        }
                case "Gravity":
                        HStack{
                            Text("Gravity X")
                                .frame(width: 200, height: 200)
                            Text("\(data.gravity.x)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Gravity Y")
                                .frame(width: 200, height: 200)
                            Text("\(data.gravity.y)")
                                .frame(width: 200, height: 200)
                        }
                        HStack{
                            Text("Gravity Z")
                                .frame(width: 200, height: 200)
                            Text("\(data.gravity.z)")
                                .frame(width: 200, height: 200)
                        }
                case "Sensor Location" :
                        HStack{
                            Text("Sensor Location")
                                .frame(width: 200, height: 200)
                            Text("\(data.sensorLocation.rawValue)")
                                .frame(width: 200, height: 200)
                        }
                default: Text("device motion data")
                }
            } else {
                Text("No Device Motion data available")
            }
        }
    }
}

struct DeviceMotionTypeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceMotionTypeDetailView(motionType: "Attitude", motionManager: MotionManager())
    }
}
