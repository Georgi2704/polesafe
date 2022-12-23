//
//  Helpers.swift
//  CoreMotionExamples
//
//  Created by Georgi Manev on 9.01.23.
//

import Foundation
import CoreData
import SwiftUI

public func getDriveScoreGrade (score: Int) -> String {
    var driveGrade = ""
    switch (score){
        case (0...299): driveGrade = "Reckless"
        case (300...399): driveGrade = "Very Aggressive"
        case (400...499): driveGrade = "Aggressive"
        case (500...599): driveGrade = "Snappy"
        case (600...799): driveGrade = "Good"
        case (800...899): driveGrade = "Very Good"
        case (900...1000): driveGrade = "Excellent"
        default: driveGrade = "Not available"
    }
    
    return driveGrade
}


public func getColor (grade: String) -> Color {
    switch (grade){
        case "Reckless": return Color.red
        case "Very Aggressive": return Color.orange
        case "Aggressive": return Color.orange
        case "Snappy": return Color.yellow
        case "Good": return Color.teal
        case "Very Good": return Color.mint
        case "Excellent": return Color.green
        default: return Color.black
    }
}

public func stringToDate(dateString: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    return dateFormatter.date(from: dateString)!
}

public func calcTime(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes < 120 {
        return "\(minutes) minutes ago"
    }
    else if minutes > 120 && hours < 48 {
        return "\(hours) hours ago"
    }
    else {
        return "\(days) days ago"
    }
}

struct DriveScoreObject: Identifiable {
    var id: Int
    var date: String
    var duration: String
    var grade: String
    var score: String
}

func returnScoreObjects(driveScores: FetchedResults<DriveScoreEntity>) -> [DriveScoreObject]{
    var driveScoresObjects: [DriveScoreObject] = []
    
    
    for i in stride(from: 0, to: driveScoresObjects.count, by: 1){
        driveScoresObjects.append(DriveScoreObject(
            id: i,
            date: calcTime(date: stringToDate(dateString: driveScores[i].value(forKey: "date") as! String)),
            duration: "",
            grade: driveScores[i].value(forKey: "grade") as! String,
            score: String(driveScores[i].value(forKey: "score") as! Int)
        ))
    }
    return driveScoresObjects
}

func returnOneScoreObject(driveScore: DriveScoreEntity) -> DriveScoreObject{
    var driveScoreObject = DriveScoreObject(id: 0, date: "", duration: "", grade: "", score: "")
    
    driveScoreObject.id = driveScore.value(forKey: "id") as! Int
    driveScoreObject.grade = driveScore.value(forKey: "grade") as! String
    driveScoreObject.score = String(driveScore.value(forKey: "score") as! Int)
    
    return driveScoreObject
}
