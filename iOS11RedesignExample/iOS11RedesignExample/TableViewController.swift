//
//  TableViewController.swift
//  DEVPUCTutorial
//
//  Created by Lucas Ferraço on 20/07/17.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {
	
	var dogTypes = ["Bull Terrier", "Yorkshire Terrier", "Boston Terrier", "Golden Retriever", "Labrador Retriever", "ShihTzu", "Bichon Frise", "Beagle", "Akita", "Border Collie", "Buldogue Ingles", "Buldogue Frances", "Vira-Lata"]
	var filteredDogs = [String]()
	var searchController: UISearchController!
	var chosenIndex: Int?
	
	override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Raças"
		
		navigationController?.navigationBar.prefersLargeTitles = true
		
		dogTypes = dogTypes.sorted()
		
		makeSearchController()
		
		navigationItem.searchController = searchController
		navigationItem.hidesSearchBarWhenScrolling = false
	}
	
	//MARK:- Search Controller Delegate
	func makeSearchController() {
		searchController = UISearchController(searchResultsController: nil)
		searchController.searchResultsUpdater = self
		searchController.dimsBackgroundDuringPresentation = false
		definesPresentationContext = true
	}
	
	func filterContentForSearchText(searchText: String, scope: String = "All") {
		filteredDogs = dogTypes.filter { type in
			return type.lowercased().contains(searchText.lowercased())
		}
		
		tableView.reloadData()
	}
	
	func updateSearchResults(for searchController: UISearchController) {
		filterContentForSearchText(searchText: searchController.searchBar.text!)
	}
	
	//MARK:- Table View Delegate
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if searchController.isActive {
			return filteredDogs.count
		}
		
		return dogTypes.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
		
		if searchController.isActive && searchController.searchBar.text != "" {
			cell.textLabel?.text = filteredDogs[indexPath.row]
		} else {
			cell.textLabel?.text = dogTypes[indexPath.row]
		}
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		chosenIndex = indexPath.row
		performSegue(withIdentifier: "presentVideoSegue", sender: nil)
	}
	
	// MARK: - Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "presentVideoSegue" {
			let nextVC = segue.destination as! DogViewController
			var chosenDog = String()
			
			if searchController.isActive && searchController.searchBar.text != "" {
				chosenDog = filteredDogs[chosenIndex!]
			} else {
				chosenDog = dogTypes[chosenIndex!]
			}
			
			nextVC.selectedDog = chosenDog
		}
	}

}
