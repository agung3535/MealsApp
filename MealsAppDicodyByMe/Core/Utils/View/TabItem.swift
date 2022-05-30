//
//  TabItem.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import SwiftUI

struct TabItem: View {

  var imageName: String
  var title: String
  var body: some View {
    VStack {
      Image(systemName: imageName)
      Text(title)
    }
  }

}
