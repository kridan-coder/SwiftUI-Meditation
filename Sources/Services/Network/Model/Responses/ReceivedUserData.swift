//
//  User.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation

struct ReceivedUserData: Decodable {
  let id: String
  let email: String
  let nickName: String
  let avatar: String
  let token: String
}
