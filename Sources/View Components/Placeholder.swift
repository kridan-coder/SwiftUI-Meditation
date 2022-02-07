//
//  Placeholder.swift
//  Meditation
//

import SwiftUI

extension View {
  func placeholderShowing<PlaceholderContent: View>(when shouldShow: Bool,
                                                    alignment: Alignment = .leading,
                                                    placeholder: @escaping () -> PlaceholderContent) -> some View {
    modifier(PlaceholderModifier(shouldShow: shouldShow, alignment: alignment, placeholder: placeholder))
  }
}

struct PlaceholderModifier<PlaceholderContent: View>: ViewModifier {
  var shouldShow: Bool
  let alignment: Alignment
  let placeholder: () -> PlaceholderContent
  
  func body(content: Content) -> some View {
    ZStack(alignment: alignment) {
      placeholder()
        .opacity(shouldShow ? 1 : 0)
      content
    }
  }
  
}
