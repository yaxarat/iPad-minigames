//
// Created by Yashar Atajan on 3/28/18.
// Copyright (c) 2018 Yaxiaer Atajiang. All rights reserved.
//

import Foundation

class coordinator {
    var row: Int?
    var column: Int?

    func clearPick() {
        self.row = nil
        self.column = nil
    }
}

class matched {
    var rowAndCol = [[Bool]]()

    init(sizeRow: Int, sizeCol: Int){
        for i in 0..<sizeRow {
            let arrayToAppend = [Bool](repeating: false, count: sizeCol)
            self.rowAndCol.append(arrayToAppend)
            print("\(rowAndCol[i])")
        }
    }

    func checkIfMatched() -> Bool {
        var answer = true
        for i in 0..<rowAndCol.count {
            for j in 0..<rowAndCol[0].count {
                if !rowAndCol[i][j]{
                    answer = false
                    return answer
                }
            }
        }
        return answer
    }
}