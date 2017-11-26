//
//  FetchGames.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol FetchJSONTask {
    func fetch(_ : @escaping ([String: Any]?) -> ())
}

protocol GamesCache {
    func store(games: Games)
    func fetch(_ completion: @escaping (Games?)->())
}

class FetchGames: NSObject {
    
    private let fetchGamesTask: FetchJSONTask
    private let cache: GamesCache
    
    init(fetchGamesTask: FetchJSONTask = HttpFetchGamesTask(), cache: GamesCache = TimedCodableCache<Games>()) {
        self.fetchGamesTask = fetchGamesTask
        self.cache = cache
    }
    
    func fetchGames(_ completion: @escaping (Games?) -> ()) {
        DispatchQueue.global().async {
            self.cache.fetch { (games) in
                if let games = games {
                    completion(games)
                    return
                }
                self.fetchGamesTask.fetch { (json) in
                    guard let games = Games(json: json) else {
                        completion(nil)
                        return
                    }
                    self.cache.store(games: games)
                    completion(games)
                }
            }
        }        
    }
}
