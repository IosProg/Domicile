
//  AlertController.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.


import UIKit

class AlertController {
    // creeates alert when user forgets to fill any info or there is error in the app reading or saving the info.
    static func showAlert(_ inViewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
