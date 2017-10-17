//
//  AdminSettingsControl.swift
//  Pods
//
//  Created by Krutika on 10/17/17.
//
//

import UIKit


public class AdminSettingsControl {

    public init(adminArray: NSMutableArray, navigationController: UINavigationController) {
        let bundle = Bundle(identifier: AdminSettingsConstants.adminBundleID)
        let adminVC = AdminSettingsViewController(nibName: AdminSettingsConstants.UniqueKeyConstants.adminSettingsXibName, bundle: bundle)
        adminVC.section_row_Details_Array = adminArray
        navigationController.pushViewController(adminVC, animated: true)
    }
}
