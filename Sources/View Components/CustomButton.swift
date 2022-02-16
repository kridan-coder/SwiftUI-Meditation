//
//  CustomButton.swift
//  Meditation
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  var textColor: Color = .white
  var backgroundColor: Color = Color.buttonColor
  var cornerRadius: CGFloat = 10
  var font: Font = .mediumTitle2
  func makeBody(configuration: Configuration) -> some View {
    GeometryReader { view in
      configuration.label
        .foregroundColor(textColor)
        .font(font)
        .frame(width: view.size.width, height: view.size.height)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
    }
  }
}

struct CustomButton_Previews: PreviewProvider {
  static var previews: some View {
    Button("Press!") {}
    .buttonStyle(CustomButtonStyle())
    .frame(width: 200, height: 50)
  }
}
