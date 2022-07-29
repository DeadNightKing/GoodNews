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
    
    private var articleListVM: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        populateNews()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0: self.articleListVM.articlesVM.count
    }
    
    
    private func populateNews() {
        
        let resource = Resourse<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=tw&category=technology&apiKey=42678638c9514b2cba614b69032aaaa2")!)
        
        URLRequest.load(resourse: resource)
            .subscribe (onNext:{ articleResponse in
                
                let article = articleResponse.articles
                self.articleListVM = ArticleListViewModel(article)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            })
            .disposed(by: disposedBag)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell
        else {
            fatalError("Error")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.titleLabel.rx.text)
            .disposed(by: disposedBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.descriptionLabel.rx.text)
            .disposed(by: disposedBag)
        
        return cell
    }
}
