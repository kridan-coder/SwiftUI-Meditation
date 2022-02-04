//
//  User.swift
//  Meditation
//

import Foundation

struct ReceivedUserData: Decodable {
  let id: String
  let email: String
  let nickName: String
  let avatar: URL
  let token: String
}
