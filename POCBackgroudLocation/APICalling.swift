//
//  APICalling.swift
//  POCBackgroudLocation
//
//  Created by Northout on 20/02/21.
//  Copyright © 2021 Northout. All rights reserved.
//

import Foundation
import BackgroundTasks

class APICalling {
    
    static func callAPIForGetList(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy hh:mm:ss"
        let currentDate = dateFormatter.string(from: Date())
        let userDefault = UserDefaults.standard
        userDefault.setValue("Date:- \(currentDate) && Api Called yaha tak aa rha..", forKey: "api_called")
        
        
        /*let url = URL(string: "https://reqres.in/api/userst")
        URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print("error")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                    OperationQueue.main.addOperation({
                        //handle some task...
                        
                        
                        userDefault.setValue("Date:- \(currentDate) && ApiResponse = \(json)", forKey: "api_response")
                        userDefault.synchronize()
                    })
                }catch let error as NSError{
                    print(error)
                }
            }
        }).resume()
        */
    }
    
    func handleBGTask(){
        /*let bgTaskIdentifier = "com.example.apple-samplecode.ColorFeed.refresh"
        BGTaskScheduler.shared.register(forTaskWithIdentifier: bgTaskIdentifier, using: nil) { task in
           let request = BGAppRefreshTaskRequest(identifier: bgTaskIdentifier)
           // Fetch no earlier than 15 minutes from now
           request.earliestBeginDate = Date(timeIntervalSinceNow: 15 * 60)
                
           do {
              try BGTaskScheduler.shared.submit(request)
           } catch {
              print("Could not schedule app refresh: \(error)")
           }
                                                                                                                
           // Create an operation that performs the main part of the background task
           let operation = RefreshAppContentsOperation()
           
           // Provide an expiration handler for the background task
           // that cancels the operation
           task.expirationHandler = {
              operation.cancel()
           }

           // Inform the system that the background task is complete
           // when the operation completes
           operation.completionBlock = {
              task.setTaskCompleted(success: !operation.isCancelled)
           }

           // Start the operation
           operationQueue.addOperation(operation)
        }*/
    }
    
    
}
