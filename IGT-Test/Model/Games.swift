//
//  GameItem.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

struct Games: Codable {
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
        self.items = data.flatMap{GameItem(json: $0, currency: currency)}
    }
}

struct GameItem: Codable {
    let name: String
    let jackpot: Int
    let date: Date
    let currency: String
    
    init?(json: [String: Any], currency: String) {
        guard
            let name = json["name"] as? String,
            let jackpot = json["jackpot"] as? Int,
            let stringDate = json["date"] as? String,
            let date = DateFormatter.rfc3339Formatter.date(from: stringDate)
            else {return nil}
        
        self.name = name
        self.jackpot = jackpot
        self.date = date
        self.currency = currency
    }
}

extension GameItem: CollectioItemViewModel {
    var itemTitle: String {
        return name
    }
}

extension GameItem: GameDetailViewModel {
    var gameDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter.string(from: date)
    }
    
    var gameName: String {
        return name
    }
    
    var gameJackpot: String {
        guard let formattedJackpot = NumberFormatter.currencyFormatter(with: currency).string(for: jackpot) else {
            return "\(jackpot)"
        }
        return formattedJackpot
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
