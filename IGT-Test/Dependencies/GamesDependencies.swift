//
//  GamesDependencies.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

class GamesDependencies: NSObject {
    
    private static let storyboard = UIStoryboard(name: "Games", bundle: nil)
    
    static func gamesListViewController() -> GamesListViewController {
        let viewController = GamesDependencies.storyboard.instantiateViewController(withIdentifier: "GamesListViewController") as! GamesListViewController
        viewController.presenter = GamesListPresenter()
        return viewController
    }
}
