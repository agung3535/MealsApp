//
//  ActivityIndicator.swift
//  MealsAppDicodyByMe
//
//  Created by Putra on 29/05/22.
//

import Foundation
import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(
      context: UIViewRepresentableContext<ActivityIndicator>
    ) -> UIActivityIndicatorView {
      return UIActivityIndicatorView(style: .large)
    }
    
    func updateUIView(
      _ uiView: UIActivityIndicatorView,
      context: UIViewRepresentableContext<ActivityIndicator>
    ) {
      uiView.startAnimating()
    }
}
