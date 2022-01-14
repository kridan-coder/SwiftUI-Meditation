//
//  CustomButton.swift
//  Meditation
//
//  Created by Developer on 12.01.2022.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(minWidth: 0,
             maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
      .foregroundColor(.white)
      .background(Color("ButtonColor"))
      .cornerRadius(10)
      .font(.custom("Alegreya-Medium", size: 25))

  }
}

struct CustomButton: View {
    var body: some View {
      Button("Test") {}
        .frame(width: 200, height: 200)
        .buttonStyle(CustomButtonStyle())
    }
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
    }
}
