//  TableViewController.swift
//  Domicile
//  Copyright © 2018 Deakin University. All rights reserved.
import UIKit
class TableViewController: UITableViewController,UISearchBarDelegate{
    // connecting the search bar
    @IBOutlet weak var searchBar: UISearchBar!
    //variable declarations
    var houses = [House]()
    var isSignIn: Bool = true
    var filteredHouses : [House] = []
    var searchBarActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // running the function setupup houses to populate the list
        SetUpHouses()
        searchBar.delegate = self
        filteredHouses = houses
       
    }
  
    private func SetUpHouses()
    {  // purtting data for the list
        let house1 = House(suburb: "Burwood", address: "5 Terry Street", bedroom: "2", bathroom: "1", parking: "1", rent: "2000")
        houses.append(house1)
        let house2 = House (suburb: "Noble Park", address: "22 Jeffers Street", bedroom: "3", bathroom: "2", parking: "1", rent: "1700")
        houses.append(house2)
        let house3 = House (suburb: "Dandenong", address: "21 Swan Street", bedroom: "2", bathroom: "1", parking: "2", rent: "1500")
         houses.append(house3)
        let house4 = House (suburb: "Springvale", address: "11 Hume Road", bedroom: "2", bathroom: "1", parking: "2", rent: "1890")
         houses.append(house4)
        let house5 = House (suburb: "Keysborough", address: "05 Leonard Avenue", bedroom: "4", bathroom: "2", parking: "3", rent: "2100")
         houses.append(house5)
        let house6 = House (suburb: "Blackburn", address: "18 Linum Street", bedroom: "4", bathroom: "2", parking: "2", rent: "2200")
         houses.append(house6)
        let house7 = House (suburb: "Clayton", address: "19 Banksia Street", bedroom: "4", bathroom: "3", parking: "2", rent: "2500")
         houses.append(house7)
        let house8 = House (suburb: "Mount Waverly", address: "25 Sherwood Road", bedroom: "2", bathroom: "2", parking: "2", rent: "1895")
         houses.append(house8)
        let house9 = House (suburb: "Frankston", address: "1/8 Lewis Street", bedroom: "2", bathroom: "1", parking: "1", rent: "1800")
         houses.append(house9)
        let house10 = House (suburb: "Oakleigh", address: "14 Oxford Street", bedroom: "2", bathroom: "1", parking: "2", rent: "2100")
         houses.append(house10)

    }
   
 
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // setting the height of the row in table
        return 120
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        //number of sections in the table view
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   // numbers of rows in section is set to the numbers of houses appended
        return filteredHouses.count
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar)
    {   // show the cancel button when user starts typing in the search bar
        self.searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {   // action to be performed when search cancel button is clicked
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar)
    {   // search bar stays on when user has stopped typing
        searchBarActive = false
    }
    // running the search bar function
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // if the search bar is empty filterted houses is equal to houses list
        guard  !searchText.isEmpty else {
            filteredHouses = houses
            tableView.reloadData()
            return
        }
        // else the list will be filtered accorinding to alphabets entered by the user
     filteredHouses = houses.filter({ house -> Bool in
        house.suburb.lowercased().contains(searchText.lowercased())
     
        })
        tableView.reloadData()
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
     
//  this func declares what would be dusplayed in each row. in this case, it is image and suburb name
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "houseCell2", for: indexPath)
    
        cell.textLabel?.text = filteredHouses[indexPath.row].suburb
        cell.imageView?.image = filteredHouses[indexPath.row].image
        
        return cell
    }
    // when the user clicks on the one of the row, perform the seque to detail view. It means open detail view
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "detailView", sender: self)
    }
    // open the row in detail which is selected by the user.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailView {
            destination.house = filteredHouses[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
   
}

