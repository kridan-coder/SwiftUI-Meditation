//
//  Logger.swift
//  Meditation
//
//  Created by Daniel Krivelev on 30.01.2022.
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
  
  func debug(_ message: @autoclosure () -> Any,
             _ file: String = #file,
             _ function: String = #function,
             _ line: Int = #line) {
    SwiftyBeaver.debug(message(), file, function, line: line)
  }
  
}
