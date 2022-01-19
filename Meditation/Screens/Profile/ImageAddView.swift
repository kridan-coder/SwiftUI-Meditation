//
//  ImageAddView.swift
//  Meditation
//
//  Created by Daniel Krivelev on 19.01.2022.
//

import SwiftUI

struct ImageAddView: View {
    var body: some View {
      ZStack {
        Color("AddColor")
          .ignoresSafeArea()
        Text("+")
          .foregroundColor(.white)
          .fontWeight(.medium)
          .font(.system(size: 50))
      }
      .cornerRadius(20)
      .aspectRatio(1.3, contentMode: .fit)
      .padding(8)

    }
}

struct ImageAddView_Previews: PreviewProvider {
    static var previews: some View {
        ImageAddView()
    }
}
