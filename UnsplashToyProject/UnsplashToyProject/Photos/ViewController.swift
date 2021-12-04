//
//  ViewController.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/03.
//

import UIKit
import RxSwift
import RxCocoa
import ReactorKit

class ViewController: UIViewController, StoryboardView {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var activityIndicator: UIActivityIndicatorView = {
       let av = UIActivityIndicatorView()
        av.hidesWhenStopped = true
        return av
    }()
    
    private var searchBar: UISearchBar = {
       let sb = UISearchBar()
        sb.placeholder = "사진을 검색하세요."
        return sb
    }()
    
    private let cancelButton: UIBarButtonItem = {
        let cb = UIBarButtonItem(systemItem: .cancel)
        return cb
    }()
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        makeSearchBarInNavigationItem()
    }
    
    private func configureUI() {
        
    }
    
    private func makeSearchBarInNavigationItem() {
        cancelButton.primaryAction = UIAction(handler: { _ in
            self.searchBar.text = ""
        })
        self.navigationItem.rightBarButtonItem = cancelButton
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }
    
    func bind(reactor: PhotosReactor) {
      
        reactor.state.map { $0.isLoding }
        .distinctUntilChanged()
        .observe(on: MainScheduler.asyncInstance)
        .withUnretained(self)
        .bind(onNext: { owner, isLoding in
            isLoding ? owner.activityIndicator.startAnimating() : owner.activityIndicator.stopAnimating()
        })
        .disposed(by: disposeBag)
        
        searchBar.rx.searchButtonClicked
            .map { PhotosReactor.Action.searchButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        searchBar.rx.text.orEmpty
            .distinctUntilChanged()
            .map { Reactor.Action.inputQuery($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }


}

