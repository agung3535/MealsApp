//
//  HomePage.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import SwiftUI

struct HomePage: View {
    
    @ObservedObject var presenter: HomePresenter
    
    var body: some View {
        
        ZStack {
            
            if presenter.loadingState {
                VStack {
                    Text("Loading...")
                    ActivityIndicator()
                }
            }else {
                
                if #available(iOS 14.0, *) {
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.categories,
                            id: \.id
                        ) { category in
                            ZStack {
                                self.presenter.linkBuilder(for: category) {
                                    CategoryRow(category: category)
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(8)
                        }
                    }.onAppear {
                        if self.presenter.categories.count == 0 {
                            self.presenter.getCategories()
                        }
                    }.navigationTitle("Meals App")
                } else {
                    // Fallback on earlier versions
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(
                            self.presenter.categories,
                            id: \.id
                        ) { category in
                            ZStack {
                                self.presenter.linkBuilder(for: category) {
                                    CategoryRow(category: category)
                                }.buttonStyle(PlainButtonStyle())
                            }.padding(8)
                        }
                    }.onAppear {
                        if self.presenter.categories.count == 0 {
                            self.presenter.getCategories()
                        }
                    }.navigationBarTitle(
                        Text("Meals Apps"), displayMode: .automatic
                    )
                }
            }
        }
    }
}

//struct HomePage_Previews: PreviewProvider {
//    static var previews: some View {
////        let Repopresenter = Injection.init().provideHome()
////        let presenter = HomePresenter(homeUseCase: Repopresenter)
////        HomePage(presenter: presenter)
//        HomePage()
//    }
//}
import SDWebImageSwiftUI

struct CategoryRow: View {

  var category: CategoryModel
  var body: some View {
    VStack {
      imageCategory
      content
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 250)
    .background(Color.random.opacity(0.3))
    .cornerRadius(30)
  }

}

extension CategoryRow {

  var imageCategory: some View {
    WebImage(url: URL(string: category.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 200)
      .cornerRadius(30)
      .padding(.top)
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text(category.title)
        .font(.title)
        .bold()
      
      Text(category.description)
        .font(.system(size: 14))
        .lineLimit(2)
    }.padding(
      EdgeInsets(
        top: 0,
        leading: 16,
        bottom: 16,
        trailing: 16
      )
    )
  }

}

//struct CategoryRow_Previews: PreviewProvider {
//
//  static var previews: some View {
//    let meal = CategoryModel(
//      id: "1",
//      title: "Beef",
//      image: "https://www.themealdb.com/images/category/beef.png",
//      description: "Beef is the culinary name for meat from cattle, particularly skeletal muscle."
//    )
//    return CategoryRow(category: meal)
//  }
//
//}
