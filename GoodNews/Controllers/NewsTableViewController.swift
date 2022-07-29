//
//  NewsTableViewController.swift
//  GoodNews
//
//  Created by Flow_RyanChou on 2022/7/28.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
    
    let disposedBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    
    private func populateNews() {
        
        let resource = Resourse<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=tw&category=technology&apiKey=42678638c9514b2cba614b69032aaaa2")!)
        
        URLRequest.load(resourse: resource)
            .subscribe {
                print($0)
            }
            .disposed(by: disposedBag)
        
        
        
        
        
    }
}
