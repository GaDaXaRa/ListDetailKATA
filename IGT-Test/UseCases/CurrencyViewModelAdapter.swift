//
//  CurrencyViewModelAdapter.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 26/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

struct CurrencyViewModelAdapter {
    fileprivate let viewModel: GameItem
    fileprivate let currencyCode: String
    fileprivate let userLocale: Locale
    fileprivate let numberFormatter = NumberFormatter()
    
    init(viewModel: GameItem, currencyCode: String, userLocale: Locale = Locale.current) {
        self.viewModel = viewModel
        self.currencyCode = currencyCode
        self.userLocale = userLocale
    }
}

extension CurrencyViewModelAdapter: GameDetailViewModel {
    var gameName: String {
        return viewModel.name
    }
    
    var gameJackpot: String {
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = currencyCode
        return numberFormatter.string(for: viewModel.jackpot)!
    }
    
    
}
