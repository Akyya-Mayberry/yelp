//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var businesses: [Business]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        Business.searchWithTerm(term: "Thai", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
            self.businesses = businesses
            self.tableView.reloadData()
            
//            if let businesses = businesses {
//                for business in businesses {
//                    print(business.name!)
//                    print(business.address!)
//                }
//            }
            
            }
        )
        
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
         self.businesses = businesses
         
         for business in businesses {
         print(business.name!)
         print(business.address!)
         }
         }
         */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if businesses != nil {
            return businesses.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = businesses[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From this view segue to another navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        // Destination is the navigation controller that currently only manages
        // the filtersViewController, so the navigation controller top view controller
        // is the controller of interest
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        // now that there is access to filtersViewController, this
        // controller can be set as it's delegate and therefore get it's events
        filtersViewController.delegate = self
    }

    // This controller is filterViewController delegate during prepping for a segue,
    // so implement the option filtersViewController method so that this controller
    // can be aware of filter change states and send this updated info to the view
    // When the search button is tapped in the filters view, delegates of the filtersViewController
    // that implement filtersViewControllerDelegate protocol gets this action.

    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject]) {
        
        var categories = filters["categories"] as? [String]
        
        print("I am in filterViewDelegate method, here are categories, \(categories)")
        // Update data, by calling new search with applied filters and
        // passing that updated data to the view
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil)
            {(businesses, error) -> Void in
                print("I am categories, inside of search term \(categories)")
                self.businesses = businesses
                
                print("I am businesses after search term \(businesses)")
                self.tableView.reloadData()
            }
    }
    
}
