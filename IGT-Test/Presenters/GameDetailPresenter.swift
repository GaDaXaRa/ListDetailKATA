//
//  GameDetailPresenter.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol GameDetailView: class {
    func configure(with viewModel: GameDetailViewModel)
    func updateUser(_: UserHeaderViewModel)
}

class GameDetailPresenter: NSObject {
    weak var view: GameDetailView? 
    
    let game: GameItem?
    let user: User?
    
    init(game: GameItem?, user: User?) {
        self.game = game
        self.user = user
    }
}

extension GameDetailPresenter: Presenter {
    func viewWillAppear() {
        if let game = game {
            view?.configure(with: game)
        }
        
        if let user = user {
            view?.updateUser(user)
        }
    }
}
