//
//  DetailPage.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailPage: View {
    @ObservedObject var presenter: DetailPresenter

    var body: some View {
      ZStack {
        if presenter.loadingState {
          loadingIndicator
        } else {
          ScrollView(.vertical) {
            VStack {
              imageCategory
              spacer
              content
              spacer
            }.padding()
          }
        }
      }.navigationBarTitle(Text(self.presenter.category.title), displayMode: .large)
    }
}

extension DetailPage {
  var spacer: some View {
    Spacer()
  }

  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }

  var imageCategory: some View {
    WebImage(url: URL(string: self.presenter.category.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .scaledToFit()
      .frame(width: 250.0, height: 250.0, alignment: .center)
  }

  var description: some View {
    Text(self.presenter.category.description)
      .font(.system(size: 15))
  }

  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      headerTitle("Description")
        .padding([.top, .bottom])
      description
    }
  }
}

//struct DetailPage_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailPage()
//    }
//}
