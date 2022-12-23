//
//  DataContoller.swift
//  iCalories
//
//  Created by Georgi Manev on 20.12.22.
//
// Loads, Creates, Updates Data
import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SensorDataThree")
    
    init() {
        print(container.persistentStoreDescriptions.first?.url! as Any)
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
//        print(container.persistentStoreDescriptions.first?.url! as Any)
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data Saved !")
        } catch {
            print("We could not save the data...")
        }
    }
    
    
    func deleteAll(context: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AccelerometerEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print("There has been error in deleteAllAccelerometer", error)
        }
        
        let fetchRequestDs: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "DriveScoreEntity")
        let deleteRequestDs = NSBatchDeleteRequest(fetchRequest: fetchRequestDs)
        do {
            try context.execute(deleteRequestDs)
        } catch let error as NSError {
            print("There has been error in deleteAllDriveScore", error)
        }
    }
    
    func addAccelerometer(x: Double, y: Double, z: Double, context: NSManagedObjectContext){
        let accelerometer = AccelerometerEntity(context: context)
        accelerometer.id = 1
        accelerometer.date = "2023-01-06 15:03:25.044Z"
        accelerometer.x = x
        accelerometer.y = y
        accelerometer.z = z
                
        save(context: context)
    }
    
    
    func fetchLatestRecord(context: NSManagedObjectContext) -> Int {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "AccelerometerEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 1
        var id = 0

        do {
            let results = try context.fetch(fetchRequest)
            if let latest = results.first {
                print("LATEST", latest)
                id = latest.value(forKey: "id") as! Int
                print("Aidi ID", id)
            }
        } catch let error as NSError {
            print("Error fetching latest record: \(error)")
        }
        return id + 1
    }
    
    func fetchLatestDrive(context: NSManagedObjectContext) -> DriveScoreObject {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DriveScoreEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        fetchRequest.fetchLimit = 1
        var driveScoreObject = DriveScoreObject(id: 0, date: "", duration: "", grade: "", score: "")
        
        do {
            let results = try context.fetch(fetchRequest)
            if let latest = results.first {
                print("LATEST", latest)
                driveScoreObject.id = latest.value(forKey: "id") as! Int
                driveScoreObject.grade = latest.value(forKey: "grade") as! String
                driveScoreObject.score = String(latest.value(forKey: "score") as! Int)
            }
        } catch let error as NSError {
            print("Error fetching latest record: \(error)")
        }
        return driveScoreObject
    }
    
    
    func addDriveScore(context: NSManagedObjectContext, list_x: [Double], list_y: [Double], new_id: Int) -> DriveScoreEntity{
        var totalX = 0.0
        var totalY = 0.0
        
        for x in list_x {
            totalX += abs(x)
        }
        
        print("Total X", totalX)
        for y in list_y {
            totalY += abs(y)
        }
        print("Total Y", totalY)

        
        let averageX = totalX/Double(list_x.count)
        print("AverageX", averageX)
        let averageY = totalY/Double(list_y.count)
        print("AverageY", averageY)
        
        
        var driverScoreX = -40000*pow(averageX, 2) + 1000
        print("DriverScoreX", driverScoreX)
        var driverScoreY = -20000*pow(averageY, 2) + 1000
        print("DriverScoreY", driverScoreY)
        
        if (driverScoreX < 1){
            driverScoreX = 0.01
        }
        if (driverScoreY < 1){
            driverScoreY = 0.01
        }
        
        let finalDriveScore = Int((driverScoreX+driverScoreY)/2)

        
        let driveGrade = getDriveScoreGrade(score: finalDriveScore)
        print("DriveGrade", driveGrade)
        
        //this can be moved to helper function I know
        let d = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = df.string(from: d)
        
        let driveScoreEntity = DriveScoreEntity(context: context)
        driveScoreEntity.date = date
        driveScoreEntity.grade = driveGrade
        driveScoreEntity.score = Int32(finalDriveScore)
        driveScoreEntity.duration = "1min 01sec"
        driveScoreEntity.id = Int32(new_id)

        
        print("FinalDriveScore", finalDriveScore)
        save(context: context)
        
        return driveScoreEntity
    }
    

    //For testing purposes for now
    func testWithDatabase(context: NSManagedObjectContext, keyString: String) -> [Double]{
        let id = 3
        var values:[Double] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AccelerometerEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            let records = try context.fetch(fetchRequest) as! [NSManagedObject]
            for record in records {
                let value = record.value(forKey: keyString) as! Double
                print("VALUE", keyString, value)
                values.append(value)
            }
        } catch {
            print("Error fetching records: \(error)")
        }
        
        return values
    }
    
    
    func batchAddAccelerometer(data: [AccelerometerDataMod], context: NSManagedObjectContext) -> DriveScoreObject{
        var list_x: [Double] = []
        var list_y: [Double] = []
        
        let new_id = fetchLatestRecord(context: context)
        
        for i in stride(from: 1, to: data.count, by: 1){

            let accelerometer = AccelerometerEntity(context: context)
            accelerometer.id = Int32(new_id)
            accelerometer.date = data[i].date
            accelerometer.x = data[i].x
            accelerometer.y = data[i].y
            accelerometer.z = data[i].z
            
            list_x.append(data[i].x)
            list_y.append(data[i].y)
            
            print("Count", i)
            print(accelerometer.date!)
            print("AccX", accelerometer.x)
        }
        
        
        let dScore = addDriveScore(context: context, list_x: list_x, list_y: list_y, new_id: new_id)
        return returnOneScoreObject(driveScore: dScore)
    }

    
//    func editAccelerometer (accelerometer: AccelerometerEntity, name: String, calories: Double, context: NSManagedObjectContext){
//        accelerometer.date = Date()
////        accelerometer.name = name
////        accelerometer.calories = calories
//        
//        save(context: context)
//    }
}

