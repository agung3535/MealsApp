//
//  HomeRouter.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation
import SwiftUI

class HomeRouter {
    func makeDetailView(category: CategoryModel) -> some View {
        let detailUseCase = Injection.init().provideDetail(category: category)
        let presenter = DetailPresenter(detailUseCase: detailUseCase)
        return DetailPage(presenter: presenter)
    }
}
