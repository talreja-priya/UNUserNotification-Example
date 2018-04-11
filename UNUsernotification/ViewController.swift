//
//  ViewController.swift
//  UNUsernotification
//
//  Created by Priya Talreja on 10/04/18.
//  Copyright © 2018 Priya Talreja. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class ViewController: UIViewController,UNUserNotificationCenterDelegate {

    @IBOutlet weak var customBtn: UIButton!
    @IBOutlet weak var generalNotificationBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.generalNotificationBtn.layer.cornerRadius = 8;
        self.generalNotificationBtn.layer.masksToBounds = true;
        self.generalNotificationBtn.titleLabel?.textAlignment = .center;
        
        self.customBtn.layer.cornerRadius = 8;
        self.customBtn.layer.masksToBounds = true;
        self.customBtn.titleLabel?.textAlignment = .center;
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            // Enable or disable features based on authorization.
        }
        
        
        //General Notification Category
        let generalCategory = UNNotificationCategory(identifier: "GENERAL",
                                                     actions: [],
                                                     intentIdentifiers: [],
                                                     options: .customDismissAction)
        
      
        
        //Custom
        let yesAction = UNNotificationAction(identifier: "YES_ACTION",
                                                title: "Yes",
                                                options: UNNotificationActionOptions(rawValue: 0))
        let noAction = UNNotificationAction(identifier: "NO_ACTION",
                                              title: "No",
                                              options: .foreground)
        
        let feedbackCategory = UNNotificationCategory(identifier: "FEEDBACK",
                                                     actions: [yesAction, noAction],
                                                     intentIdentifiers: [],
                                                     options: UNNotificationCategoryOptions(rawValue: 0))
        
        center.setNotificationCategories([generalCategory,feedbackCategory])
        
    }

    
    @IBAction func sendLocalNotification(_ sender: UIButton) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "UNUserNotification Sample"
        notificationContent.body = "Sample test msg"
        notificationContent.badge = 0
        notificationContent.sound = UNNotificationSound.default()
        notificationContent.categoryIdentifier = "GENERAL"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "general", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        
    }
    
    
    
    @IBAction func customNotificationClicked(_ sender: UIButton) {
       
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "UNUserNotification Sample"
        notificationContent.body = "Do you like this notification?"
        notificationContent.badge = 0
        notificationContent.sound = UNNotificationSound.default()
        notificationContent.categoryIdentifier = "FEEDBACK"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
        let notificationRequest = UNNotificationRequest(identifier: "feedback", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
        
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
        if response.notification.request.content.categoryIdentifier == "FEEDBACK"
        {
            if response.actionIdentifier == "YES_ACTION" {
                let notificationContent = UNMutableNotificationContent()
                notificationContent.title = "UNUserNotification Sample"
                notificationContent.body = "Thank you for your appreciation!"
                notificationContent.badge = 0
                notificationContent.sound = UNNotificationSound.default()
                notificationContent.categoryIdentifier = "GENERAL"
                
                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.2, repeats: false)
                let notificationRequest = UNNotificationRequest(identifier: "general", content: notificationContent, trigger: notificationTrigger)
                
                // Add Request to User Notification Center
                UNUserNotificationCenter.current().add(notificationRequest) { (error) in
                    if let error = error {
                        print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
                    }
                }
            }
            else if response.actionIdentifier == "NO_ACTION" {
                print("NO")
            }
        }
    }
    
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }


}

