//
//  Font+AppFonts.swift
//  Meditation
//
//  Created by Daniel Krivelev on 02.02.2022.
//

import SwiftUI

extension Font {
  static let regularSubheadline = alegreyaRegularFont(of: 16)
  static let regularBody = alegreyaRegularFont(of: 20)
  static let regularTitle3 = alegreyaRegularFont(of: 24)
  static let regularTitle2 = alegreyaRegularFont(of: 26)
  static let regularTitle1 = alegreyaRegularFont(of: 28)
  static let regularLargeTitle1 = alegreyaRegularFont(of: 35)
  static let regularLargeTitle2 = alegreyaRegularFont(of: 40)
  
  static let mediumSubheadline = alegreyaMediumFont(of: 16)
  static let mediumBody = alegreyaMediumFont(of: 20)
  static let mediumTitle3 = alegreyaMediumFont(of: 24)
  static let mediumTitle2 = alegreyaMediumFont(of: 26)
  static let mediumTitle1 = alegreyaMediumFont(of: 28)
  static let mediumLargeTitle1 = alegreyaMediumFont(of: 35)
  static let mediumLargeTitle2 = alegreyaMediumFont(of: 40)
  
  static let boldSubheadline = alegreyaBoldFont(of: 16)
  static let boldBody = alegreyaBoldFont(of: 20)
  static let boldTitle3 = alegreyaBoldFont(of: 24)
  static let boldTitle2 = alegreyaBoldFont(of: 26)
  static let boldTitle1 = alegreyaBoldFont(of: 28)
  static let boldLargeTitle1 = alegreyaBoldFont(of: 35)
  static let boldLargeTitle2 = alegreyaBoldFont(of: 40)
  
  private static func alegreyaRegularFont(of size: CGFloat) -> Font {
    Font.custom("Alegreya-Regular", size: size)
  }
  
  private static func alegreyaMediumFont(of size: CGFloat) -> Font {
    Font.custom("Alegreya-Medium", size: size)
  }
  
  private static func alegreyaBoldFont(of size: CGFloat) -> Font {
    Font.custom("Alegreya-Bold", size: size)
  }
  
}
