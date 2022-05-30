//
//  DetailPresenter.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation

class DetailPresenter: ObservableObject {
    private let detailUseCase: DetailUseCase
    @Published var category: CategoryModel
    @Published var errorMessage: String = ""
    @Published var loadingState: Bool = false
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
        category = detailUseCase.getCategory()
        
    }
}
