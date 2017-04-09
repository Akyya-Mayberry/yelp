//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    let searchBar = UISearchBar()
    var businesses: [Business]!
    var filteredData: [Business]!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Requirements to set table and autolayout
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        
        // MARK: Search bar in navigation set up Part I
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.placeholder = "Restaurants"
        navigationItem.titleView = searchBar
        
        Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
            self.businesses = businesses
            self.filteredData = businesses
            self.tableView.reloadData()
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredData != nil {
            return filteredData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        
        cell.business = filteredData[indexPath.row]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // From this view segue to another navigation controller
        let navigationController = segue.destination as! UINavigationController
        
        // Destination is the navigation controller that currently only manages
        // the filtersViewController, so the navigation controller top view controller
        // is the controller of interest
        let filtersViewController = navigationController.topViewController as! FiltersViewController
        
        // Now that there is access to filtersViewController, this
        // controller can be set as it's delegate and therefore get it's events
        filtersViewController.delegate = self
    }

    // This controller is filterViewController delegate during prepping for a segue,
    // so implement the option filtersViewController method so that this controller
    // can be aware of filter change states and send this updated info to the view
    // When the search button is tapped in the filters view, delegates of the filtersViewController
    // that implement filtersViewControllerDelegate protocol gets this action.

    // MARK: Search in navigation Part II
    func filtersViewController(filtersViewController: FiltersViewController, didUpdateFilters filters: [String: AnyObject]) {
        
        var categories = filters["categories"] as? [String]

        // Update data, by calling new search with applied filters and
        // passing that updated data to the view.
        // Currently filtering by category is only implemented.
        Business.searchWithTerm(term: "Restaurants", sort: nil, categories: categories, deals: nil)
            {(businesses, error) -> Void in
                self.businesses = businesses
                self.tableView.reloadData()
            }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    // Remove the filtered data (maybe be built in function or something to do this)
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filteredData = businesses
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    // Update business results if a search is in progress
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? businesses : businesses.filter { (item: Business) -> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        tableView.reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Handle scroll behavior here
        print("%%%%%%% IM SCROLLING")
        if (!isMoreDataLoading) {
            isMoreDataLoading = true
            
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // ... Code to load more results ...
                Business.searchWithTerm(term: "Restaurants", completion: { (businesses: [Business]?, error: Error?) -> Void in
                    self.businesses = businesses
                    self.filteredData = businesses
                    self.tableView.reloadData()
                })
            }
            
        }
    }
}

// MARK: TODO:
// Vamp up search capability to include other filters
