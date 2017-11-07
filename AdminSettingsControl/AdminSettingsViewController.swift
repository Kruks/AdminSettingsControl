//
//  AdminSettingsViewController.swift
//   MyCity311_iPad
//
//  Created by Piyush on 23/11/16.
//  Copyright © 2016 Kahuna Systems. All rights reserved.
//

import UIKit
import MessageUI
import SkyFloatingLabelTextField

class KALoggerDetails_TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
}

class ServerURL_TableViewCell: UITableViewCell {

    @IBOutlet weak var serverURLTextField: SkyFloatingLabelTextField!
}

enum SwitchControlTag {
    static let profileLog = 1
    static let deviceLog = 2
}

public class AdminSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var settingsTableView: UITableView!
    let headerHeight: CGFloat = 40
    var kaEnableProfileLogs: Bool = false
    var kaEnableDeviceLogs: Bool = true
    //Array which states Number of Sections and number of rows in each section
    public var section_row_Details_Array: NSMutableArray = NSMutableArray()
    //To store Updated URLs
    var serverURLsUpdatedDictArray = [[String: String]]()
    let userDefault = UserDefaults.standard
    let templateURLKey: String! = ""
    public var themeColor: UIColor!

    enum AdminTableSection {
        static let ServerURLSection = 0
        static let OtherDetailsSection = 1
    }

    enum AdminScreenRowHeight {
        static let textFieldCellHeight = 60.0
        static let defaultHeight = 91.0
        static let switchLogsCellHeight = 55.0
        static let templateDetailsURLHeight = 100.0
        static let uploadDriveCellHeight = 40.0
    }

    /**
     Here enableProfileLog, enableDeviceLog, serverUrl ,LoginServerUrl values are set
     */
    override public func viewDidLoad() {
        super.viewDidLoad()
        if(self.navigationController?.isNavigationBarHidden == true) {
            self.navigationController?.isNavigationBarHidden = false
            self.navigationController?.navigationBar.backgroundColor = self.themeColor
        }
        //Set kaEnableProfileLogs from userdefaults value
        if let profileLog = userDefault.value(forKey: AdminSettingsConstants.UniqueKeyConstants.enableDeviceLogs) as? Bool {
            kaEnableProfileLogs = profileLog
        }

        //Set kaEnableDeviceLogs from userdefaults value
        if let deviceLog = userDefault.value(forKey: AdminSettingsConstants.UniqueKeyConstants.enableProfileLogs) as? Bool {
            kaEnableDeviceLogs = deviceLog
        }
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /**
     Navigation bar title is set
     */
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.navigationTitle
        self.setBackButtonArrow()
        self.setDoneButton()
    }

    //MARK:- Set Save Button on navigation bar
    func setDoneButton() {
        let hmBtn = UIButton()
        hmBtn.frame = CGRect(x: 0, y: 0, width: AdminSettingsConstants.headerFontDetails.saveBtnWidth, height: AdminSettingsConstants.headerFontDetails.saveBtnHeight)
        hmBtn.addTarget(self, action: #selector(self.onSaveButtonClick(_:)), for: UIControlEvents.touchUpInside)
        hmBtn.setTitle("Save", for: UIControlState())
        let rightItem = UIBarButtonItem()
        rightItem.customView = hmBtn
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -5
        let btnArray = [negativeSpacer, rightItem]
        self.navigationItem.rightBarButtonItems = btnArray
    }

    //MARK:- Set Back arrow to left of navigation bar
    func setBackButtonArrow () {
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: 0, width: CGFloat(AdminSettingsConstants.headerFontDetails.backBtnArrowWidth), height: CGFloat(AdminSettingsConstants.headerFontDetails.backBtnArrowHeight))
        backBtn.setBackgroundImage(UIImage(named: "back_button.png") as UIImage?, for: UIControlState())
        backBtn.addTarget(self, action: #selector(self.onBackButtonClick(_:)), for: UIControlEvents.touchUpInside)
        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        let leftItem: UIBarButtonItem = UIBarButtonItem()
        leftItem.customView = backBtn
        self.navigationItem.leftBarButtonItem = leftItem
        negativeSpacer.width = CGFloat(AdminSettingsConstants.headerFontDetails.backBtnArrowNegativeSpacer)
        self.navigationItem .setLeftBarButtonItems([negativeSpacer, leftItem], animated: false)
    }

    //MARK:- Back button Click
    @IBAction func onBackButtonClick(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    //MARK:- TableView DataSource Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        if self.section_row_Details_Array.count > 0 {
            return self.section_row_Details_Array.count
        }
        return 0

    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.section_row_Details_Array[section] as AnyObject).count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let array = self.section_row_Details_Array[indexPath.section] as? NSArray
        let dict = array?[indexPath.row] as? NSDictionary
        let title: String = dict?[AdminSettingsConstants.UniqueKeyConstants.titleKey] as? String ?? ""
        let userDefaultsKey: String = dict?[AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey] as? String ?? ""
        let bundle = Bundle(identifier: AdminSettingsConstants.adminBundleID)
        if indexPath.section == AdminTableSection.ServerURLSection {
            let cellIdentifier = "ServerURL_TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? ServerURL_TableViewCell
            if cell == nil {
                cell = ServerURL_TableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                let nib = bundle?.loadNibNamed("ServerURL_TableViewCell", owner: self, options: nil)
                if (nib?.count)! > 0 {
                    cell = nib?[0] as? ServerURL_TableViewCell
                }
            }
            cell?.serverURLTextField.placeholder = title
            cell?.serverURLTextField.selectedTitle = title
            cell?.serverURLTextField.title = title
            cell?.serverURLTextField.delegate = self
            cell?.serverURLTextField.tag = indexPath.row
            cell?.serverURLTextField.text = AdminSettingsConstants.adminStringConstants.notApplicable
            if let urlValue = userDefault.value(forKey: userDefaultsKey) as? String {
                cell?.serverURLTextField.text = urlValue
            }
            cell?.selectionStyle = .none
            cell?.serverURLTextField.selectedTitleColor = self.themeColor
            cell?.serverURLTextField.selectedLineColor = self.themeColor
            return cell!

        } else {
            let cellIdentifier = "KALoggerDetails_TableViewCell"
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? KALoggerDetails_TableViewCell
            if cell == nil {
                cell = KALoggerDetails_TableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                let nib = bundle?.loadNibNamed("KALoggerDetails_TableViewCell", owner: self, options: nil)
                if (nib?.count)! > 0 {
                    cell = nib?[0] as? KALoggerDetails_TableViewCell
                }
            }
            cell?.titleLabel.backgroundColor = UIColor.clear
            cell?.subTitleLabel.backgroundColor = UIColor.clear
            cell?.selectionStyle = .none
            cell?.switchControl.isHidden = true
            cell?.titleLabel.text = title
            switch title {
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.logCampId:
                cell?.subTitleLabel.text = userDefaultsKey
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.deviceId:
                cell?.subTitleLabel.text = UIDevice.current.identifierForVendor?.uuidString
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.appVersion:
                let infoDict: NSDictionary = Bundle.main.infoDictionary! as NSDictionary
                cell?.subTitleLabel.text = infoDict.object(forKey: "CFBundleShortVersionString") as? String
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.pushNotification:
                cell?.subTitleLabel.text = AdminSettingsConstants.adminStringConstants.notApplicable
                if let devicetoken = UserDefaults.standard.value(forKey: userDefaultsKey) as? String {
                    cell?.subTitleLabel.text = devicetoken
                    UIPasteboard.general.string = cell?.subTitleLabel.text
                }
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.profileLog:
                cell?.subTitleLabel.text = ""
                cell?.switchControl.isHidden = false
                cell?.switchControl.tag = SwitchControlTag.profileLog
                cell?.switchControl.setOn(kaEnableProfileLogs, animated: false)
                cell?.switchControl.addTarget(self, action: #selector(self.On_SwitchValueChange(_:)), for: .valueChanged)
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.deviceLog:
                cell?.subTitleLabel.text = ""
                cell?.switchControl.isHidden = false
                cell?.switchControl.tag = SwitchControlTag.deviceLog
                cell?.switchControl.setOn(kaEnableDeviceLogs, animated: false)
                cell?.switchControl.addTarget(self, action: #selector(self.On_SwitchValueChange(_:)), for: .valueChanged)
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.viewMySrDetailLink:
                cell?.subTitleLabel.text = AdminSettingsConstants.adminStringConstants.notApplicable
                if let basePath = UserDefaults.standard.value(forKey: AdminSettingsConstants.UniqueKeyConstants.templateURL) as? String {
                    let localFilePath = String(format: AdminSettingsConstants.adminStringConstants.templateURLAppendString, basePath, userDefaultsKey)
                    cell?.subTitleLabel.text = localFilePath

                }
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.viewMySrDetailVer:
                cell?.subTitleLabel.text = AdminSettingsConstants.adminStringConstants.notApplicable
                if let version = UserDefaults.standard.object(forKey: userDefaultsKey) as? String {
                    cell?.subTitleLabel.text = version
                }
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.createSrTemplateLink:
                cell?.subTitleLabel.text = AdminSettingsConstants.adminStringConstants.notApplicable
                if let basePath = UserDefaults.standard.value(forKey: AdminSettingsConstants.UniqueKeyConstants.templateURL) as? String {
                    let localFilePath = String(format: AdminSettingsConstants.adminStringConstants.templateURLAppendString, basePath, userDefaultsKey)
                    cell?.subTitleLabel.text = localFilePath
                }
                break
            case AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.createSrTemplateVer:
                cell?.subTitleLabel.text = AdminSettingsConstants.adminStringConstants.notApplicable
                if let version = UserDefaults.standard.object(forKey: userDefaultsKey) as? String {
                    cell?.subTitleLabel.text = version
                }
                break
            default:
                cell?.subTitleLabel.text = userDefaultsKey
                break
            }
            return cell!
        }

    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == AdminTableSection.ServerURLSection {
            return CGFloat(AdminScreenRowHeight.textFieldCellHeight)
        } else {
            let array = self.section_row_Details_Array[indexPath.section] as? NSArray
            let dict = array?[indexPath.row] as? NSDictionary
            let title = dict?[AdminSettingsConstants.UniqueKeyConstants.titleKey] as? String ?? ""
            if title == AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.profileLog || title == AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.deviceLog {
                return CGFloat(AdminScreenRowHeight.switchLogsCellHeight)
            } else if title == AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.viewMySrDetailLink || title == AdminSettingsConstants.SettingTableViewOtherDetialsCellIdentifier.createSrTemplateLink {
                return CGFloat(AdminScreenRowHeight.templateDetailsURLHeight)
            }
            return CGFloat(AdminScreenRowHeight.defaultHeight)
        }
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let ViewFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: headerHeight)
        let headerView = UIView(frame: ViewFrame)
        headerView.backgroundColor = AdminSettingsConstants.ColorConstants.lightGrayBorderColor
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.size.width - 30, height: headerHeight))
        headerLabel.backgroundColor = UIColor.clear
        headerLabel.textColor = self.themeColor
        headerLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        if section == AdminTableSection.ServerURLSection {
            headerLabel.text = AdminSettingsConstants.adminStringConstants.serverURLSectionTitle
        } else {
            headerLabel.text = AdminSettingsConstants.adminStringConstants.otherDetailsSectionTitle
        }
        headerView.addSubview(headerLabel)
        return headerView
    }

    //MARK:- Enable/ disable Logs Method
    @IBAction func On_SwitchValueChange(_ sender: UISwitch) {
        if sender.tag == SwitchControlTag.deviceLog {
            userDefault.set(sender.isOn, forKey: AdminSettingsConstants.UniqueKeyConstants.enableDeviceLogs)
            kaEnableDeviceLogs = sender.isOn
        } else {
            userDefault.set(sender.isOn, forKey: AdminSettingsConstants.UniqueKeyConstants.enableProfileLogs)
            kaEnableProfileLogs = sender.isOn
        }
        userDefault.synchronize()
    }

    //MARK:- Save Button Click
    /**
     Sets ServerURL and UserServerUrl
     */
    @IBAction func onSaveButtonClick(_ sender: AnyObject) {
        self.view.endEditing(true)
        // Updating userdefaults with edited data
        for updatedValueDict in serverURLsUpdatedDictArray {
            let dict = updatedValueDict as NSDictionary
            if let updatedKey = dict.object(forKey: AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey) as? String, let updatedValue = dict.object(forKey: AdminSettingsConstants.UniqueKeyConstants.titleKey) as? String {
                userDefault.set(updatedValue, forKey: updatedKey)
            }
        }
        serverURLsUpdatedDictArray = [[String: String]]()
        userDefault.synchronize()
    }

    //MARK:- UITextField Delegate
    public func textFieldDidEndEditing(_ textField: UITextField) {
        // stpring edited urls in array with key value pair
        let array = self.section_row_Details_Array[0] as? NSArray
        let dict = array?[textField.tag] as? NSDictionary
        if let userDefaultsKey = dict?[AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey] as? String {
            serverURLsUpdatedDictArray.append([AdminSettingsConstants.UniqueKeyConstants.titleKey: textField.text ?? "", AdminSettingsConstants.UniqueKeyConstants.userDefaultsKey: userDefaultsKey])
        }
    }


}
