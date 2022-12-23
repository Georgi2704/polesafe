//
//  MotionManager.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 17/10/2022.
//

import Foundation
import CoreMotion


class MotionManager: ObservableObject {
    
    var timer: Timer?
    var motionManager = CMMotionManager()
    var activityManager = CMMotionActivityManager()
    
    @Published var deviceMotionData: CMDeviceMotion?
    @Published var accelerometerData: AccelerometerData?
    @Published var accelerometerDataFull: [AccelerometerDataMod] = [AccelerometerDataMod]()
    @Published var gyroData: CMGyroData?
    @Published var pedometerData: CMPedometerData?
    @Published var magnetometerData: CMMagnetometerData?
    @Published var altitudeData: CMAltitudeData?
    
    // Preprosessed data
    func startDeviceMotion(){
        if motionManager.isDeviceMotionAvailable {
            self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0
            self.motionManager.showsDeviceMovementDisplay = true
            self.motionManager.startDeviceMotionUpdates(using: .xMagneticNorthZVertical, to: OperationQueue.current!) { deviceMotion, error in
                if let data = deviceMotion {
                    self.deviceMotionData = data
                }
            }
        }
    }
    
    // Raw data
    func startAccelerometers() {
        print("Starting accelerometer...")
        self.accelerometerDataFull = [AccelerometerDataMod]()
        
        if self.motionManager.isAccelerometerAvailable {
            self.motionManager.accelerometerUpdateInterval = 1.0 / 10.0
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!) { data, error in
                if let data = data {
                    self.accelerometerData = AccelerometerData()
                    self.accelerometerData?.x.append(AccelerationItem(value: data.acceleration.x, timestamp: data.timestamp))
                    self.accelerometerData?.y.append(AccelerationItem(value: data.acceleration.y, timestamp: data.timestamp))
                    self.accelerometerData?.z.append(AccelerationItem(value: data.acceleration.z, timestamp: data.timestamp))
                    
                    let d = Date()
                    let df = DateFormatter()
//                    df.dateFormat = "2023-01-06T15:51:00.245Z"
                    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
                    let date = df.string(from: d)

                    
                    self.accelerometerDataFull.append(
                        AccelerometerDataMod(
                            date: date, x: data.acceleration.x, y: data.acceleration.y, z: data.acceleration.z)
                        )
                }
            }
        }
    }
    
    func stopAccelerometers(){
        if self.motionManager.isAccelerometerAvailable {
            motionManager.stopAccelerometerUpdates()
            
            for item in self.accelerometerDataFull{
                print(item)
            }
        }
    }
    
    func getAccelerometerData() -> [AccelerometerDataMod]{
        return self.accelerometerDataFull
    }
    
    func stopAllUpdates() {
        if self.motionManager.isDeviceMotionActive {
            self.motionManager.stopDeviceMotionUpdates()
        }
        if self.motionManager.isAccelerometerActive {
            self.motionManager.stopAccelerometerUpdates()
        }
        if self.motionManager.isGyroActive {
            self.motionManager.stopGyroUpdates()
        }
        if self.motionManager.isMagnetometerActive {
            self.motionManager.stopMagnetometerUpdates()
        }
        self.activityManager.stopActivityUpdates()
        
        self.deviceMotionData = nil
        self.accelerometerData = nil
        self.gyroData = nil
        self.pedometerData = nil
        self.magnetometerData = nil
        self.altitudeData = nil
    }
}

struct AccelerometerDataMod: Identifiable, Hashable {
    var id = UUID()
    var date: String
    var x: Double
    var y: Double
    var z: Double
}

class AccelerometerData {
    var x: [AccelerationItem] = []
    var y: [AccelerationItem] = []
    var z: [AccelerationItem] = []
}

struct AccelerationItem: Identifiable, Hashable {
    var id = UUID()
    var value: Double
    var timestamp: TimeInterval
}
