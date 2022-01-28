//
//  Placeholder.swift
//  Meditation
//
//  Created by Developer on 13.01.2022.
//

import SwiftUI

extension View {
  func placeholder<Content: View>(when shouldShow: Bool, alignment: Alignment = .leading, placeholder: () -> Content) -> some View {
    ZStack(alignment: alignment) {
      placeholder()
        .opacity(shouldShow ? 1 : 0)
      self
    }
  }
}
