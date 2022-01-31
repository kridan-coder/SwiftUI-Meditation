//
//  URLFactory.swift
//  Meditation
//

import Foundation

struct URLFactory {
  struct Quotes {
    static let getAllQuotes = "quotes"
  }
  
  struct Feelings {
    static let getAllFeelings = "feelings"
  }
  
  struct Auth {
    static let userBaseURL = "user/"
    static let login = userBaseURL + "login"
  }
  
}
