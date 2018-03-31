//
//  MemoryGameVC.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class MemoryGameVC: UIViewController {

    let seconds = UIImageView(frame: CGRect(x: 180, y: 80, width: 20, height: 30))
    let seconds1 = UIImageView(frame: CGRect(x: 210, y: 80, width: 20, height: 30))
    let minutes = UIImageView(frame: CGRect(x: 140, y: 80, width: 20, height: 30))
    let score = UIImageView(frame: CGRect(x: 925, y: 80, width: 20, height: 30))
    let score1 = UIImageView(frame: CGRect(x: 955, y: 80, width: 20, height: 30))

    var thisDifficulty = GameSelector()
    var initBoard = Cards(difficulty: "")
    var match = matched(sizeRow: 0, sizeCol: 0)
    var cardsArray = [[UIButton]]()
    var pick = coordinator()
    var time = Time(seconds: 0)
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0
    var highScoreList: [[ScoreTracker]]!
    var tempScore: [ScoreTracker]!

    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }

    // Determine the correct count down timer for the level
    func setUpTimer() -> Time {
        var gameTime: Time

        if thisDifficulty.difficulty == "Easy"{
            gameTime = Time(seconds: 120)
        } else if thisDifficulty.difficulty == "Medium"{
            gameTime = Time(seconds: 105)
        } else {
            gameTime = Time(seconds: 90)
        }
        return gameTime
    }

    // Starts game
    func startGame() {
        tempScore = highScoreList[0]
        time = setUpTimer()
        time.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoryGameVC.syncDigits)), userInfo: nil, repeats: true)
        initBoard = Cards(difficulty: thisDifficulty.difficulty!)
        spawnBoard()
        timerUI()
        scoreUI()
    }

    // Update countdown digit images
    @objc func syncDigits(){

        if time.seconds > 0 {
            time.updateImages(time: TimeInterval(time.seconds))
            minutes.image = time.minutesImg
            seconds.image = time.secondsImg
            seconds1.image = time.seconds1Img
            time.seconds = time.seconds - 1
        } else {
            time.updateImages(time: TimeInterval(time.seconds))
            seconds1.image = time.seconds1Img
            time.timer.invalidate()
            loss()
        }
    }

    // Spawns the board
    func spawnBoard(){
        // Background
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named: "background")!
        self.view.addSubview(background)

        // Foreground
        let foreground = UIView(frame: CGRect(x: 100, y: 150, width: 800, height: 550))
        self.view.addSubview(foreground)
        cardUI(board: foreground)
    }

    // Creat the board setup with cards
    func cardUI(board: UIView) {
        let row = initBoard.arrayOfCards.count
        let col = initBoard.arrayOfCards[0].count
        var newButtonArray = [[UIButton]]()
        matchedCards(row: row, col: col)

        for i in 0..<row {
            var singleButtonRow = [UIButton]()

            for j in 0..<col {
                var card: UIButton
                if thisDifficulty.difficulty == "Easy" {
                    card = UIButton(frame: CGRect(x: 198 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else if thisDifficulty.difficulty == "Medium" {
                    card = UIButton(frame: CGRect(x: 133 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else {
                    card = UIButton(frame: CGRect(x: 67 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                }

                card.setBackgroundImage(UIImage(named: "question"), for: .normal)
                card.contentMode = .scaleAspectFill
                card.addTarget(self, action: #selector(flip), for: .touchUpInside)
                singleButtonRow.append(card)
                board.addSubview(card)
            }
            newButtonArray.append(singleButtonRow)
        }
        cardsArray = newButtonArray
    }

    func matchedCards(row: Int, col: Int) {
        let make = matched(sizeRow: row, sizeCol: col)
        match = make
    }

    @objc func flip(sender: UIButton) {
        let row = initBoard.arrayOfCards.count
        let col = initBoard.arrayOfCards[0].count

        for i in 0..<row {
            for j in 0..<col {
                if sender == cardsArray[i][j] {
                    if match.rowAndCol[i][j] {
                        return
                    }
                    if !(scoreTimer.isValid) {
                        startScoreTimer()
                    }
                    sender.setBackgroundImage(UIImage(named: "\(initBoard.arrayOfCards[i][j].image!)"), for: .normal)
                    checkMatch(row: i, col: j)
                }
            }
        }
    }

    func startScoreTimer() {
        scoreSeconds = 0
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoryGameVC.updateScoreTime)), userInfo: nil, repeats: true)
    }

    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
    }

    // Countdown Timer interface
    func timerUI() {
        let timeSpace = UIImageView(frame: CGRect(x: 40, y: 80, width: 50, height: 30))
        timeSpace.contentMode = .scaleAspectFill
        timeSpace.image = UIImage(named: "time")!
        self.view.addSubview(timeSpace)

        minutes.contentMode = .scaleAspectFill
        minutes.image = time.minutesImg
        self.view.addSubview(minutes)

        seconds.contentMode = .scaleAspectFill
        seconds.image = time.secondsImg
        self.view.addSubview(seconds)

        seconds1.contentMode = .scaleAspectFill
        seconds1.image = time.seconds1Img
        self.view.addSubview(seconds1)
    }

    // Score Interface
    func scoreUI(){
        let scoreSpace = UIImageView(frame: CGRect(x: 800, y: 80, width: 80, height: 30))
        scoreSpace.contentMode = .scaleAspectFill
        scoreSpace.image = UIImage(named: "score")
        self.view.addSubview(scoreSpace)

        score.contentMode = .scaleAspectFill
        score1.contentMode = .scaleAspectFill
        score.image = numberImageArray[finalScore / 10]
        score1.image = numberImageArray[finalScore % 10]
        self.view.addSubview(score)
        self.view.addSubview(score1)
    }

    // Check if the picked card is a match
    func checkMatch(row: Int, col: Int) {
        let lastPick = coordinator()
        lastPick.row = row
        lastPick.column = col
        let matchRow = pick.row
        let matchCol = pick.column

        if pick.row == nil || (pick.row == row && pick.column == col){
            pick = lastPick
            return
        } else if initBoard.arrayOfCards[matchRow!][matchCol!].cardIdentifier == initBoard.arrayOfCards[row][col].cardIdentifier{
            itMatched(row: matchRow!, col: matchCol!, row2: row, col2: col)
            calculateScore()
            updateScoreImage()
            scoreTimer.invalidate()
            pick.clearPick()
            isDone()
        } else {
            cardsArray[matchRow!][matchCol!].setBackgroundImage(UIImage(named: "question"), for: .normal)
            cardsArray[row][col].setBackgroundImage(UIImage(named: "question"), for: .normal)
            pick.clearPick()
            return
        }
    }

    func itMatched(row: Int, col: Int, row2: Int, col2: Int){
        match.rowAndCol[row][col] = true
        match.rowAndCol[row2][col2] = true
    }

    func calculateScore() {
        if scoreSeconds <= 3 {
            finalScore += 5
        } else if scoreSeconds > 3 && scoreSeconds <= 7 {
            finalScore += 4
        } else {
            finalScore += 3
        }
    }

    func updateScoreImage() {
        score.image = numberImageArray[finalScore / 10]
        score1.image = numberImageArray[finalScore % 10]
    }

    func isDone() {
        if match.checkIfDone() {
            time.timer.invalidate()
            checkHighScores()
            win()
        }
    }

    func checkHighScores() {
        let potentialHS = ScoreTracker(gameType: "Memory", score: finalScore)

        for i in 0..<tempScore.count {
            if tempScore[i].score < finalScore {
                tempScore.insert(potentialHS, at: i)
                tempScore.remove(at: 5)
                highScoreList[0] = tempScore
                ScoreTracker.syncScoreBoard(highScoreList)
                return
            }
        }
    }

    func win() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.winAlert()
    }
    
    func loss() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.loseAlert()
    }
}