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
    for (key, _) in playersInfo {
        guard let info = playersInfo[key] else { continue }
        players.append(contentsOf: info.map { player in return player ?? ""})
    }
    players = players.compactMap {player in return player.count > 5 ? player : nil }.sorted(by: <)
    return players
}
