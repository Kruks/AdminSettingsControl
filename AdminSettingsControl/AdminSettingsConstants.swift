//
//  AdminSettingsConstants.swift
//  AdminSettingsPodCode
//
//  Created by Krutika on 10/16/17.
//  Copyright © 2017 kahuna. All rights reserved.
//

import UIKit

public struct AdminSettingsConstants  {
    
    static let adminBundleID = "org.cocoapods.AdminSettingsControl"
    
    enum UniqueKeyConstants {
        static let enableDeviceLogs = "EnableDeviceLogs"
        static let enableProfileLogs = "EnableProfileLogs"
        static let titleKey = "title"
        static let userDefaultsKey = "key"
    }
    
    enum adminStringConstants {
        static let notApplicable = "N/A"
        static let serverURLSectionTitle = "Server URL"
        static let otherDetailsSectionTitle = "Other Details"
        static let templateURLAppendString = "%@%@?deviceType=IOS&serviceRequestTypeId=&language=en"
    }

    enum ColorConstants {
        static let lightGrayBorderColor = UIColor(red: 248.0 / 255.0, green: 248.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)

    }
    
    public enum SettingTableViewOtherDetialsCellIdentifier {
        static let logCampId = "Logcamp App ID"
        static let deviceId = "Device ID"
        static let appVersion = "App Version"
        static let pushNotification = "Push notification token"
        static let profileLog = "Enable profile log"
        static let deviceLog = "Enable device log"
        static let emailData = "Email Data"
        static let viewMySrDetailLink = "View My SR Detail URL"
        static let createSrTemplateLink = "Create SR Template URL"
        static let viewMySrDetailVer = "View My SR Detail Version"
        static let createSrTemplateVer = "Create SR Template Version"
        static let serverURLTitle = "Server URL"
        static let loginServerURLTitle = "Login Server URL"
        static let templateURLTitle = "Template URL"
        
    }
}
