//
//  FetchGamesTask.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import Foundation

struct HttpFetchGamesTask: FetchGamesTask {
    private let url = URL(string: "https://dl.dropboxusercontent.com/s/2ewt6r22zo4qwgx/gameData.json")!
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetchGames(_ completion: @escaping ([String : Any]?) -> ()) {
        session.dataTask(with: url) { (data, response, error) in
            guard
                let data = data, error == nil, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(nil)
                return
            }
            completion(json)
        }.resume()
    }
}
