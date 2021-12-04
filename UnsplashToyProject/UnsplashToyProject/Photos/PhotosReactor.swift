//
//  PhotosReactor.swift
//  UnsplashToyProject
//
//  Created by 박형석 on 2021/12/04.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa

class PhotosReactor: Reactor {
    
    enum Action {
        case inputQuery(String)
        case searchButtonTapped
    }
    
    enum Mutation {
        case setQuery(String)
        case setPhotos([Photo])
        case setIsLoading(Bool)
    }
    
    struct State {
        var query = "car"
        var photos = [Photo]()
        var isLoding = false
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func transform(mutation: Observable<Mutation>) -> Observable<Mutation> {
        return Observable.merge(mutation)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .inputQuery(let text):
            return Observable.just(.setQuery(text))
        case .searchButtonTapped:
            let query = self.currentState.query
            return Observable.concat([
                Observable.just(.setIsLoading(true)),
                fetchPhotos(query: query).map { .setPhotos($0) },
                Observable.just(.setIsLoading(false))
            ])
        }
        
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setPhotos(let photos):
            newState.photos = photos
        case .setIsLoading(let isLoading):
            newState.isLoding = isLoading
        case .setQuery(let query):
            newState.query = query
        }
        return newState
    }
    
    private func fetchPhotos(query: String) -> Observable<[Photo]> {
        return Observable.just([])
    }
    
    
    
}
