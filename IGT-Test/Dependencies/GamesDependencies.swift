//
//  GamesDependencies.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class GamesDependencies: NSObject {
    
    private static let gamesListStoryboard = UIStoryboard(name: "GamesList", bundle: nil)
    private static let gameDetailStoryboard = UIStoryboard(name: "GameDetail", bundle: nil)
    
    static func gamesListViewController(wireframe: GamesWireframe) -> GamesListViewController {
        let viewController = GamesDependencies.gamesListStoryboard.instantiateViewController(withIdentifier: "GamesListViewController") as! GamesListViewController
        viewController.presenter = GamesListPresenter(wireframe: wireframe)
        return viewController
    }
    
    static func gameDetailViewController(for game: GameItem?, user: User?) -> GameDetailViewController {
        let viewController = GamesDependencies.gameDetailStoryboard.instantiateViewController(withIdentifier: "GameDetailViewController") as! GameDetailViewController
        viewController.presenter = GameDetailPresenter(game: game, user: user)
        return viewController
    }
}
