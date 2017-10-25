//
//  AdminSettingsVC+Drive.swift
//  FIMS
//
//  Created by Piyush Rathi on 18/08/17.
//  Copyright © 2017 Kahuna Systems. All rights reserved.
//

import Foundation
import GoogleSignIn
import GoogleAPIClientForREST
import YLProgressBar
import MBProgressHUD

extension AdminSettingsViewController {
    
    func setGoogleDriveScope() {
        let signIn = GIDSignIn.sharedInstance()
        signIn?.delegate = self
        signIn?.uiDelegate = self
        signIn?.clientID = "865909050089-ebqvldbo8qiu5uejp2gsc22bmhunt4ja.apps.googleusercontent.com"
        var scopes = [String]()
        scopes.append(kGTLRAuthScopeDrive)
        signIn?.scopes = scopes
        signIn?.signIn()
    }
    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            self.showSimpleAlertWith(title: "Authentication Error", messageToShow: error?.localizedDescription ?? "")
            service.authorizer = nil
        } else {
            self.customIndicator(0.0, stringText: AdminSettingsConstants.StaticAppMessages.creatingDBText)
            self.dbUploadFileCounter = 0
            service.authorizer = user.authentication.fetcherAuthorizer()
            let sharedInstance = GoogleDriveUploadFile.shareInstance
            let appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            var folderName = "\(appName)_DBBackUp_".appending(self.convertFromDate(date: Date()))
            folderName = folderName.replacingOccurrences(of: " ", with: "_")
            sharedInstance.createFolder(service, folderName: folderName, callback: responseFolderFromDrive)
        }
    }
    
    func responseFolderFromDrive(success: Bool, result: AnyObject?) {
        distroyHUD()
        if success, let _ = result as? GTLRDrive_File {
            self.dbUploadFileCounter = 0
            let floatValue = Double(self.dbUploadFileCounter) * 0.2 + 0.1
            self.customIndicator(Float(floatValue), stringText: AdminSettingsConstants.StaticAppMessages.uploadingDBText + "(\(self.dbUploadFileCounter + 1)/\(self.totalDBUploadFileCounter))")
            let sharedInstance = GoogleDriveUploadFile.shareInstance
            sharedInstance.saveFile(sharedInstance.driveFile.identifier!, service: service, fileName: self.getDBName(index: self.dbUploadFileCounter), callback: uploadNextFileToDrive)
        }
    }
        
    func getDBName(index: Int) -> String {
        if index == 0 {
            return  dbName
        } else if index == 1 {
            return String(format: "%@-wal", dbName)
        } else if index == 2 {
            return String(format: "%@-shm", dbName)
        }
        return ""
    }
    
    func responseFileFromDrive(success: Bool, result: AnyObject?) {
        distroyHUD()
        if success && self.dbUploadFileCounter < self.totalDBUploadFileCounter {
            let floatValue = Double(self.dbUploadFileCounter) * 0.2 + 0.1
            self.customIndicator(Float(floatValue), stringText: AdminSettingsConstants.StaticAppMessages.uploadingDBText + "(\(self.dbUploadFileCounter + 1)/\(self.totalDBUploadFileCounter))")
            let sharedInstance = GoogleDriveUploadFile.shareInstance
            sharedInstance.saveFile(sharedInstance.driveFile.identifier!, service: service, fileName: self.getDBName(index: self.dbUploadFileCounter), callback: uploadNextFileToDrive)
        }
    }
    
    func uploadNextFileToDrive(success: Bool, result: AnyObject?) {
        distroyHUD()
        if success {
            if self.totalDBUploadFileCounter > self.dbUploadFileCounter + 1 {
                self.dbUploadFileCounter += 1
                self.responseFileFromDrive(success: success, result: result)
            } else {
                let sharedInstance = GoogleDriveUploadFile.shareInstance
                let floatValue = Double(self.dbUploadFileCounter + 1) * 0.2 + 0.1
                self.customIndicator(Float(floatValue), stringText: AdminSettingsConstants.StaticAppMessages.sharingFileToUsers)
                sharedInstance.shareFileToUsers(sharedInstance.driveFile.identifier!, service: service, emailAddress: emailRecipients, callback: responseSharingFileToUsers)
            }
        }
    }
    
    func responseSharingFileToUsers(success: Bool, result: AnyObject?) {
        if success {
            self.dbUploadFileCounter = 0
            self.customIndicator(1.0, stringText: AdminSettingsConstants.StaticAppMessages.sharingFileToUsers)
            distroyHUD()
            MBProgressHUD.hideAllHUDs(for: view, animated: true)
            self.showSimpleAlertWith(title: "DBBackup shared successfully", messageToShow: "")
        }
    }
    
    func customIndicator(_ value: Float, stringText: String) {
        if self.hud == nil {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            self.hud.mode = MBProgressHUDMode.customView
            let bundle = Bundle(identifier: AdminSettingsConstants.adminBundleID)
            let mcustomView = bundle?.loadNibNamed("ProgressBarIND", owner: self, options: nil)?[0] as! UIView
            self.ylProgress = mcustomView.viewWithTag(11) as! YLProgressBar
            let CancelButton = mcustomView.viewWithTag(44) as! UIButton
            CancelButton.addTarget(self, action: #selector(self.cancelProgressBarButtonClicked(_:)), for: .touchUpInside)
            let buttonLayer = CancelButton.layer
            buttonLayer.masksToBounds = true
            buttonLayer.borderWidth = 2.0
            buttonLayer.cornerRadius = CancelButton.frame.height / 2
            buttonLayer.borderColor = UIColor.white.cgColor
            self.ylProgress.indicatorTextDisplayMode = YLProgressBarIndicatorTextDisplayMode.progress
            self.ylProgress.stripesDirection = YLProgressBarStripesDirection.left
            self.customIndicatorLabel = mcustomView.viewWithTag(22) as! UILabel
            self.customIndicatorLabel.text = stringText
            if stringText.contains(AdminSettingsConstants.StaticAppMessages.uploadingText) {
                var frame = mcustomView.frame
                frame.size.width = 290
                mcustomView.frame = frame
            }
            self.hud.customView = mcustomView
        }
        if let indicator = self.ylProgress {
            DispatchQueue.main.async { () -> Void in
                indicator.progress = CGFloat(value)
                indicator.progressStretch = true
            }
        }
    }
    
    func distroyHUD() {
        if self.hud != nil {
            if self.ylProgress != nil {
                self.ylProgress = nil
            }
            if self.customIndicatorLabel != nil {
                self.customIndicatorLabel = nil
            }
            self.hud = nil
        }
    }
    
    @IBAction func cancelProgressBarButtonClicked(_ sender: UIButton) {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func convertFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy HH:mm:ss"
        let stringDate = dateFormatter.string(from: date)
        return stringDate
    }
}
