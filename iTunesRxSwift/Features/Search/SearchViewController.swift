//
//  SearchViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import UIKit
import SnapKit

final class SearchviewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
    }
    
    override func configureHierarchy() {
        
    }
    
    override func configureConstraints() {
    }
    
    override func configureView() {
        navigationItem.title = "검색"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임, 앱, 스토리 등"
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchResultsUpdater = self
        
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.searchController = searchController
    }
}

extension SearchviewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text else {
            return
        }
        
        // 
        print("검색어: \(query)")
    }
}
