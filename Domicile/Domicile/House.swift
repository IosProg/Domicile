//  House.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.


import UIKit

class House
{  // creating a class house and declaring attributes of class
    var suburb: String
    var address: String
    var bedroom: String
    var bathroom: String
    var parking: String
    var rent: String
    var image: UIImage
    // Declaring what would be conatined in one single house object
    init(suburb: String, address: String, bedroom: String, bathroom: String, parking: String, rent: String){
        self.suburb = suburb
        self.address = address
        self.bathroom = bathroom
        self.bedroom = bedroom
        self.parking = parking
        self.rent = rent
        image = UIImage(named: self.suburb)!
    }
    
}
