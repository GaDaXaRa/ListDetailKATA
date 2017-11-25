//
//  ShouldAskForGames.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class GamesCache: NSObject {

    struct GamesAppointment {
        var date: Date
        var games: Games
    }
    
    let interval: TimeInterval
    private var storedGames: GamesAppointment?
    
    init(interval: TimeInterval = 60 * 60) {
        self.interval = interval
    }
    
    func store(games: Games, at date: Date = Date()) {
        storedGames = GamesAppointment(date: date, games: games)
    }
    
    func fetch(at date: Date = Date()) -> Games? {
        guard let storedGames = storedGames, storedGames.date.addingTimeInterval(interval) > date else {return nil}
        return storedGames.games
    }
}
