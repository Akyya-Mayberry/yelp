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
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var categories: [[String: String]]!
    var distance = ["1", "2", "3"]
    var sort = ["Best Matched", "Distance", "Highest Rated"]
    var sections = ["Categories", "Distance", "Sort"]
    var switchStates = [IndexPath: Bool]() // Keep track of cell states
    
    // If a class uses the protocol FiltersViewControllerDelegate
    // It can optionally make itself a delegate
    weak var delegate: FiltersViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categories = getCategories()
        tableView.dataSource = self
        tableView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Search Filters
    @IBAction func onSearch(_ sender: Any) {
        dismiss(animated: true)
        
        // The business view controller needs to populate table cells
        // based on a list of filters to be sent to the API
        var filters = [String: AnyObject]() // I am not sure what filters is representing
        
        // Gather filters types
        var selectedCategories = [String]()
        var selectedDistance = [String]()
        var selectedSort = [String]()
        //

        // Update list of filters with cateogries
        if selectedCategories.count > 0 {
            filters["categories"] = selectedCategories as AnyObject? // filters dict expects key vals to be AnyObject
        }

        delegate?.filtersViewController?(filtersViewController: self, didUpdateFilters: filters)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    // MARK: Table and Cells
    // Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // Rows per section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return categories.count // Category
            case 1: return distance.count // Distance
            case 2: return sort.count // Sort
            default: return 0
        }
    }
    
    // Cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell", for: indexPath) as! SwitchCell
              cell.delegate = self

        switch indexPath.section {
            case 0: cell.switchLabel.text = categories[indexPath.row]["name"] // Category
            case 1: cell.switchLabel.text = distance[indexPath.row] // Distance
            case 2: cell.switchLabel.text = sort[indexPath.row] // Sort
            default: cell.switchLabel.text = "No label"
        }

        // Restore cell states if necessary or provide default state
        cell.onSwitch.isOn = switchStates[indexPath] ?? false
        
        return cell
    }
    
    // Section headers
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // Update cell states
    // Part of SwitchCellDelegate protocol
    func SwitchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)!

        switchStates[indexPath] = value
    }

    // Yelp categories
    func getCategories() -> [[String: String]] {
        return [["name" : "Afghan", "code": "afghani"],
                                 ["name" : "African", "code": "african"],
                                 ["name" : "American, New", "code": "newamerican"],
                                 ["name" : "American, Traditional", "code": "tradamerican"],
                                 ["name" : "Arabian", "code": "arabian"],
                                 ["name" : "Argentine", "code": "argentine"],
                                 ["name" : "Armenian", "code": "armenian"],
                                 ["name" : "Asian Fusion", "code": "asianfusion"],
                                 ["name" : "Asturian", "code": "asturian"],
                                 ["name" : "Australian", "code": "australian"],
                                 ["name" : "Austrian", "code": "austrian"],
                                 ["name" : "Baguettes", "code": "baguettes"],
                                 ["name" : "Bangladeshi", "code": "bangladeshi"],
                                 ["name" : "Barbeque", "code": "bbq"],
                                 ["name" : "Basque", "code": "basque"],
                                 ["name" : "Bavarian", "code": "bavarian"],
                                 ["name" : "Beer Garden", "code": "beergarden"],
                                 ["name" : "Beer Hall", "code": "beerhall"],
                                 ["name" : "Beisl", "code": "beisl"],
                                 ["name" : "Belgian", "code": "belgian"],
                                 ["name" : "Bistros", "code": "bistros"],
                                 ["name" : "Black Sea", "code": "blacksea"],
                                 ["name" : "Brasseries", "code": "brasseries"],
                                 ["name" : "Brazilian", "code": "brazilian"],
                                 ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                                 ["name" : "British", "code": "british"],
                                 ["name" : "Buffets", "code": "buffets"],
                                 ["name" : "Bulgarian", "code": "bulgarian"],
                                 ["name" : "Burgers", "code": "burgers"],
                                 ["name" : "Burmese", "code": "burmese"],
                                 ["name" : "Cafes", "code": "cafes"],
                                 ["name" : "Cafeteria", "code": "cafeteria"],
                                 ["name" : "Cajun/Creole", "code": "cajun"],
                                 ["name" : "Cambodian", "code": "cambodian"],
                                 ["name" : "Canadian", "code": "New)"],
                                 ["name" : "Canteen", "code": "canteen"],
                                 ["name" : "Caribbean", "code": "caribbean"],
                                 ["name" : "Catalan", "code": "catalan"],
                                 ["name" : "Chech", "code": "chech"],
                                 ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                                 ["name" : "Chicken Shop", "code": "chickenshop"],
                                 ["name" : "Chicken Wings", "code": "chicken_wings"],
                                 ["name" : "Chilean", "code": "chilean"],
                                 ["name" : "Chinese", "code": "chinese"],
                                 ["name" : "Comfort Food", "code": "comfortfood"],
                                 ["name" : "Corsican", "code": "corsican"],
                                 ["name" : "Creperies", "code": "creperies"],
                                 ["name" : "Cuban", "code": "cuban"],
                                 ["name" : "Curry Sausage", "code": "currysausage"],
                                 ["name" : "Cypriot", "code": "cypriot"],
                                 ["name" : "Czech", "code": "czech"],
                                 ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                                 ["name" : "Danish", "code": "danish"],
                                 ["name" : "Delis", "code": "delis"],
                                 ["name" : "Diners", "code": "diners"],
                                 ["name" : "Dumplings", "code": "dumplings"],
                                 ["name" : "Eastern European", "code": "eastern_european"],
                                 ["name" : "Ethiopian", "code": "ethiopian"],
                                 ["name" : "Fast Food", "code": "hotdogs"],
                                 ["name" : "Filipino", "code": "filipino"],
                                 ["name" : "Fish & Chips", "code": "fishnchips"],
                                 ["name" : "Fondue", "code": "fondue"],
                                 ["name" : "Food Court", "code": "food_court"],
                                 ["name" : "Food Stands", "code": "foodstands"],
                                 ["name" : "French", "code": "french"],
                                 ["name" : "French Southwest", "code": "sud_ouest"],
                                 ["name" : "Galician", "code": "galician"],
                                 ["name" : "Gastropubs", "code": "gastropubs"],
                                 ["name" : "Georgian", "code": "georgian"],
                                 ["name" : "German", "code": "german"],
                                 ["name" : "Giblets", "code": "giblets"],
                                 ["name" : "Gluten-Free", "code": "gluten_free"],
                                 ["name" : "Greek", "code": "greek"],
                                 ["name" : "Halal", "code": "halal"],
                                 ["name" : "Hawaiian", "code": "hawaiian"],
                                 ["name" : "Heuriger", "code": "heuriger"],
                                 ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                                 ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                                 ["name" : "Hot Dogs", "code": "hotdog"],
                                 ["name" : "Hot Pot", "code": "hotpot"],
                                 ["name" : "Hungarian", "code": "hungarian"],
                                 ["name" : "Iberian", "code": "iberian"],
                                 ["name" : "Indian", "code": "indpak"],
                                 ["name" : "Indonesian", "code": "indonesian"],
                                 ["name" : "International", "code": "international"],
                                 ["name" : "Irish", "code": "irish"],
                                 ["name" : "Island Pub", "code": "island_pub"],
                                 ["name" : "Israeli", "code": "israeli"],
                                 ["name" : "Italian", "code": "italian"],
                                 ["name" : "Japanese", "code": "japanese"],
                                 ["name" : "Jewish", "code": "jewish"],
                                 ["name" : "Kebab", "code": "kebab"],
                                 ["name" : "Korean", "code": "korean"],
                                 ["name" : "Kosher", "code": "kosher"],
                                 ["name" : "Kurdish", "code": "kurdish"],
                                 ["name" : "Laos", "code": "laos"],
                                 ["name" : "Laotian", "code": "laotian"],
                                 ["name" : "Latin American", "code": "latin"],
                                 ["name" : "Live/Raw Food", "code": "raw_food"],
                                 ["name" : "Lyonnais", "code": "lyonnais"],
                                 ["name" : "Malaysian", "code": "malaysian"],
                                 ["name" : "Meatballs", "code": "meatballs"],
                                 ["name" : "Mediterranean", "code": "mediterranean"],
                                 ["name" : "Mexican", "code": "mexican"],
                                 ["name" : "Middle Eastern", "code": "mideastern"],
                                 ["name" : "Milk Bars", "code": "milkbars"],
                                 ["name" : "Modern Australian", "code": "modern_australian"],
                                 ["name" : "Modern European", "code": "modern_european"],
                                 ["name" : "Mongolian", "code": "mongolian"],
                                 ["name" : "Moroccan", "code": "moroccan"],
                                 ["name" : "New Zealand", "code": "newzealand"],
                                 ["name" : "Night Food", "code": "nightfood"],
                                 ["name" : "Norcinerie", "code": "norcinerie"],
                                 ["name" : "Open Sandwiches", "code": "opensandwiches"],
                                 ["name" : "Oriental", "code": "oriental"],
                                 ["name" : "Pakistani", "code": "pakistani"],
                                 ["name" : "Parent Cafes", "code": "eltern_cafes"],
                                 ["name" : "Parma", "code": "parma"],
                                 ["name" : "Persian/Iranian", "code": "persian"],
                                 ["name" : "Peruvian", "code": "peruvian"],
                                 ["name" : "Pita", "code": "pita"],
                                 ["name" : "Pizza", "code": "pizza"],
                                 ["name" : "Polish", "code": "polish"],
                                 ["name" : "Portuguese", "code": "portuguese"],
                                 ["name" : "Potatoes", "code": "potatoes"],
                                 ["name" : "Poutineries", "code": "poutineries"],
                                 ["name" : "Pub Food", "code": "pubfood"],
                                 ["name" : "Rice", "code": "riceshop"],
                                 ["name" : "Romanian", "code": "romanian"],
                                 ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                                 ["name" : "Rumanian", "code": "rumanian"],
                                 ["name" : "Russian", "code": "russian"],
                                 ["name" : "Salad", "code": "salad"],
                                 ["name" : "Sandwiches", "code": "sandwiches"],
                                 ["name" : "Scandinavian", "code": "scandinavian"],
                                 ["name" : "Scottish", "code": "scottish"],
                                 ["name" : "Seafood", "code": "seafood"],
                                 ["name" : "Serbo Croatian", "code": "serbocroatian"],
                                 ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                                 ["name" : "Singaporean", "code": "singaporean"],
                                 ["name" : "Slovakian", "code": "slovakian"],
                                 ["name" : "Soul Food", "code": "soulfood"],
                                 ["name" : "Soup", "code": "soup"],
                                 ["name" : "Southern", "code": "southern"],
                                 ["name" : "Spanish", "code": "spanish"],
                                 ["name" : "Steakhouses", "code": "steak"],
                                 ["name" : "Sushi Bars", "code": "sushi"],
                                 ["name" : "Swabian", "code": "swabian"],
                                 ["name" : "Swedish", "code": "swedish"],
                                 ["name" : "Swiss Food", "code": "swissfood"],
                                 ["name" : "Tabernas", "code": "tabernas"],
                                 ["name" : "Taiwanese", "code": "taiwanese"],
                                 ["name" : "Tapas Bars", "code": "tapas"],
                                 ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                                 ["name" : "Tex-Mex", "code": "tex-mex"],
                                 ["name" : "Thai", "code": "thai"],
                                 ["name" : "Traditional Norwegian", "code": "norwegian"],
                                 ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                                 ["name" : "Trattorie", "code": "trattorie"],
                                 ["name" : "Turkish", "code": "turkish"],
                                 ["name" : "Ukrainian", "code": "ukrainian"],
                                 ["name" : "Uzbek", "code": "uzbek"],
                                 ["name" : "Vegan", "code": "vegan"],
                                 ["name" : "Vegetarian", "code": "vegetarian"],
                                 ["name" : "Venison", "code": "venison"],
                                 ["name" : "Vietnamese", "code": "vietnamese"],
                                 ["name" : "Wok", "code": "wok"],
                                 ["name" : "Wraps", "code": "wraps"],
                                 ["name" : "Yugoslav", "code": "yugoslav"]]
    }

}
// MARK: TODO:
// Reimplement onSearch with all applied filters
// Look up what Yelp expects distance and sort type to be
// Can categories be loaded from file?
