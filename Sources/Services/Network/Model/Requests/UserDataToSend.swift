//
//  User.swift
//  Meditation
//
//  Created by Daniel Krivelev on 31.01.2022.
//

import Foundation

struct UserDataToSend: Encodable {
  let email: String
  let password: String
}
