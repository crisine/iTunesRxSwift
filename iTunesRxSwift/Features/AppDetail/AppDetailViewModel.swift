//
//  AppDetailViewModel.swift
//  iTunesRxSwift
//
//  Created by Minho on 4/8/24.
//

import UIKit
import RxSwift
import RxCocoa

final class AppDetailViewModel {
    
    let screenshotUrls: [String]
    
    struct Input {
        let screenshotUrls: PublishSubject<[String]>
    }
    
    struct Output {
        let screenShotImages: PublishSubject<[UIImage]>
    }
    
    func transform(input: Input) -> Output {
        
        var screenShots: [UIImage]
        
        screenshotUrls.forEach {
            
        }
        
        return Output(screenShotImages: <#T##PublishSubject<[UIImage]>#>)
    }
}
