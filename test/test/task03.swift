//
//  task03.swift
//  test
//
//  Created by Marina Roshchupkina on 05.04.2022.
//

import Foundation
let info = [
    "Chelsea": ["Kante", "Lukaku", "Werner"],
    "PSG": ["Messi", "Neymar", "Mbappe"],
    "Manchester City": ["Grealish", nil, "Sterling"]
]

func bestPlayers(from playersInfo: [String: [String?]]) -> [String] {
    var players: [String] = []
    for info in playersInfo.values {
        players.append(contentsOf: info.compactMap{$0})
    }
    return players.compactMap {player in return player.count > 5 ? player : nil }.sorted(by: <)
}
