//
//  spacedata.swift
//  CarNavigateion
//
//  Created by Duckee on 27/04/2019.
//  Copyright © 2019 Duckee. All rights reserved.
//

import Foundation

public struct spaceData {
    var spaceEmpty : [[Bool]]
    var spaceWeight : [[Int]]
    init() {
        spaceEmpty = [
            [true, false, false, false, false, false, false, false, false, false, false], //car11  Num : 11
            [false, false, false, false, false, false, false, false, false, false, false], //car12  Num : 11
            [false, false, false, false, false, false, false, false, false, false, false], //car13  Num : 11
            [false, false, false, true, false, false, false, false, false, false], //car14  Num : 10
            [false, false, false, false, false, false, false, true], //car21  Num : 8
            [false, false, false, false, false, false, false, false, false, false, true, false, false, false, true, false, false, false, false, false], //car 31  Num : 20
            [false, false, false,false, false, false, false, false, true, true, false, false, false, false, false, true, false, false, false, false], //car 32  Num : 20
            [false, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, true], //car 33  Num : 20
            [true, false, false, false, false, false, false, false, false, false, false, false, true, false, false, false, false, false, false, false], //car 34  Num : 20
            [false, false, false, false, false, false, false, false, false, true, true, false, false, false, false, false, false, false, false, false], //car 35  Num : 20
            [true, false, true, false, false, false, false, false], //handicap  Num : 8
            [false, true, false, false, false, false], //bigcar1  Num : 6
            [false, false, false, false, false, false], //bigcar2  Num : 6
            [false, false, false, true, false, false], //bigcar3  Num : 6
            [false, false, false, false, false, false], //bigcar4  Num : 6
            
        ]
        spaceWeight = [
            [129, 127, 125, 123, 119, 117, 115, 113, 111, 110, 109], //car11  Num : 11
            [130, 128, 126, 124, 122, 121, 120, 118, 116, 114, 112], //car12  Num : 11
            [147, 146, 145, 141, 140, 139, 135, 134, 133, 132, 131], //car13  Num : 11
            [151, 150, 149, 148, 144, 143, 142, 138, 137, 136], //car14  Num : 10
            [108, 107, 106, 105, 103, 101, 99, 97], //car21  Num : 8
            [104, 102, 100, 98, 96, 95, 94, 93, 92, 91, 80, 79, 78, 77, 76, 75, 74, 73, 72, 71], //car 31  Num : 20
            [90, 88, 86, 84, 82, 70, 68, 66, 64, 62, 60, 58, 56, 54, 52, 30, 28, 26, 24, 22], //car 32  Num : 20
            [89, 87, 85, 83, 81, 69, 67, 65, 63, 61, 59, 57, 55, 53, 51, 29, 27, 25, 23, 21], //car 33  Num : 20
            [50, 48, 46, 44, 42, 40, 38, 36, 34, 32, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2], //car 34  Num : 20
            [49, 47, 45, 43, 41, 39, 37, 35, 33, 31, 19, 17, 15, 13, 11, 9, 7, 5, 3, 1], //car 35  Num : 20
            [8, 7, 6, 5, 4, 3, 2, 1], //handicap  Num : 8
            [19, 20, 21, 22, 23, 24], //bigcar1  Num : 6
            [8, 10, 12, 14, 16, 18], //bigcar2  Num : 6
            [7, 9, 11, 13, 15, 17], //bigcar3  Num : 6
            [1, 2, 3, 4, 5, 6], //bigcar4  Num : 6
        ]
        }
    func pathVisualization(line : Int) -> [String] {
        //return 6 projector direction array, consist of "left","right","up","down","none"
        switch line {
        case 0:     //car11
            return ["up","none","left","down","left","none"] // projector 1...6
        case 1:     //car12
            return ["",]
        case 2:     //car13
            return ["",]
        case 3:     //car14
            return ["",]
        case 4:     //car21
            return ["",]
        case 5:     //car31
            return ["",]
        case 6:     //car32
            return ["",]
        case 7:     //car33
            return ["",]
        case 8:     //car34
            return ["",]
        case 9:     //car35
            return ["",]
        case 10:    //handicap
            return ["",]
        case 11:    //bigcar1
            return ["",]
        case 12:    //bigcar2
            return ["",]
        case 13:    //bigcar3
            return ["",]
        case 14:    //bigcar4
            return ["",]
        default:
            return ["none","none","none","none","none","none","none"]
        }
    }
    
}


