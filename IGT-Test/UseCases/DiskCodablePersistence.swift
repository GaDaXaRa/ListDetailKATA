//
//  DiskCodableStorage.swift
//  IGT-Test
//
//  Created by Miguel Santiago Rodríguez on 25/11/17.
//  Copyright © 2017 Miguel Santiago Rodríguez. All rights reserved.
//

import UIKit

struct DiskCodablePersistence<T: Codable>: NSObject {
    
    private let fileName: String
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let fileManager: FileManager
    
    private var gamesLocation: URL {
        guard let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {fatalError("could not open documents folder")}
        return documentsUrl.appendingPathComponent(fileName)
    }
    
    init(fileManager: FileManager = FileManager.default, fileName: String = "games.json", encoder: JSONEncoder = JSONEncoder(), decoder: JSONDecoder = JSONDecoder()) {
        self.fileName = fileName
        self.encoder = encoder
        self.decoder = decoder
        self.fileManager = fileManager
    }
    
    func persist(_ info: T) {
        do {
            try encoder.encode(info).write(to: gamesLocation)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func fetch() -> T? {
        do {
            return try decoder.decode(T.self, from: Data(contentsOf: gamesLocation))
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension DiskCodablePersistence: CodableCachePersistence {
    func persist(_ info: Codable) {
        guard let info = info as? T else {return}
        self.persist(info)
    }
    
    func fetch() -> Codable? {
        guard let info: T = self.fetch() else {return nil}
        return info
    }
}
