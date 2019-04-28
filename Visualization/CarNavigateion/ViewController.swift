//
//  ViewController.swift
//  CarNavigateion
//
//  Created by Duckee on 27/04/2019.
//  Copyright © 2019 Duckee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


 
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
        super.viewDidLoad()
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
        
        for carLow in carSpace {
            print(carLow.count)
            var counter = 1
            for car in carLow{
                car.setTitle("\(counter)", for: .normal)
                car.setTitleColor(.black, for: .normal)
                counter = counter + 1
            }
        }
    }
    
}







//
//
//
//
//
//
//
//
//        for button in car11! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car12! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car13! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car14! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car21! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car31! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car32! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car33! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car34! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in car35! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in handicap! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in bigCar1! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in bicCar2! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in bigCar3! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//        for button in bicCar4! {
//            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//        }
//
//
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    @objc func buttonClicked(sender: spaceButton!) {
//        sender.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
//    }
//
