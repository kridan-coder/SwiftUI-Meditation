//
//  UserDataStoring.swift
//  Meditation
//
//  Created by Daniel Krivelev on 01.02.2022.
//

import Foundation

protocol UserDataStoring: AnyObject {
  var accessToken: String? { get set }
  var nickname: String? { get set }
  var email: String? { get set }
  var avatarURL: String? { get set }
  var isLoggedIn: Bool { get }
  var hadFirstRunAlready: Bool { get set }
}
