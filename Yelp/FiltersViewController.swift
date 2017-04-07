//
//  FiltersViewController.swift
//  Yelp
//
//  Created by hollywoodno on 4/6/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit

// Other controllers that want to listen in on changes to the FiltersViewController filters,
// need a way to tune in. This protocol will open up a communication line.
@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject])
}

class FiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    // ex. [displayName, yelp_code]
    var categories = [
        ["name": "African", "code": "african"],
        ["name": "American", "code": "newamerican"],
        ["name": "Arabian", "code": "arabian"],
        ["name": "Armenian", "code": "armenian"],
        ["name": "Asian Fusion", "code": "asianfusion"]
    ]
    
    // Keep track of categories switch state
    // ex. row for selected African category [0: True]
    var switchStates = [Int:Bool]()
    
    // If a class uses the protocol FiltersViewControllerDelegate
    // It can optionally make itself a delegate
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onSearch(_ sender: Any) {
        dismiss(animated: true)
        
        // The business view controller needs to populate table cells
        // based on a list of filters to be sent to the API
        
        var filters = [String: AnyObject]() // I am not sure what filters is representing
        
        // What cateogries have users selected
        var selectedCategories = [String]()
        
        // ex. African cateogoy row (0, True)
        for (category_index, isSet) in switchStates {
            if isSet {
                // Get the code name of the category at particular index
                selectedCategories.append(categories[category_index]["code"]!)
                print("I am a selected category, \(categories[category_index]["code"]!)")
            }
        }
        
        // Update list of filters with cateogries
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject? // filters dict expects key vals to be AnyObject
        }
        
        // If there is a delegate, and filtersViewController method
        // has been implemented, send switch states that are turned on
        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
        
        cell.switchLabel.text = categories[indexPath.row]["name"]
        
        cell.delegate = self
        
        // Set switch on/off state
        // First check if it has ever been set
        // Remember switchStates is [currentCell: Bool for on or off]
        if switchStates[indexPath.row] != nil {
            // switch set has been set, so restore it's state
            cell.onSwitch.isOn = switchStates[indexPath.row]!
        } else {
            // switch state has not been set, so give it a default
            cell.onSwitch.isOn = false
        }
        
        
        return cell
    }
    
    // Modify switch on/off state
    func SwitchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!
        switchStates[indexPath.row] = value
        print("##### i just got tapped! \(switchCell.switchLabel)")
        print("##### i am at index row, \(tableView.indexPath(for: switchCell))")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
