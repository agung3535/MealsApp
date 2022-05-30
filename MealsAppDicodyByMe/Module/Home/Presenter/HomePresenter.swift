//
//  HomePresenter.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import SwiftUI
import Combine

class HomePresenter: ObservableObject {
    
    private let router = HomeRouter()
    private let homeUseCase: HomeUseCase
    @Published var categories: [CategoryModel] = []
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getCategories() {
        loadingState = true
        homeUseCase.getCategories()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {[weak self] completion in
                switch completion {
                    
                case .finished:
                    self?.loadingState = false
                case .failure(_):
                    self?.errorMessage = String(describing: completion)
                }
        }, receiveValue: {[weak self] data in
            self?.categories = data
        }).store(in: &cancellables)
//        homeUseCase.getCategories(completion: { result in
//            switch result {
//
//            case .success(let categories):
//                DispatchQueue.main.async {
//                    self.loadingState = false
//                    self.categories = categories
//                }
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.loadingState = false
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        })
    }
    
    func linkBuilder<Content: View>(
      for category: CategoryModel,
      @ViewBuilder content: () -> Content
    ) -> some View {
      NavigationLink(
        destination: router.makeDetailView(category: category)) { content() }
    }
}
