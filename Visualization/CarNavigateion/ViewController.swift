//
//  ViewController.swift
//  CarNavigateion
//
//  Created by Duckee on 27/04/2019.
//  Copyright © 2019 Duckee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var carNumLabel: UIButton!
    @IBOutlet var projectorArray: [UILabel]!
    
    @IBAction func navigation(_ sender: Any) {
        do {
            let path: String = "/Users/hduck/희덕/Duck's Data/2019-1/ProjectX/ProjectX_myWay/Visualization/carNum.txt"
            let file = try String(contentsOfFile: path)
            let text: [String] = file.components(separatedBy: "\n")
            carNumLabel.setTitle("\(text[0])", for: .normal)
            if text[1] == "승용차" {
                carButton(self)
            }else if text[1] == "화물차"{
                bigCarButton(self)
            }else if text[1] == "장애인"{
                hadicapButton(self)
            }
        } catch let error {
            Swift.print("Fatal Error: \(error.localizedDescription)")
        }
    }
    @IBAction func carButton(_ sender: Any) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_car")!)

        var minCar11 = (1000,"car11")
        for car in car11 {
            if minCar11.0 > car.weight && car.empty {
                minCar11.0 = car.weight
            }
        }
        var minCarArray = [minCar11]
        
        var minCar12 = (1000,"car12")
        for car in car12 {
            if minCar12.0 > car.weight && car.empty {
                minCar12.0 = car.weight
            }
        }
        minCarArray.append(minCar12)

        var minCar13 = (1000,"car13")
        for car in car13 {
            if minCar13.0 > car.weight && car.empty {
                minCar13.0 = car.weight
            }
        }
        minCarArray.append(minCar13)

        var minCar14 = (1000,"car14")
        for car in car14 {
            if minCar14.0 > car.weight && car.empty {
                minCar14.0 = car.weight
            }
        }
        minCarArray.append(minCar14)

        var minCar21 = (1000,"car21")
        for car in car21 {
            if minCar21.0 > car.weight && car.empty {
                minCar21.0 = car.weight
            }
        }
        minCarArray.append(minCar21)

        var minCar31 = (1000,"car31")
        for car in car31 {
            if minCar31.0 > car.weight && car.empty {
                minCar31.0 = car.weight
            }
        }
        minCarArray.append(minCar31)

        var minCar32 = (1000,"car32")
        for car in car32 {
            if minCar32.0 > car.weight && car.empty {
                minCar32.0 = car.weight
            }
        }
        minCarArray.append(minCar32)

        var minCar33 = (1000,"car33")
        for car in car33 {
            if minCar33.0 > car.weight && car.empty {
                minCar33.0 = car.weight
            }
        }
        minCarArray.append(minCar33)

        var minCar34 = (1000,"car34")
        for car in car34 {
            if minCar34.0 > car.weight && car.empty {
                minCar34.0 = car.weight
            }
        }
        minCarArray.append(minCar34)

        var minCar35 = (1000,"car35")
        for car in car35 {
            if minCar35.0 > car.weight && car.empty {
                minCar35.0 = car.weight
            }
        }
        minCarArray.append(minCar35)
        
        var resultWeight = 1000
        var resultSpace = "is Full"
        for carLow in minCarArray {
            if carLow.0 < resultWeight{
                resultWeight = carLow.0
                resultSpace = carLow.1
            }
        }
        if resultWeight == 1000 {
            print("만차입니다.")
        }else{
            var directionArray = ["","","","","",""]
            switch resultSpace{
            case "car11":     //car11
                changeSpacecolor(carArray: car11)
                 directionArray =  ["up","none","left","down","left","none"]
            case "car12":     //car12
                changeSpacecolor(carArray: car12)
                 directionArray =   ["up","none","left","down","left","none"]
            case "car13":     //car13
                changeSpacecolor(carArray: car13)
                 directionArray =   ["up","none","left","down","none","left"]
            case "car14":     //car14
                changeSpacecolor(carArray: car14)
                 directionArray =   ["up","none","left","down","none","left"]
            case "car21":     //car21
                changeSpacecolor(carArray: car21)
                 directionArray =   ["up","none","left","none","none","none"]
            case "car31":     //car31
                changeSpacecolor(carArray: car31)
                 directionArray =   ["up","none","left","none","none","none"]
            case "car32":     //car32
                changeSpacecolor(carArray: car32)
                 directionArray =   ["up","left","none","none","none","none"]
            case "car33":     //car33
                changeSpacecolor(carArray: car33)
                 directionArray =   ["up","left","none","none","none","none"]
            case "car34":     //car34
                changeSpacecolor(carArray: car34)
                 directionArray =   ["left","none","none","none","none","none"]
            case "car35":     //car35
                changeSpacecolor(carArray: car35)
                 directionArray =   ["left","none","none","none","none","none"]
            default:
                directionArray = ["none","none","none","none","none","none","none"]
            }
            for counter in projectorArray.indices {
                projectorArray[counter].backgroundColor = UIColor(patternImage: UIImage(named: "\(directionArray[counter])")!)
            }
        }
       
        
    }
    func pathVisualization(line : Int) -> [String] {
        //return 6 projector direction array, consist of "left","right","up","down","none"
        switch line {

        case 10:    //handicap
            return ["up","none","left","none","none","none"]
        case 11:    //bigcar1
            return ["up","none","right","none","none","none"]
        case 12:    //bigcar2
            return ["up","right","none","none","none","none"]
        case 13:    //bigcar3
            return ["up","right","none","none","none","none"]
        case 14:    //bigcar4
            return ["right","none","none","none","none","none"]
        case 15:
            return [] //?
            
        default:
            return ["none","none","none","none","none","none","none"]
        }
    }
    
    @IBAction func bigCarButton(_ sender: Any) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_bigcar")!)

        var minCar1 = (1000,"bigCar1")
        for car in bigCar1 {
            if minCar1.0 > car.weight && car.empty {
                minCar1.0 = car.weight
            }
        }
        var minCarArray = [minCar1]
        var minCar2 = (1000,"bigCar2")
        for car in bicCar2 {
            if minCar2.0 > car.weight && car.empty {
                minCar2.0 = car.weight
            }
        }
        minCarArray.append(minCar2)
        
        var minCar3 = (1000,"bigCar3")
        for car in bigCar3 {
            if minCar3.0 > car.weight && car.empty {
                minCar3.0 = car.weight
            }
        }
        minCarArray.append(minCar3)
        
        var minCar4 = (1000,"bigCar4")
        for car in bicCar4 {
            if minCar4.0 > car.weight && car.empty {
                minCar4.0 = car.weight
            }
        }
        minCarArray.append(minCar4)
        
        var resultWeight = 1000
        var resultSpace = "is Full"
        for carLow in minCarArray {
            if carLow.0 < resultWeight{
                resultWeight = carLow.0
                resultSpace = carLow.1
            }
        }
        print(resultWeight)
        print(resultSpace)
        if resultWeight == 1000 {
            print("만차입니다.")
        }else{
            var directionArray = ["","","","","",""]
            switch resultSpace{
            case "bigCar1":
                changeSpacecolor(carArray: bigCar1)
                directionArray = ["up","none","right","none","none","none"]
            case "bigCar2":     //car12
                changeSpacecolor(carArray: bicCar2)
                directionArray =   ["up","right","none","none","none","none"]
            case "bigCar3":     //car13
                changeSpacecolor(carArray: bigCar3)
                directionArray =   ["up","right","none","none","none","none"]
            case "bigCar4":     //car14
                print("ERROR")
                changeSpacecolor(carArray: bicCar4)
                directionArray =   ["right","none","none","none","none","none"]
            default:
                directionArray = ["none","none","none","none","none","none","none"]
            }
            for counter in projectorArray.indices {
                projectorArray[counter].backgroundColor = UIColor(patternImage: UIImage(named: "\(directionArray[counter])")!)
            }
        }
    }
    @IBAction func hadicapButton(_ sender: Any) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_handi")!)

        var minCarWeight = 1000
        for car in handicap {
            if car.weight < minCarWeight && car.empty{
                minCarWeight = car.weight
            }
            
        }
        if minCarWeight == 1000 {
            print("만차입니다.")
        }else{
            for car in handicap {
                if car.weight == minCarWeight{
                    let time = DispatchTime.now() + .milliseconds(5000)
                    car.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    DispatchQueue.main.asyncAfter(deadline: time){
                        car.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        car.empty = false
                    }
                }
            }
           var directionArray =  ["up","none","left","none","none","none"]
            for counter in projectorArray.indices {
                projectorArray[counter].backgroundColor = UIColor(patternImage: UIImage(named: "\(directionArray[counter])")!)
            }
        }
        
    }
    
    func changeSpacecolor(carArray : [spaceButton]) {
        var minCarWeight = 1000
        for car in carArray {
            if car.weight < minCarWeight && car.empty{
                minCarWeight = car.weight
            }
            
        }
        if minCarWeight == 1000 {
            print("만차입니다.")
        }else{
            for car in carArray {
                if car.weight == minCarWeight{
                    let time = DispatchTime.now() + .milliseconds(5000)
                    car.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                    DispatchQueue.main.asyncAfter(deadline: time){
                        car.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        car.empty = false
                    }
                }
            }
        }

    }
    
    
    @IBOutlet var car11: [spaceButton]!


    @IBOutlet var car12: [spaceButton]!
    @IBOutlet var car13: [spaceButton]!
    @IBOutlet var car14: [spaceButton]!
    @IBOutlet var car21: [spaceButton]!
    @IBOutlet var car31: [spaceButton]!
    @IBOutlet var car32: [spaceButton]!
    
    @IBOutlet var car33: [spaceButton]!
    
    @IBOutlet var car34: [spaceButton]!
    
    @IBOutlet var car35: [spaceButton]!
    
    @IBOutlet var handicap: [spaceButton]!
    @IBOutlet var bigCar1: [spaceButton]!
    @IBOutlet var bicCar2: [spaceButton]!

    @IBOutlet var bigCar3: [spaceButton]!
    
    @IBOutlet var bicCar4: [spaceButton]!

    override func viewDidLoad() {
        var data = spaceData()
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        var carSpace = [[spaceButton]]()
        carSpace.append(car11)
        carSpace.append(car12)
        carSpace.append(car13)
        carSpace.append(car14)
        carSpace.append(car21)
        carSpace.append(car31)
        carSpace.append(car32)
        carSpace.append(car33)
        carSpace.append(car34)
        carSpace.append(car35)
        carSpace.append(handicap)
        carSpace.append(bigCar1)
        carSpace.append(bicCar2)
        carSpace.append(bigCar3)
        carSpace.append(bicCar4)
        for i in carSpace.indices {
            for j in carSpace[i].indices{
                carSpace[i][j].weight = data.spaceWeight[i][j]
                if data.spaceEmpty[i][j] == true{
                    carSpace[i][j].empty = true
                    carSpace[i][j].backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
                }else{
                    carSpace[i][j].empty = false
                    carSpace[i][j].backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
            }
        }
        
        for carLow in carSpace {
            print(carLow.count)
            var counter = 1
            for car in carLow{
                car.setTitle("\(car.weight)", for: .normal)
                car.setTitleColor(.black, for: .normal)
                counter = counter + 1
            }
        }
        for i in carSpace.indices {
            for j in carSpace[i].indices{
                carSpace[i][j].weight = data.spaceWeight[i][j]
            }
        }
        
    }
    
}







