//
//  FetchUser.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class FetchUser: NSObject {
    
    let fetchUserTask: FetchJSONTask
    
    init(fetchUserTask: FetchJSONTask = HttpFetchUserTask()) {
        self.fetchUserTask = fetchUserTask
    }
    
    func fetchUser(_ completion: @escaping (User?) -> ()) {
        DispatchQueue.global().async {
            self.fetchUserTask.fetch { (json) in
                completion(User(json: json))
            }
        }
    }
}
