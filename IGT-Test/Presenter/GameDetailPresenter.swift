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
}

class GameDetailPresenter: NSObject {
    weak var view: GameDetailView? 
    
    let game: GameItem?
    
    init(game: GameItem?) {
        self.game = game
    }
}

extension GameDetailPresenter: Presenter {
    func viewWillAppear() {
        guard let game = game else {return}
        view?.configure(with: game)
    }
}
