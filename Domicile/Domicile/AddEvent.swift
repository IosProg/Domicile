//  AddEvent.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.

import UIKit
import EventKit

class AddEvent: UIViewController {
// To create an event in the calendar about the isnpection of the propert
    
    var calendar: EKCalendar!
  // creating the connection
    @IBOutlet weak var eventNameTextField: UITextField!
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    
    // action performed when add event is tapped.
        @IBAction func addEventTapped(_ sender: UIBarButtonItem) {
        let eventStore = EKEventStore()
        if let calendarForEvent = eventStore.calendar(withIdentifier: self.calendar.calendarIdentifier){
            let newEvent = EKEvent(eventStore: eventStore)
            newEvent.calendar = calendarForEvent
            newEvent.title = self.eventNameTextField.text
            newEvent.startDate = self.startDate.date
            newEvent.endDate = self.endDate.date
            
            // Save the calendar using the Event Store instance
            do {
                try eventStore.save(newEvent, span: .thisEvent, commit: true)
             
                
                self.dismiss(animated: true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
            
        }
        

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
