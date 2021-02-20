//
//  AppDelegate+Location.swift
//  BackgroundLocation
//
//  Created by Rajan Maheshwari on 27/12/19.
//  Copyright © 2019 Rajan Maheshwari. All rights reserved.
//

import UIKit
import CoreLocation

extension AppDelegate: CLLocationManagerDelegate {
    
    //MARK:- LocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        Logger.write(text: "didUpdateLocations \(location!.coordinate) and \(location!.horizontalAccuracy)", to: kLogsFile)
        
        if (location?.horizontalAccuracy)! <= Double(65.0) {
            myLocation = location
            if !(UIApplication.shared.applicationState == .active) {
                self.createRegion(location: location)
                self.checkTerminatingStateTask()
            }
        } else {
            manager.stopUpdatingLocation()
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        Logger.write(text: "didEnterRegion", to: kLogsFile)
        scheduleLocalNotification(alert: "didEnterRegion")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        Logger.write(text: "didExitRegion", to: kLogsFile)
        scheduleLocalNotification(alert: "didExitRegion")
        manager.stopMonitoring(for: region)
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        Logger.write(text: "\(error.localizedDescription)", to: kLogsFile)
        scheduleLocalNotification(alert: error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.write(text: "\(error.localizedDescription)", to: kLogsFile)
        scheduleLocalNotification(alert: error.localizedDescription)
    }
    
}
