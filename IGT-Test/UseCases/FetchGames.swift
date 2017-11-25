//
//  FetchGames.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol FetchGamesTask {
    func fetchGames(_ : @escaping ([String: Any]?) -> ())
}

protocol GamesCache {
    func store(games: Games)
    func fetch(_ completion: @escaping (Games?)->())
}

class FetchGames: NSObject {
    
    private let fetchGamesTask: FetchGamesTask
    private let cache: GamesCache
    
    init(fetchGamesTask: FetchGamesTask, cache: GamesCache = TimedCodableCache<Games>()) {
        self.fetchGamesTask = fetchGamesTask
        self.cache = cache
    }
    
    func fetchGames(_ completion: @escaping (Games?) -> ()) {
        cache.fetch { (games) in
            if let games = games {
                completion(games)
                return
            }
            self.fetchGamesTask.fetchGames { (json) in
                completion(Games(json: json))
            }
        }
    }
}
