//
//  SheetsState.swift
//  CoreMotionExamples
//
//  Created by Georgi Manev on 9.01.23.
//

import Foundation
class SheetsState: ObservableObject {
    @Published var showDrivingView: Bool = false
    @Published var showCompleteView: Bool = false
    
//    init (showDrivingView: Bool, showCompleteView: Bool) {
//        self.showDrivingView = false
//        self.showCompleteView = false
//    }
}
