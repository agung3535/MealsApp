//
//  HomeInteractor.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation
import Combine

protocol HomeUseCase {
//    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> ())
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    
    
    private let repository: MealRepositoryProtocol
    
    required init(repository: MealRepositoryProtocol) {
        self.repository = repository
    }
    
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return repository.getCategories()
    }
    
//    func getCategories(completion: @escaping (Result<[CategoryModel], Error>) -> ()) {
//        repository.getCategories { result in
//            completion(result)
//        }
//    }
    
    
}
