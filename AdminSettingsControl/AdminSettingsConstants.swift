//
//  AdminSettingsConstants.swift
//  AdminSettingsPodCode
//
//  Created by Krutika on 10/16/17.
//  Copyright © 2017 kahuna. All rights reserved.
//

import UIKit

public struct AdminSettingsConstants {

    public static let adminBundleID = "org.cocoapods.AdminSettingsControl"
    public enum UniqueKeyConstants {
        static let enableDeviceLogs = "EnableDeviceLogs"
        static let enableProfileLogs = "EnableProfileLogs"
        public static let titleKey = "title"
        public static let userDefaultsKey = "key"
        public static let templateURL = "templateURL"
        public static let adminSettingsXibName = "AdminSettingsViewController"
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
        public static let logCampId = "Logcamp App ID"
        public static let deviceId = "Device ID"
        public static let appVersion = "App Version"
        public static let pushNotification = "Push Notification Token"
        public static let profileLog = "Enable Profile Logs"
        public static let deviceLog = "Enable Device Logs"
        public static let emailData = "Email Data"
        public static let viewMySrDetailLink = "View My SR Details URL"
        public static let createSrTemplateLink = "Create SR Template URL"
        public static let viewMySrDetailVer = "View My SR Details Version"
        public static let createSrTemplateVer = "Create SR Template Version"
        public static let serverURLTitle = "Server URL"
        public static let loginServerURLTitle = "Login Server URL"
        public static let templateURLTitle = "Template URL"
        public static let navigationTitle = "Settings"
        public static let uploadtoDriveTitle = "Upload DB To Drive"
    }

    enum StaticAppMessages {
        // Upload To Google Drive Text
        static let creatingDBText = "Creating DBBackup folder in your drive"
        static let uploadingDBText = "Uploading DBBackup in your drive"
        static let sharingFileToUsers = "Sharing DBBackup to developers"
        static let uploadingText = "Uploading Image"
        static let alertOkTitle = "OK"

    }

}
