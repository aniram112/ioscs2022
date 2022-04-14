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
    return playersInfo.values
        .flatMap({$0})
        .compactMap{$0}
        .filter {$0.count > 5} // вместо player in return player.count
        .sorted(by: <)
}
