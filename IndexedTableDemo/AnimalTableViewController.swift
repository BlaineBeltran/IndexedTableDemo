//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Simon Ng on 3/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    
    // Create an empty dictionary for storing the animals
    var animalsDict = [String:[String]]()
    
    // Create an empty array of strings fro storing section titles
    var animalSectionTitles = [String]()
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Generate the animal dictionary
        createAnimalDict()
    }
    
    // Helper method to generate dictionary for first letter in animal names
    /*
     In this method we loop through all the itmes in the animals array. For each, we initially extract the first letter of the animal's name. To obtain an index for a specific position, you have to ask the string itself for the startIndex and then call the index method to get the desired position. In this case, the target position is 1
     */
    func createAnimalDict() {
        for animal in animals {
            // Get the frist letter of the animal name and build a dictionary
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            
            // This slices the animal string up to the specified index. aka extract the first letter. We wrap the substring with a string instance to convert the substring into a string itself
            let animalKey = String(animal[..<firstLetterIndex])
            
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
        }
        
        // Get the section titles from the dictionary's keys and sort them in ascending order
        animalSectionTitles = [String](animalsDict.keys)
        
        // Short hand for writing the sort closure. "$0 and $1 stand for the first and second string arguments.
        animalSectionTitles.sort(by: {$0 < $1} )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections.
        return animalSectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let animalKey = animalSectionTitles[section]
        
        // We use the guard keyword to determine if the dictionary returns a valid array for the specific animalKey. If not, return 0
        guard let animalValues = animalsDict[animalKey] else {
            return 0
        }
        
        return animalValues.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        let animalKey = animalSectionTitles[indexPath.section]
        if let animalValues = animalsDict[animalKey] {
            cell.textLabel?.text = animalValues[indexPath.row]
            
            // Convert the animal name to lower case and then replace all occurrences of a space with an underscore
            
            let imageFilename = animalValues[indexPath.row].lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFilename)
        }
        
        return cell
    }
    
    
    // Adds an index list to the table view on the right side
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return animalIndexTitles
    }
    
    // Used to verify that the index list tapped exist as a section header, if not it returns -1 aka does nothing
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        guard let index = animalSectionTitles.firstIndex(of: title) else {
            return -1
        }
        
        return index
    }
    
    // Change the height of the section headers
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // Change what the header looks like
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        
        // HEADER BACKGROUND COLOR
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1)
        
        // HEADER SECTION TITLE COLOR
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 11)
        
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }


}
