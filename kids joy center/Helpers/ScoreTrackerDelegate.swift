//
//  ScoreTrackerDelegate.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import Foundation

class ScoreTracker: NSObject, NSCoding  {
    var score: Int
    var game: String
    
    init(gameType: String, score: Int){
        self.game = gameType
        self.score = score
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(game, forKey: "Game")
        aCoder.encodeCInt(Int32(score), forKey: "Score")
    }
    
    required init?(coder aDecoder: NSCoder) {
        game = aDecoder.decodeObject(forKey: "Game") as! String
        score = aDecoder.decodeInteger(forKey:"Score")
    }
}
