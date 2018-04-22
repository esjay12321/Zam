//
//  ViewController.swift
//  prototype1
//
//  Created by Minkyung Kim on 21/04/2018.
//  Copyright © 2018 Minkyung Kim. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class ViewController: UIViewController, CLLocationManagerDelegate{

    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // for use when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.allowsBackgroundLocationUpdates = true
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            let context = appDelegate.persistentContainer.viewContext
//            let entity = NSEntityDescription.entity(forEntityName: "Data", in: context)
            print("speed, mps", location.speed)
//            print("latitude", location.coordinate.latitude)
//            print("longitude", location.coordinate.longitude)
            print("time, s", location.timestamp)
        }
    }

            
//            let newData = NSManagedObject(entity: entity!, insertInto: context)

//            newData.setValue(location.speed, forKey: "speed")
//            newData.setValue(location.coordinate.latitude, forKey: "latitude")
//            newData.setValue(location.coordinate.longitude, forKey: "longitude")
//            newData.setValue(location.timestamp, forKey: "time")
            
//            let DataSpeed = newData.value(forKey: "speed") as! Float
//            let DataSpeed = newData.value(forKey: "latitude") as! Float
//            let DataSpeed = newData.value(forKey: "longitude") as! Float
//            let DataSpeed = newData.value(forKey: "time") as! Date
            
//            if context.hasChanges {
//                do {
//                    try context.save()
//                    print(context)
//
//                    print("Successfully saved")
//                } catch {
//                    print("Failed saving")
//                    // Replace this implementation with code to handle the error appropriately.
//                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    let nserror = error as NSError
//                    fatalError("Unresolved error \(nserror)")
//                }
//            }
            
//            print("speed, m/s: ", location.speed)
////            print("latitude: ", newData.value(forKey: "latitude") as! Float)
////            print("longitude: ", newData.value(forKey: "longitude") as! Float)
//            print("time: ", location.timestamp)
//
            
//            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Data")
//            request.returnsObjectsAsFaults = false
//            do {
//                let result = try context.fetch(request)
//                fetchdata(result)
//            } catch {
//                print("Failed")
//            }

//        }
//    }
    
//    func fetchdata(result: result) {
//
//        for data in result as! [NSManagedObject] {
//            let DataSpeed = data.value(forKey: "speed") as! Float
//            let DataLatitude = data.value(forKey: "latitude") as! Float
//            let DataLongitude = data.value(forKey: "longitude") as! Float
//            let DataTime = data.value(forKey: "time") as! Date
//
//            print(data.value(forKey: "time") as! Date)
//            print(DataLatitude)
//            print(DataLongitude)
//            print(DataTime)
//        }
//    }
    
//    func exportDatabase() {
//        let exportString = createExportString()
//        saveAndExport(exportString: exportString)
//    }
//
//    func saveAndExport(exportString: String) {
//        let exportFilePath = NSTemporaryDirectory() + "itemlist.csv"
//        let exportFileURL = NSURL(fileURLWithPath: exportFilePath)
//        FileManager.default.createFile(atPath: exportFilePath, contents: NSData() as Data, attributes: nil)
//        //var fileHandleError: NSError? = nil
//        var fileHandle: FileHandle? = nil
//        do {
//            fileHandle = try FileHandle(forWritingTo: exportFileURL as URL)
//        } catch {
//            print("Error with fileHandle")
//        }
//
//        if fileHandle != nil {
//            fileHandle!.seekToEndOfFile()
//            let csvData = exportString.data(using: String.Encoding.utf8, allowLossyConversion: false)
//            fileHandle!.write(csvData!)
//
//            fileHandle!.closeFile()
//
//            let firstActivityItem = NSURL(fileURLWithPath: exportFilePath)
//            let activityViewController : UIActivityViewController = UIActivityViewController(
//                activityItems: [firstActivityItem], applicationActivities: nil)
//
//            activityViewController.excludedActivityTypes = [
//                UIActivityType.assignToContact,
//                UIActivityType.saveToCameraRoll,
//                UIActivityType.postToFlickr,
//                UIActivityType.postToVimeo,
//                UIActivityType.postToTencentWeibo
//            ]
//
//            self.present(activityViewController, animated: true, completion: nil)
//        }
//    }
//
//    func createExportString() -> String {
//        var itemIDvar: NSNumber?
//        var productNamevar: String?
//        var amountvar: NSNumber?
//        var stockvar: Bool?
//
//        var export: String = NSLocalizedString("itemID, productName, Amount \n", comment: "")
//        for (index, itemList) in fetchedStatsArray.enumerated() {
//            if index <= fetchedStatsArray.count - 1 {
//                itemIDvar = itemList.value(forKey: "itemID") as! NSNumber?
//                productNamevar = itemList.value(forKey: "productname") as! String?
//                amountvar = itemList.value(forKey: "amount") as! NSNumber?
//                stockvar = itemList.value(forKey: "stock") as! Bool?
//                let inventoryDatevar = itemList.value(forKey: "inventoryDate") as! Date
//                let itemIDString = itemIDvar
//                let procductNameSting = productNamevar
//                let amountSting = amountvar
//                let stockSting = stockvar
//                let inventoryDateSting = "\(inventoryDatevar)"
//                export += "\(itemIDString!),\(procductNameSting!),\(stockSting!),\(amountSting!),\(inventoryDateSting) \n"
//            }
//        }
//        print("This is what the app will export: \(export)")
//        return export
//    }
//
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied){
            showLocationDisabledPopUp()
        }
    }
    
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Disabled", message: "In order to analyze your data, we need your location.", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        //still don't want to give access
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

