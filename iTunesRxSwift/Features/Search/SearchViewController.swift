//
//  SearchViewController.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/6/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


final class SearchviewController: BaseViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let appTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        return view
    }()
    
    private var disposeBag = DisposeBag()
    private let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchController()
        bind()
    }
    
    private func bind() {
        let searchBar = searchController.searchBar
        
        let input = SearchViewModel.Input(searchButtonTap: searchBar.rx.searchButtonClicked,
                                          searchText: searchBar.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.items
            .bind(to: appTableView.rx.items(cellIdentifier: SearchTableViewCell.identifier,
                                            cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.trackCensoredName
            }
            .disposed(by: disposeBag)
    }
    
    override func configureHierarchy() {
        view.addSubview(appTableView)
    }
    
    override func configureConstraints() {
        appTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        navigationItem.title = "검색"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func configureSearchController() {
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
        
        // TODO: 여기서 RxSwift debounce로 검색어 보내고 받기 필요
        print("검색어: \(query)")
    }
    
    
}
