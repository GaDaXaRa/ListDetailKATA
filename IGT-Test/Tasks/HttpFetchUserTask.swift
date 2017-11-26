//
//  HttpFetchUserTask.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

struct HttpFetchUserTask: FetchJSONTask {
    private let url = URL(string: "https://dl.dropboxusercontent.com/s/5zz3hibrxpspoe5/playerInfo.json")!
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(_ completion: @escaping ([String : Any]?) -> ()) {
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
