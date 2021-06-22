//
//  SearchVC.swift
//  SoundCloud
//
//  Created by Quang Pham on 18/11/2020.
//

import UIKit

final class SearchVC: BaseLargeTitleNavBarVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search"
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = search
        search.searchBar.placeholder = "Type artists, songs, or lyrics"
        search.searchBar.delegate = self
    }

}

extension SearchVC: UISearchBarDelegate {
    
}
