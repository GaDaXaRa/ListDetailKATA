//
//  GamesListPresenter.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol Presenter {
    func viewDidLoad()
    func viewwillAppear()
    func viewDidAppear()
}

extension Presenter {
    func viewDidLoad() {}
    func viewwillAppear() {}
    func viewDidAppear() {}
}

protocol GamesListView: class {
    func reload()
}

class GamesListPresenter: NSObject {
    fileprivate let fetchGamesUseCase: FetchGames
    
    var model: Games? {
        didSet {
            view?.reload()
        }
    }
    weak var view: GamesListView?
    
    init(fetchGamesUseCase: FetchGames = FetchGames()) {
        self.fetchGamesUseCase = fetchGamesUseCase
    }
    
    func numGames() -> Int {
        guard let model = model else {return 0}
        return model.items.count
    }
    
    func game(at indexPath: IndexPath) -> GameItem {
        guard let games = model else {fatalError("Asking for not loaded games")}
        return games.items[indexPath.row]
    }
}

extension GamesListPresenter: Presenter {
    func viewDidLoad() {
        fetchGamesUseCase.fetchGames { (games) in
            guard let games = games else {return}
            self.model = games
        }
    }
}
