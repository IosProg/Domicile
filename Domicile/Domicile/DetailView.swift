//  DetailView.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.


import UIKit
import Firebase

class DetailView: UIViewController {
// Connexting the textfields from the detail view in storyboard
    @IBOutlet weak var suburbTextField: UILabel!
    @IBOutlet weak var houseImage: UIImageView!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var rentTextField: UITextField!
    @IBOutlet weak var parkingTextField: UITextField!
    @IBOutlet weak var bathroomTextField: UITextField!
    @IBOutlet weak var bedroomTextField: UITextField!
    
    var house : House?
    // perform seque to go to view controller which will add reminder to calendar for inspection
    @IBAction func btnPressed(_ sender: Any) {
        performSegue(withIdentifier: "bookInspection", sender: self)
    }
    // perform action when sign out is tapped
    @IBAction func signOutTapped(_ sender: Any) {
        do {  //sign out the user and perform seque to go to the login page
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOut", sender: nil)
        } catch {
            print(error)
        }
    }
    // share button pressed to share the details of accomodation with friends via whatsapp , facebook etc.
    @IBAction func sharePressed(_ sender: Any) {
        let activityVC = UIActivityViewController(activityItems: [self.houseImage.image!, self.addressTextField.text, self.rentTextField.text], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        suburbTextField.text = house?.suburb
        addressTextField.text = house?.address
        rentTextField.text = house?.rent
        parkingTextField.text = house?.parking
        bathroomTextField.text = house?.bathroom
        bedroomTextField.text = house?.bedroom
        houseImage.image = house?.image
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        suburbTextField.text = house?.suburb
        addressTextField.text = house?.address
        rentTextField.text = house?.rent
        parkingTextField.text = house?.parking
        bathroomTextField.text = house?.bathroom
        bedroomTextField.text = house?.bedroom
        houseImage.image = house?.image
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
   
    

}
