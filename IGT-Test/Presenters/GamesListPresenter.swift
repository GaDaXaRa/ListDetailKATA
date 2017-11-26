//
//  GamesListPresenter.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

protocol GamesWireframe {
    func openDetail(with game: GameItem, user: User?)
}

protocol Presenter {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

extension Presenter {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
}

protocol GamesListView: class {
    func reload()
}

class GamesListPresenter: NSObject {
    fileprivate let fetchGamesUseCase: FetchGames
    fileprivate let fetchUserUseCase: FetchUser
    fileprivate let wireframe: GamesWireframe?
    
    var model: Games? {
        didSet {
            view?.reload()
        }
    }
    
    var user: User?
    
    weak var view: GamesListView?
    
    init(fetchGamesUseCase: FetchGames = FetchGames(), fetchUserUseCase: FetchUser = FetchUser(), wireframe: GamesWireframe?) {
        self.fetchGamesUseCase = fetchGamesUseCase
        self.fetchUserUseCase = fetchUserUseCase
        self.wireframe = wireframe
    }
    
    func numGames() -> Int {
        guard let model = model else {return 0}
        return model.items.count
    }
    
    func game(at indexPath: IndexPath) -> GameItem {
        guard let games = model else {fatalError("Asking for not loaded games")}
        return games.items[indexPath.row]
    }
    
    func didSelect(at indexPath: IndexPath) {
        guard let games = model else {return}
        wireframe?.openDetail(with: games.items[indexPath.row], user: user)
    }
    
    private func fetchGames() {
        fetchGamesUseCase.fetchGames { (games) in
            self.model = games
        }
    }
    
    private func fetchUser() {
        fetchUserUseCase.fetchUser { (user) in
            self.user = user
        }
    }
}

extension GamesListPresenter: Presenter {
    func viewDidLoad() {
        fetchGames()
        fetchUser()
    }
}
