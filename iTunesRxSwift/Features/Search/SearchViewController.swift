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
import Kingfisher

final class SearchviewController: BaseViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let appTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.separatorStyle = .none
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
                cell.appIconImageView.kf.setImage(with: URL(string: element.artworkUrl512))
                
                let score = String(format: "%.1f", element.averageUserRating)
                cell.scoreLabel.text = score
                cell.artistNameLabel.text = element.artistName
                cell.genreLabel.text = element.genres.first
            }
            .disposed(by: disposeBag)
        
        Observable.zip(appTableView.rx.modelSelected(App.self),
                       appTableView.rx.itemSelected)
        .map { $0.0 }
        .subscribe(with: self) { owner, app in
            let vc = AppDetailViewController()
            vc.selectedApp = app
            
            owner.navigationController?.pushViewController(vc, animated: true)
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
        appTableView.delegate = self
        
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
        
        // TODO: 여기서 RxSwift debounce로 실시간 검색어 보내고 받기 필요
        // print("검색어: \(query)")
    }
}

extension SearchviewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
}
