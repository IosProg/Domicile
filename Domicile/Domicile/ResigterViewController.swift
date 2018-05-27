//  ResigterViewController.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.


import UIKit
import Firebase
import FirebaseDatabase

class ResigterViewController: UIViewController {
    //Connecting the text fields and buttons.
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailAddressTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
   
    @IBOutlet weak var profileImageView: UIImageView!
   
    // declring the image picker.
   var imagePicker:UIImagePickerController!
    // creating a database reference
    var ref: DatabaseReference!
    @IBAction func registerTapped(_ sender: Any) {
        guard let image = profileImageView.image else { return }// allowing the user to add image to thier profile
        
        guard let username = userNameTF.text,
            username != "",// check if username is not empty
            let email = emailAddressTF.text,
            email != "",// check if email is not empty
            let password = passwordTF.text,
            password != ""// check if password is not empty
            else {
                // show alert if any details are missing or empty
                AlertController.showAlert(self, title: "Missing Info", message: "Please fill out all fields")
                return
        }
        // create the user and add to database if all the details are filled
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            guard error == nil else {
                // show alert if any error occurs
                AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                return
                    self.uploadProfileImage(image) { url in }
                // let the user change theri username if they want to
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { (error) in
                    guard error == nil else {
                        // show alert if some error occurs if error occurs while changing username
                        AlertController.showAlert(self, title: "Error", message: error!.localizedDescription)
                        return
                    }
                    // perform the seque when the user has been created and go to table view to view the list of accomodation
                    self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                })
            }
            guard let user = user else { return }
       // adding the user to database
        let ref = Database.database().reference(fromURL: "https://domicile-9aeaf.firebaseio.com/")
            // creating a directory in dtabase
         let userReference = ref.child("users").child(user.user.uid)
            // vales to be stored in database, username and email
            let values = ["username": username, "email":email]
            // try to save values to databae else return error
            userReference.updateChildValues(values, withCompletionBlock: { (err, ref)  in
                if err != nil {
                    print(err)
                    return
                }//succesfully dave to database
                print("Saved user Successful into Firebase db")
            })
            // when the user has been created and saved to database ,perform segue to go to the table view to view the list
            self.performSegue(withIdentifier: "registerLogin", sender: nil)
        })
    }
    // Func to upload the image selected by user to the database.  NOT WORKING COMPLETELY
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())){
        guard let  uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        guard  let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(imageData, metadata: metaData) {
            metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL(completion: {(url, error) in
                    guard let downloadURL = url else { return }
                })
                
            }
           
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // declaring the tap gesture on the image view
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true// enabiling the interaction of the user with image view
        profileImageView.addGestureRecognizer(imageTap)// tap gesture
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true// alow the user to edit the image he is trying to select.
        imagePicker.sourceType = .photoLibrary // pic can be chosen from the photo library of the user
        imagePicker.delegate  = self
    
    }
    
    @objc func openImagePicker(_ sender:Any)
    {
     self.present(imagePicker,animated:  true, completion:  nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
extension ResigterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // when the user tapps on cancel in the imagge picker, dismiss it and got back to view
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }// when the user is finished picking the image,set the selected image as profile image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            self.profileImageView.image = pickedImage
        }//picker should be dismissed
        picker.dismiss(animated: true, completion: nil)
    }
    
}
