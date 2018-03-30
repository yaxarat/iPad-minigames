//
// Created by Yashar Atajan on 3/29/18.
// Copyright (c) 2018 Yaxiaer Atajiang. All rights reserved.
//

import UIKit

class Vehicles {
    var allArray = [Vehicle]()
    var airArray = [Int](repeatElement(0, count: 5))
    var waterArray = [Int](repeatElement(0, count: 5))
    var landArray = [Int](repeatElement(0, count: 5))
    var difficulty: String

    init(difficulty: String){
        self.difficulty = difficulty
        numVehicle()
        randPick()
    }

    func numVehicle() {
        var numberOfItems: Int = 0
        if difficulty == "Easy" {
            numberOfItems = 8
        } else if difficulty == "Medium" {
            numberOfItems = 10
        } else if difficulty == "Hard" {
            numberOfItems = 12
        } else {
            return
        }

        numVehicle1(noi: numberOfItems)
    }

    func numVehicle1(noi: Int) {
        var unionArray: [Int] = [Int](repeatElement(0, count: 3))

        for _ in 0 ..< noi {
            var rand = Int(arc4random_uniform(3))
            if unionArray[rand] < 5 {
                unionArray[rand] += 1
                allArray.append(types(randItem: rand))
            } else {
                while unionArray[rand] == 5 {
                    rand = Int(arc4random_uniform(3))
                }
                unionArray[rand] += 1
                allArray.append(types(randItem: rand))
            }
        }
    }

    func types(randItem: Int) -> Vehicle {
        let vehicle = Vehicle()
        if randItem == 0 {
            vehicle.isAir = true
        } else if randItem == 1 {
            vehicle.isWater = true
        } else {
            vehicle.isLand = true
        }
        return vehicle
    }

    func randPick() {
        for vehicle in allArray {
            if vehicle.isAir {
                picker(vehicle: vehicle, array: &airArray)
            } else if vehicle.isWater {
                picker(vehicle: vehicle, array: &waterArray)
            } else if vehicle.isLand {
                picker(vehicle: vehicle, array: &landArray)
            }
        }
    }

    func picker(vehicle: Vehicle, array: inout [Int]) {
        var rand = Int(arc4random_uniform(5))
        if array[rand] == 0 {
            array[rand] += 1
            vehicle.typeID = rand
        } else {
            while array[rand] == 1 {
                rand = Int(arc4random_uniform(5))
            }
            array[rand] += 1
            vehicle.typeID = rand
        }
    }
}