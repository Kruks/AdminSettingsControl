# AdminSettingsControl

![LogCamp](http://www.kahuna-mobihub.com/templates/ja_puresite/images/logo-trans.png)

AdminSettingsControl is written in Swift

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. 

```ruby
 pod 'AdminSettingsControl', :git => 'https://github.com/Kruks/AdminSettingsControl.git', :tag => '1.0.3'
```


### Swift Code to navigate to admin Settings screen:
Firstly create an array with 2 sections, one for configurable URLs used in app & second to display other details like logcampID & other details.

```swift
 // For Admin Settings View pass 2 sections in array, 1st for all the server URLs & 2nd section for other details like Push Notification Token
  // 1st Section contains all server url title & the key is the userdefault key for which the URL is stored
        var rowInSectionFirstArray = [[String: String]]()
        rowInSectionFirstArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.serverURLTitle, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: Constants.UniqueKeyConstants.ServerBaseURL])
        rowInSectionFirstArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.loginServerURLTitle, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: Constants.UniqueKeyConstants.UserServerBaseURL])
        rowInSectionFirstArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.templateURLTitle, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "templateURL"])

// Other Details Section
        var rowInSectionSecondArray = [[String: String]]()
        // Logcamp ID Row. Pass logcamp id value in key tag
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.logCampId, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: Constants.AppConstants.k_LogCampServerAppId])
        // Device Id row
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.deviceId, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "deviceId"])
        // App version row
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.appVersion, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "appVersion"])
        // Push Notification Row. Here pas, user default key of push Notification
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.pushNotification, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "pushNotification"])
        // Profile log Switch Row
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.profileLog, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "profileLog"])
        //Device Log Switch ROw
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.deviceLog, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "deviceLog"])
        //viewMySrDetailLink Row. Here pass user default key for viewMySrDetailLink
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.viewMySrDetailLink, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "viewMySrDetailLink"])
        //viewMySrDetailVersion Row. Here pass user default key for viewMySrDetailVer
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.viewMySrDetailVer, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "viewMySrDetailVer"])
        //createSrTemplateLink Row. Here pass user default key for createSrTemplateLink
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.createSrTemplateLink, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "createSrTemplateLink"])
        //createSrTemplateVer Row. Here pass user default key for createSrTemplateVer
        rowInSectionSecondArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.createSrTemplateVer, AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: "createSrTemplateVer"])

```
 Finally for navigation to admin settings screen write below code:-
```swift
// parameter required are adminArray(the array with two section that we created in above code) & navigation controller instance
_ = AdminSettingsControl.init(adminArray: [rowInSectionFirstArray, rowInSectionSecondArray], navigationController: self.navigationController!)

```
Note:- store template URL object with key "templateURL", also viewMySrDetailLink & createSrTemplateLink must be stored in userdefaults like other URLs
