// ViewController.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.
import UIKit
import Firebase
import FirebaseDatabase


class ViewController: UIViewController {
   
   // Text Fields for entering email and password
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    // action when login is tapped
    @IBAction func LogInTapped(_ sender: Any) { guard let email = mailTF.text,
        email != "",// checks if email is not empty
        let password = passwordTF.text,
        password != ""// checks if password is not empty
        else { // show alert if the some info is missing
            AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all required fields")
            return
        }
        // sign in when all info is filled
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else { //show error message if something goes wrong
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
            }
            guard let user = user else { return }
            // checking in the console
            print(user.user.email ?? "MISSING EMAIL")
            print(user.user.displayName ?? "MISSING DISPLAY NAME")
            print(user.user.uid)
            // pperforing segue to go to table view
            self.performSegue(withIdentifier: "signIn", sender: nil)
            
            
        })
        
    }
    var isSignIn: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Dismiss keyboard when the view is tapped on
        mailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
    }
}


