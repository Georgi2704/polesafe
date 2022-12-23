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
//            case "Gyroscope" :
//                VStack{
//                    if let data = motionManager.gyroData {
//                        HStack{
//                            Text("Rotation Rate X:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.rotationRate.x)")
//                                .frame(width: 200, height: 200)
//                        }
//                        HStack{
//                            Text("Rotation Rate Y:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.rotationRate.y)")
//                                .frame(width: 200, height: 200)
//                        }
//                        HStack{
//                            Text("Rotation Rate Z:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.rotationRate.z)")
//                                .frame(width: 200, height: 200)
//                        }
//
//                    } else {
//                        Text("No gyro data available")
//                    }
//                }.onAppear(perform: motionManager.startGyroscope)
                
//            case "Pedometer" :
//                VStack{
//                    if let data = motionManager.pedometerData {
//                        HStack{
//                            Text("Number of steps:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.numberOfSteps)")
//                                .frame(width: 200, height: 200)
//                        }
//                        HStack{
//                            Text("Current Cadence:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.currentCadence!)")
//                                .frame(width: 200, height: 200)
//                        }
//                        HStack{
//                            Text("Distance:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.distance!)")
//                                .frame(width: 200, height: 200)
//                        }
//                    }else {
//                        Text("No pedometer data available")
//                    }
//                }.onAppear(perform: motionManager.startPedometer)
//            case "Magnetometer" :
//                VStack{
//                    if let data = motionManager.magnetometerData {
//                        HStack{
//                            Text("Magnetic Field X:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.magneticField.x)")
//                                .frame(width: 200, height: 200)
//                        }
//                        HStack{
//                            Text("Magnetic Field Y:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.magneticField.y)")
//                                .frame(width: 200, height: 200)
//                        }
//                        HStack{
//                            Text("Magnetic Field Z:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.magneticField.z)")
//                                .frame(width: 200, height: 200)
//                        }
//                    }else {
//                        Text("No magnetometer data available")
//                    }
//                }.onAppear(perform: motionManager.startMagnetometer)
//            case "Altitude" :
//                VStack{
//                    if let data = motionManager.altitudeData {
//                        HStack{
//                            Text("Relative Altitude:")
//                                .frame(width: 200, height: 200)
//                            Text("\(data.relativeAltitude)")
//                                .frame(width: 200, height: 200)
//                        }
//                    }else {
//                        Text("No altimeter data available")
//                    }
//                }.onAppear(perform: motionManager.startAltimeter)
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
