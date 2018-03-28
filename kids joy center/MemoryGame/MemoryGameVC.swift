//
//  MemoryGameVC.swift
//  kids joy center
//
//  Created by Yashar Atajan on 3/27/18.
//  Copyright © 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class MemoryGameVC: UIViewController {
    
    class MatchCoordinates {
        var row: Int?
        var column: Int?
        
        func clearCoordinates() {
            self.row = nil
            self.column = nil
        }
    }
    
    class AlreadySolved {
        var rowAndCol = [[Bool]]()
        
        init(sizeRow: Int, sizeCol: Int){
            for i in 0..<sizeRow {
                let arrayToAppend = [Bool](repeating: false, count: sizeCol)
                self.rowAndCol.append(arrayToAppend)
                print("\(rowAndCol[i])")
            }
        }
        
        func checkSolved() -> Bool {
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
    
    var solved = AlreadySolved(sizeRow: 0, sizeCol: 0)
    var difficulty = GameSelector()
    var createBoardValues = Cards(difficulty: "")
    var buttonArray = [[UIButton]]()
    var possibleMatch = MatchCoordinates()
    var time = Time(seconds: 0)
    
    let minutes = UIImageView(frame: CGRect(x:140, y:75, width: 20, height: 30))
    let seconds = UIImageView(frame: CGRect(x:180, y:75, width: 20, height: 30))
    let seconds2 = UIImageView(frame: CGRect(x:210, y:75, width: 20, height: 30))
    let score1Img = UIImageView(frame: CGRect(x:895, y:75, width: 20, height: 30))
    let score2Img = UIImageView(frame: CGRect(x:925, y:75, width: 20, height: 30))
    
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0
    var highScoreList: [[ScoreTracker]]!
    var memHighScore: [ScoreTracker]!
    
    let numberImageArray: [UIImage] = [
        UIImage(named: "cartoon-number-0")!,
        UIImage(named: "cartoon-number-1")!,
        UIImage(named: "cartoon-number-2")!,
        UIImage(named: "cartoon-number-3")!,
        UIImage(named: "cartoon-number-4")!,
        UIImage(named: "cartoon-number-5")!,
        UIImage(named: "cartoon-number-6")!,
        UIImage(named: "cartoon-number-7")!,
        UIImage(named: "cartoon-number-8")!,
        UIImage(named: "cartoon-number-9")!,
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScore = 0
        memHighScore = highScoreList[0]
        startTime()
        createBoardValues = Cards(difficulty: difficulty.difficulty!)
        buildBackground()
        buildBoardView()
        timeUI()
        scoreUI()
        print("\(solved.checkSolved())")
        
        
    }
    
    func startTime() {
        time = setUpTimer()
        time.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoryGameVC.updateTimeImages)), userInfo: nil, repeats: true)
    }
    
    func startScoreTimer() {
        scoreSeconds = 0
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoryGameVC.updateScoreTime)), userInfo: nil, repeats: true)
    }
    
    
    func setUpTimer() -> Time {
        var ourTime: Time
        if difficulty.difficulty == "Easy"{
            ourTime = Time(seconds: 120)
        } else if difficulty.difficulty == "Medium"{
            ourTime = Time(seconds: 105)
        } else {
            ourTime = Time(seconds:90)
        }
        return ourTime
    }
    
    //create background image
    func buildBackground(){
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        background.contentMode = .scaleAspectFill
        let backgroundImg = UIImage(named: "background")!
        background.image = backgroundImg
        self.view.addSubview(background)
    }
    
    
    //build view for cards
    func buildBoardView() {
        let boardSpace = UIView(frame: CGRect(x: 106, y: 150, width: 800, height: 550))
        self.view.addSubview(boardSpace)
        individualCardsUI(board: boardSpace)
    }
    
    
    //create time ui
    func timeUI() {
        let timeSpace = UIImageView(frame: CGRect(x: 50,y: 75,width: 50,height: 30 ))
        timeSpace.contentMode = .scaleAspectFill
        let image : UIImage = UIImage(named: "time")!
        timeSpace.image = image
        self.view.addSubview(timeSpace)
        
        minutes.contentMode = .scaleAspectFill
        minutes.image = time.minutesImg
        self.view.addSubview(minutes)
        
        seconds.contentMode = .scaleAspectFill
        seconds.image = time.secondsImg
        self.view.addSubview(seconds)
        
        seconds2.contentMode = .scaleAspectFill
        seconds2.image = time.seconds1Img
        self.view.addSubview(seconds2)
        
    }
    
    // creates score ui
    func scoreUI(){
        let scoreSpace = UIImageView(frame: CGRect(x:775, y: 75, width: 80, height: 30))
        scoreSpace.contentMode = .scaleAspectFill
        scoreSpace.image = UIImage(named:"score")
        self.view.addSubview(scoreSpace)
        
        score1Img.contentMode = .scaleAspectFill
        score2Img.contentMode = .scaleAspectFill
        
        
        score1Img.image = numberImageArray[finalScore / 10]
        score2Img.image = numberImageArray[finalScore % 10]
        self.view.addSubview(score1Img)
        self.view.addSubview(score2Img)
        
    }
    
    //update numbers based on time
    @objc func updateTimeImages(){
        if time.seconds > 0 {
            
            print(time.formatedTime(time: TimeInterval(time.seconds)))
            time.updateImages(time: TimeInterval(time.seconds))
            minutes.image = time.minutesImg
            seconds.image = time.secondsImg
            seconds2.image = time.seconds1Img
            time.seconds = time.seconds - 1
            
        }
        else {
            time.updateImages(time: TimeInterval(time.seconds))
            seconds2.image = time.seconds1Img
            time.timer.invalidate()
            presentLossAlert()
        }
    }
    
    func presentWinAlert() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.presentWinAlert()
    }
    
    func presentLossAlert() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.endTimeAlert()
    }
    
    
    
    // create all of the cards
    func individualCardsUI(board: UIView) {
        let row = createBoardValues.arrayOfCards.count
        let col = createBoardValues.arrayOfCards[0].count
        var newButtonArray = [[UIButton]]()
        initSolvedArray(row: row, col: col)
        for i in 0..<row {
            var singleButtonRow = [UIButton]()
            for j in 0..<col {
                var card: UIButton
                if difficulty.difficulty == "Easy" {
                    card = UIButton(frame: CGRect(x: 198 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else if difficulty.difficulty == "Medium" {
                    card = UIButton(frame: CGRect(x: 133 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else if difficulty.difficulty == "Hard" {
                    card = UIButton(frame: CGRect(x: 67 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else {
                    print("Error in individualCardsUI")
                    return
                }
                card.setBackgroundImage(UIImage(named: "question"), for: .normal)
                card.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
                singleButtonRow.append(card)
                board.addSubview(card)
            }
            newButtonArray.append(singleButtonRow)
        }
        buttonArray = newButtonArray
    }
    
    
    @objc func flipCard(sender: UIButton) {
        let row = createBoardValues.arrayOfCards.count
        let col = createBoardValues.arrayOfCards[0].count
        
        for i in 0..<row {
            for j in 0..<col {
                if sender == buttonArray[i][j] {
                    if solved.rowAndCol[i][j] {
                        return
                    }
                    if !(scoreTimer.isValid) {
                        startScoreTimer()
                    }
                    sender.setBackgroundImage(UIImage(named: "\(createBoardValues.arrayOfCards[i][j].image!)"), for: .normal)
                    checkMatch(row: i, col: j)
                }
            }
        }
    }
    
    func checkMatch(row: Int, col: Int) {
        let storeCoordinates = MatchCoordinates()
        storeCoordinates.row = row
        storeCoordinates.column = col
        if possibleMatch.row == nil || (possibleMatch.row == row && possibleMatch.column == col){
            possibleMatch = storeCoordinates
            return
        }
        else {
            let matchRow = possibleMatch.row
            let matchCol = possibleMatch.column
            if createBoardValues.arrayOfCards[matchRow!][matchCol!].cardIdentifier == createBoardValues.arrayOfCards[row][col].cardIdentifier {
                updateSolved(row: matchRow!, col: matchCol!, row2: row, col2: col)
                produceScore()
                updateScoreImage()
                scoreTimer.invalidate()
                possibleMatch.clearCoordinates()
                if solved.checkSolved() {
                    time.timer.invalidate()
                    checkHighScores()
                    presentWinAlert()
                }
                return
            } else {
                buttonArray[matchRow!][matchCol!].setBackgroundImage(UIImage(named:"question"), for: .normal)
                buttonArray[row][col].setBackgroundImage(UIImage(named:"question"), for: .normal)
                possibleMatch.clearCoordinates()
                return
            }
        }
    }
    
    
    func initSolvedArray(row: Int, col: Int) {
        let make = AlreadySolved(sizeRow: row, sizeCol: col)
        solved = make
    }
    
    func updateSolved(row: Int, col: Int, row2: Int, col2: Int){
        solved.rowAndCol[row][col] = true
        solved.rowAndCol[row2][col2] = true
    }
    
    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
    }
    
    func produceScore() {
        if scoreSeconds <= 3 {
            finalScore += 5
        } else if scoreSeconds > 3 && scoreSeconds <= 7 {
            finalScore += 4
        } else {
            finalScore += 3
        }
    }
    
    func updateScoreImage() {
        score1Img.image = numberImageArray[finalScore / 10]
        score2Img.image = numberImageArray[finalScore % 10]
    }
    
    func checkHighScores() {
        let potentialHS = ScoreTracker(gameType: "Memory", score: finalScore)
        
        
        //   sortHighScore.remove(at: i)
        
        for i in 0..<memHighScore.count {
            if memHighScore[i].score < finalScore {
                memHighScore.insert(potentialHS, at: i)
                memHighScore.remove(at: 5)
                highScoreList[0] = memHighScore
                //       sortHighScore[i].score = finalScore
                updateDatabase()
                return
            }
            
        }
    }
    
    func updateDatabase(){
        let highScoreData = NSKeyedArchiver.archivedData(withRootObject: highScoreList)
        UserDefaults.standard.set(highScoreData, forKey: "allScores")
        UserDefaults.standard.synchronize()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
            time.timer.invalidate()
        }
    }
}
