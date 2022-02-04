//
//  User.swift
//  Meditation
//

import Foundation

struct UserDataToSend: Encodable {
  let email: String
  let password: String
}
