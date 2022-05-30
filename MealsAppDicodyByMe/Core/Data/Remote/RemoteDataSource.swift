//
//  RemoteDataSource.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation
import Alamofire
import Combine

protocol RemoteDataSourceProtocol {
    
//    func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void)
    func getCategories() -> AnyPublisher<[CategoryResponse], Error>
    
}

final class RemoteDataSource: NSObject {
    private override init() { }
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    func getCategories() -> AnyPublisher<[CategoryResponse], Error> {
        return Future<[CategoryResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.categories.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: CategoriesResponse.self, completionHandler: { response in
                        switch response.result {
                            
                        case .success(let value):
                            completion(.success(value.categories))
                        case .failure(_):
                            completion(.failure(URLError.invalidResponse))
                        }
                    })
            }
        }.eraseToAnyPublisher()
        
    }
    
//    func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void) {
//        guard let url = URL(string: Endpoints.Gets.categories.url) else { return }
//
//        AF.request(url).validate().responseDecodable(of: CategoriesResponse.self, completionHandler: { response in
//            switch response.result {
//
//            case .success(let data):
//                result(.success(data.categories))
//            case .failure(let error):
//                result(.failure(.invalidResponse))
//            }
//        })
//
//    }
    
//    func getCategories(result: @escaping (Result<[CategoryResponse], URLError>) -> Void) {
//        guard let url = URL(string: Endpoints.Gets.categories.url) else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { maybeData, maybeResponse, error in
//            if error != nil {
//                result(.failure(.addressUnreachable(url)))
//            } else if let data = maybeData, let response = maybeResponse as? HTTPURLResponse, response.statusCode == 200 {
//                let decoder = JSONDecoder()
//                do {
//                    let categories = try decoder.decode(CategoriesResponse.self, from: data).categories
//                    result(.success(categories))
//                } catch {
//                    result(.failure(.invalidResponse))
//                }
//            }
//        }.resume()
//    }
    
    
    
    
    
    
}
