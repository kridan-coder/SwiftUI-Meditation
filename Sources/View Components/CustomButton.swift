//
//  CustomButton.swift
//  Meditation
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .font(.mediumTitle2)
      .background(Color.buttonColor)
      .cornerRadius(10)
  }
  
}

struct CustomButtonView: View {
  var text: String
  var textColor: Color = .white
  var backgroundColor: Color = Color.buttonColor
  var cornerRadius: CGFloat = 10
  var font: Font = .mediumTitle2
  var body: some View {
    GeometryReader { view in
      Text(text)
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
    CustomButtonView(text: "Press!")
      .frame(width: 200, height: 50)
  }
}
