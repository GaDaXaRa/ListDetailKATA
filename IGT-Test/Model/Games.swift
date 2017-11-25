//
//  GameItem.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

struct Games {
    let currency: String
    let items: [GameItem]
    
    init?(json: [String: Any]?) {
        guard
            let json = json,
            let response = json["response"] as? String,
            response == "success",
            let currency = json["currency"] as? String,
            let data = json["data"] as? [[String: Any]]
            else {return nil}
        
        self.currency = currency
        self.items = data.flatMap{GameItem(json: $0)}
    }
}

struct GameItem {
    let name: String
    let jackpot: Int
    let date: Date
    
    init?(json: [String: Any]) {
        guard
            let name = json["name"] as? String,
            let jackpot = json["jackpot"] as? Int,
            let stringDate = json["date"] as? String,
            let date = DateFormatter.rfc3339Formatter().date(from: stringDate)
            else {return nil}
        
        self.name = name
        self.jackpot = jackpot
        self.date = date
    }
}


extension Games: Equatable {
    static func == (lhs: Games, rhs: Games) -> Bool {
        return lhs.currency == rhs.currency && lhs.items == rhs.items
    }
}

extension GameItem: Equatable {
    static func == (lhs: GameItem, rhs: GameItem) -> Bool {
        return lhs.name == rhs.name &&
            lhs.jackpot == rhs.jackpot &&
            lhs.date == rhs.date
    }
}
