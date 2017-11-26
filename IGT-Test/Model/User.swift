//
//  User.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let balance: Double
    let avatarURL: URL?
    let lastLoginDate: Date?
    
    init?(json: [String: Any]?) {
        guard
            let json = json,
            let name = json["name"] as? String,
            let balance = json["balance"] as? Double
        else {
            return nil
        }
        
        self.name = name
        self.balance = balance
        if let avatarLink = json["avatarLink"] as? String, let avatarUrl = URL(string: avatarLink) {
            self.avatarURL = avatarUrl
        } else {
            self.avatarURL = nil
        }
        
        if let lastLogin = json["lastLogindate"] as? String, let lastLoginDate = DateFormatter.loginFormatter.date(from: lastLogin) {
            self.lastLoginDate = lastLoginDate
        } else {
            self.lastLoginDate = nil
        }
    }
}

extension User: UserHeaderViewModel {
    var userName: String {
        return name
    }
    
    var userBounty: String {
        return "\(balance)"
    }
    
    var userAvatarUrl: URL? {
        return avatarURL
    }
    
    
}
