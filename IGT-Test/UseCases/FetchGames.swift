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

class FetchGames: NSObject {
    
    let fetchGamesTask: FetchGamesTask
    
    init(fetchGamesTask: FetchGamesTask) {
        self.fetchGamesTask = fetchGamesTask
    }
    
    func fetchGames(_ completion: @escaping (Games?) -> ()) {
        fetchGamesTask.fetchGames { (json) in
            completion(Games(json: json))
        }
    }

}
