//
//  AppDelegate.swift
//  BackgroundLocation
//
//  Created by Rajan Maheshwari on 27/12/19.
//  Copyright © 2019 Rajan Maheshwari. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var locationManager:CLLocationManager? = CLLocationManager()
    var myLocation:CLLocation?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerNotifications()
        //UIApplication.shared.setMinimumBackgroundFetchInterval(60)
        if launchOptions?[UIApplication.LaunchOptionsKey.location] != nil {
            Logger.write(text: "Terminated location found", to: kLogsFile)
            if locationManager == nil {
                Logger.write(text: "Terminated location manager nil found", to: kLogsFile)
                locationManager = CLLocationManager()
                locationManager?.delegate = self
                locationManager?.distanceFilter = 10
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                locationManager?.allowsBackgroundLocationUpdates = true
                locationManager?.startUpdatingLocation()
            } else {
                Logger.write(text: "Terminated location manager found", to: kLogsFile)
                locationManager = nil
                locationManager = CLLocationManager()
                locationManager?.delegate = self
                locationManager?.distanceFilter = 10
                locationManager?.desiredAccuracy = kCLLocationAccuracyBest
                locationManager?.allowsBackgroundLocationUpdates = true
                locationManager?.startUpdatingLocation()
            }
        } else {
            locationManager?.delegate = self
            locationManager?.distanceFilter = 10
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.allowsBackgroundLocationUpdates = true
            
            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager?.requestAlwaysAuthorization()
            }
            else if CLLocationManager.authorizationStatus() == .denied {
                Logger.write(text: "User denied location services", to: kLogsFile)
            }
            else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
                locationManager?.requestAlwaysAuthorization()
            }
            else if CLLocationManager.authorizationStatus() == .authorizedAlways {
                locationManager?.startUpdatingLocation()
            }
        }
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("applicationDidEnterBackground")
//        Logger.write(text: "applicationDidEnterBackground", to: kLogsFile)
        self.createRegion(location: myLocation)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        Logger.write(text: "applicationWillTerminate", to: kLogsFile)
        self.locationManager?.startMonitoringSignificantLocationChanges()

    }
    
    func checkTerminatingStateTask() {
        let userDefault = UserDefaults.standard
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy hh mm"
        let currentDate = dateFormatter.string(from: Date())
        userDefault.setValue("Date:- \(currentDate) && Localition = \(myLocation?.coordinate.latitude.description ?? ""), \(myLocation?.coordinate.longitude.description ?? "")", forKey: "loc_name")
        userDefault.synchronize()
        APICalling.callAPIForGetList()
    }
    
   
    func createRegion(location:CLLocation?) {
        guard let location = location else {
//            Logger.write(text: "Problem with location in creating region", to: kLogsFile)
            return
        }
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            
            let coordinate = CLLocationCoordinate2DMake((location.coordinate.latitude), (location.coordinate.longitude))
            let regionRadius = 50.0
            
            let region = CLCircularRegion(center: CLLocationCoordinate2D(
                latitude: coordinate.latitude,
                longitude: coordinate.longitude),
                                          radius: regionRadius,
                                          identifier: "aabb")
            
            //region.notifyOnEntry = true
            region.notifyOnExit = true
            
            scheduleLocalNotification(alert: "Region Created \(location.coordinate) with \(location.horizontalAccuracy)")
//            Logger.write(text: "Region Created \(location.coordinate) with \(location.horizontalAccuracy)", to: kLogsFile)
//            self.locationManager?.stopUpdatingLocation()
//            Logger.write(text: "stopUpdatingLocation", to: kLogsFile)
//            self.locationManager?.startMonitoring(for: region)
//            Logger.write(text: "startMonitoring", to: kLogsFile)
        }
        else {
//            Logger.write(text: "System can't track regions", to: kLogsFile)
        }
    }
}


let kLogsFile = "LocationLogs"
let kLogsDirectory = "LocationData"
