//
//  SearchViewModel.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/7/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchButtonTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let items: PublishSubject<[App]>
    }
    
    func transform(input: Input) -> Output {
        
        let appStoreSearchResult = PublishSubject<[App]>()
        
        /*
            1. SearchBar 검색 이벤트 캐치
            2. .withLatestFrom 으로 검색어 가져오기
         */
        
        input.searchButtonTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .subscribe(with: self) { owner, query in
                iTunesAPIManager.shared.request(type: AppStore.self, api: iTunesAPI.search(query: query)) { appStore in
                    appStoreSearchResult.onNext(appStore.results)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(items: appStoreSearchResult)
    }
}
