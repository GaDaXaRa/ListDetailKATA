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

struct TimedCodableCache<T: Codable> {
    
    struct GamesAppointment: Codable {
        var date: Date
        var info: T
    }
    
    private let interval: TimeInterval
    private let persistence: CodableCachePersistence
    
    private var storedInfo: GamesAppointment? {
        return persistence.fetch() as? GamesAppointment
    }
    
    init(interval: TimeInterval = 60 * 60, persistence: CodableCachePersistence = DiskCodablePersistence<T>()) {
        self.interval = interval
        self.persistence = persistence
    }
    
    func store(info: T, at date: Date) {
        persistence.persist(GamesAppointment(date: date, info: info))
    }
    
    func fetch(at date: Date) -> T? {
        guard let storedInfo = storedInfo, storedInfo.date.addingTimeInterval(interval) > date else {return nil}
        return storedInfo.info
    }
}

extension TimedCodableCache: GamesCache {
    func store(games: Games) {
        guard let info = games as? T else {return}
        store(info: info, at: Date())
    }
    
    func fetch(_ completion: @escaping (Games?) -> ()) {
        guard let games = fetch(at: Date()) as? Games else {
            completion(nil)
            return
        }
        completion(games)
    }    
}
