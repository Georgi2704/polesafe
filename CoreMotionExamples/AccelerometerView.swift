//
//  AccelerometerView.swift
//  CoreMotionExamples
//
//  Created by Ruud Huijts on 18/10/2022.
//

import SwiftUI
import Charts
import CoreMotion
import CoreData

struct AccelerometerView: View {

    
    @ObservedObject var motionManager: MotionManager
    @Environment(\.managedObjectContext) var managedObjectContext
    
    
    @State var xlist = []
    @State private var driving = false

    
    var body: some View {
        VStack{
            if let data = motionManager.accelerometerData {
                VStack{
                    HStack{
                        Text("Acceleration X:")
                        if let x = data.x.last?.value {
                            Text("\(x)")
                        }
                    }
                    HStack{
                        Text("Acceleration Y:")
                        if let x = data.y.last?.value {
                            Text("\(x)")
                        }
                    }
                    HStack{
                        Text("Acceleration Z:")
                        if let x = data.z.last?.value {
                            Text("\(x)")
                        }
                    }
                }

            }
            else {
                Text("No accelerometer data available")
            }
            VStack{
                (driving) ? Button("Stop Drive"){
                    motionManager.stopAccelerometers()
                    driving.toggle()
                }.padding() : Button("Start Drive"){
                    motionManager.startAccelerometers()
                    driving.toggle()
                }.padding()
                
                Button("Save Data"){
                    DataController().batchAddAccelerometer(data: motionManager.getAccelerometerData(), context: managedObjectContext)
                }
                    
                    
                Button("Delete Data"){
                    DataController().deleteAll(context: managedObjectContext)
                    
                }
            }
        }
//        .onAppear(perform: motionManager.startAccelerometers)
    }
}

//struct AccelerometerView_Previews: PreviewProvider {
//    static var previews: some View {
//        AccelerometerView(motionManager: MotionManager())
//    }
//}
