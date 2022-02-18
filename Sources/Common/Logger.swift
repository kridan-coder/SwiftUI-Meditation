//
//  Logger.swift
//  Meditation
//

import Foundation
import SwiftyBeaver

let log = Logger()

struct Logger {
  init?() {
    guard Constants.enableLoggingToConsole else { return nil }
    let console = ConsoleDestination()
    console.format = "$M"
    SwiftyBeaver.addDestination(console)
  }
  
  func error(_ message: @autoclosure () -> Any,
             _ file: String = #file,
             _ function: String = #function,
             _ line: Int = #line) {
    SwiftyBeaver.error(message(), file, function, line: line)
  }
  
  func debug(_ message: @autoclosure () -> Any,
             _ file: String = #file,
             _ function: String = #function,
             _ line: Int = #line) {
    SwiftyBeaver.debug(message(), file, function, line: line)
  }
  
}
