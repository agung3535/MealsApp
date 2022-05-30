//
//  MealRepository.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation
import Combine
// aliran data dari network untuk di pakai ke presentation layer
// mapping ke model
protocol MealRepositoryProtocol {
//    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> ())
    func getCategories() -> AnyPublisher<[CategoryModel], Error>
}

// membuat instance yang akan dipakai di DI

final class MealRepository: NSObject {
    typealias MealInstance = (LocaleDataSource, RemoteDataSource) -> MealRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.remote = remote
        self.locale = locale
    }
    
    static let sharedInstance: MealInstance = { localRepo, remoteRepo in
        return MealRepository(locale: localRepo, remote: remoteRepo)
    }
}

extension MealRepository: MealRepositoryProtocol {
    func getCategories() -> AnyPublisher<[CategoryModel], Error> {
        return self.locale.getCategories()
            .flatMap { result -> AnyPublisher<[CategoryModel], Error> in
                if result.isEmpty {
                    return self.remote.getCategories()
                        .map { CategoryMapper.mapCategoryResponsesToEntity(input: $0)}
                        .flatMap {self.locale.addCategories(input: $0)}
                        .flatMap { _ in self.locale.getCategories()
                                .map { CategoryMapper.mapCategoryEntityToDomain(input: $0)}
                        }.eraseToAnyPublisher()
                }else {
                    return self.locale.getCategories()
                        .map { CategoryMapper.mapCategoryEntityToDomain(input: $0) }.eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
    
//    func getCategories(result: @escaping (Result<[CategoryModel], Error>) -> ()) {
//        locale.getCategories { localeResponses in
//            switch localeResponses {
//
//            case .success(let localCategory):
//                let categoryLocal = CategoryMapper.mapCategoryEntityToDomain(input: localCategory)
//                if categoryLocal.isEmpty {
//                    self.remote.getCategories { remoteResponse in
//                        switch remoteResponse {
//
//                        case .success(let remoteResult):
//                            let categoryRemoteToLocal = CategoryMapper.mapCategoryResponsesToEntity(input: remoteResult)
//                            self.locale.addCategories(input: categoryRemoteToLocal) { adState in
//                                switch adState {
//
//                                case .success(let resultAdd):
//                                    if resultAdd {
//                                        self.locale.getCategories { localeResponses in
//                                            switch localeResponses {
//
//                                            case .success(let categoryEntity):
//                                                let categoryDomain = CategoryMapper.mapCategoryEntityToDomain(input: categoryEntity)
//                                                result(.success(categoryDomain))
//                                            case .failure(let error):
//                                                result(.failure(error))
//                                            }
//                                        }
//                                    }
//                                case .failure(let error):
//                                    result(.failure(error))
//                                }
//                            }
//
//                        case .failure(let error):
//                            result(.failure(error))
//                        }
//                    }
//                }else {
//                    result(.success(categoryLocal))
//                }
//            case .failure(let error):
//                result(.failure(error))
//            }
//        }
//    }
    
    
}
