//
//  ImageWithOptionalURL.swift
//  Meditation
//

import SwiftUI
import Kingfisher

struct ImageWithOptionalURL: View {
  let url: String
  let defaultImage: Image
  var body: some View {
    if let url = URL(string: url) {
      KFImage(url)
        .resizable()
    } else {
      defaultImage
        .resizable()
    }
  }
  
}
