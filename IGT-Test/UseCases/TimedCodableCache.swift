//
//  ShouldAskForGames.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol CodableCachePersistence {
    func persist(_ :Codable)
    func fetch() -> Codable?
}

class TimedCodableCache: NSObject {
    
    struct GamesAppointment: Codable {
        var date: Date
        var games: Games
    }
    
    let interval: TimeInterval
    let persistence: CodableCachePersistence
    
    private var inMemoryGames: GamesAppointment?
    
    private var storedGames: GamesAppointment? {
        if let inMemoryGames = inMemoryGames {return inMemoryGames}
        return persistence.fetch() as? GamesAppointment
    }
    
    init(interval: TimeInterval = 60 * 60, persistence: CodableCachePersistence) {
        self.interval = interval
        self.persistence = persistence
    }
    
    func store(games: Games, at date: Date) {
        inMemoryGames = GamesAppointment(date: date, games: games)
        persistence.persist(inMemoryGames)
    }
    
    func fetch(at date: Date) -> Games? {
        guard let storedGames = storedGames, storedGames.date.addingTimeInterval(interval) > date else {return nil}
        return storedGames.games
    }
}

extension TimedCodableCache: GamesCache {
    func store(games: Games) {
        store(games: games, at: Date())
    }
    
    func fetch(_ completion: @escaping (Games?) -> ()) {
        completion(fetch(at: Date()))
    }    
}
