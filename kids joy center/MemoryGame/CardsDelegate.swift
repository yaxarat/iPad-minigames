//
//  CardsDelegate.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import Foundation

class Cards {
    var arrayOfCards = [[Card]]()
    var difficulty: String
    
    init(difficulty:String){
        self.difficulty = difficulty
        setArrayOfCardsIndentifierAndImage()
    }
    
    
    func setArrayOfCardsIndentifierAndImage() {
        let identiferArray = setUpArrayOfCards()
        
        for i in 0..<identiferArray.count {
            var cardsToAppend = [Card]()
            for j in 0..<identiferArray[i].count {
                let newCard = Card()
                newCard.cardIdentifier = identiferArray[i][j]
                newCard.image = identiferArray[i][j] + 1
                cardsToAppend.append(newCard)
            }
            self.arrayOfCards.append(cardsToAppend)
        }
    }
    
    
    func setUpArrayOfCards() -> [[Int]] {
        var boardArray = [[Int]]()
        var uniqueNumbersArray = uniqueRandomNumbers()
        var randomNumberSize: UInt32
        var sizeOfBoard: Int
        var doubleTheRandomsInitializer: Int
        
        if self.difficulty == "Easy" {
            doubleTheRandomsInitializer = 6
            randomNumberSize = 6
            sizeOfBoard = 3
        } else if self.difficulty == "Medium" {
            doubleTheRandomsInitializer = 8
            randomNumberSize = 8
            sizeOfBoard = 4
        } else if self.difficulty == "Hard" {
            doubleTheRandomsInitializer = 10
            randomNumberSize = 10
            sizeOfBoard = 5
        } else {
            print("Error in setUpArrayOfCards")
            return boardArray
        }
        //array to let us know if more than two cards have been set up
        var doubleTheRandoms = [Int](repeating: 0, count: doubleTheRandomsInitializer)
        for _ in 0..<4 {
            var subArray = [Int]()
            for _ in 0..<sizeOfBoard {
                var r = Int(arc4random_uniform(arc4random_uniform(randomNumberSize)))
                if doubleTheRandoms[r] < 2 {
                    doubleTheRandoms[r] = doubleTheRandoms[r] + 1
                    subArray.append(uniqueNumbersArray[r])
                }
                else if doubleTheRandoms[r] == 2{
                    var chooseAppropriateValue = false
                    while !chooseAppropriateValue{
                        r = Int(arc4random_uniform(randomNumberSize))
                        if doubleTheRandoms[r] < 2 {
                            doubleTheRandoms[r] = doubleTheRandoms[r] + 1
                            subArray.append(uniqueNumbersArray[r])
                            chooseAppropriateValue = true
                        }
                    }
                }
            }
            boardArray.append(subArray)
        }
        print (boardArray)
        return boardArray
    }
    
    func uniqueRandomNumbers() -> [Int]{
        
        
        var uniqueArrayCheck = [Int?](repeating: nil, count: 10)
        var uniqueArray = [Int]()
        var numberOfRandoms: Int
        
        if self.difficulty == "Easy" {
            numberOfRandoms = 6
        } else if self.difficulty == "Medium" {
            numberOfRandoms = 8
        } else if self.difficulty == "Hard" {
            numberOfRandoms = 10
        } else {
            print("Error in function uniqueRandomNumbers")
            return uniqueArray
        }
        var count = 0
        while count < numberOfRandoms {
            let randomNumber = Int(arc4random_uniform(10))
            if uniqueArrayCheck[randomNumber] == nil {
                uniqueArrayCheck[randomNumber] = randomNumber
                uniqueArray.append(randomNumber)
                count = count + 1
            } else {
                continue
            }
        }
        return uniqueArray
    }
}
