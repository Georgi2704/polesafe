//
//  Speedometer.swift
//  CoreMotionExamples
//
//  Created by Georgi Manev on 7.01.23.
//

import SwiftUI

struct Speedometer: View {
    
    let colors = [Color("Color"),Color("Color1")]
//    @Binding var progress : CGFloat
    var progress: CGFloat
    
    var body: some View{
        
        ZStack{
            
            ZStack{
                
                Circle()
                    .trim(from: 0, to: 0.5)
                    .stroke(Color.black.opacity(0.1), lineWidth: 55)
                    .frame(width: 280, height: 280)
                
                
                Circle()
                    .trim(from: 0, to: self.setProgress())
                    .stroke(AngularGradient(gradient: .init(colors: self.colors), center: .center, angle: .init(degrees: 180)), lineWidth: 55)
                    .frame(width: 280, height: 280)
                
            }
            .rotationEffect(.init(degrees: 180))
            
            ZStack(alignment: .bottom) {
                
                self.colors[0]
                .frame(width: 2, height: 95)
                
                Circle()
                    .fill(self.colors[0])
                    .frame(width: 15, height: 15)
            }
            .offset(y: -35)
            .rotationEffect(.init(degrees: -90))
            .rotationEffect(.init(degrees: self.setArrow()))
            
            
        }
        .padding(.bottom, -140)
    }
    
    func setProgress()->CGFloat{
        
        let temp = self.progress / 2
        return temp * 0.01
    }
    
    func setArrow()->Double{
        
        let temp = self.progress / 100
        return Double(temp * 180)
    }
}

//struct Speedometer_Previews: PreviewProvider {
//    static var previews: some View {
//        Speedometer(progress: CGFloat(50.0))
//    }
//}
