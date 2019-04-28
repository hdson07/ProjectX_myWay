//
//  spaceButton.swift
//  CarNavigateion
//
//  Created by Duckee on 27/04/2019.
//  Copyright © 2019 Duckee. All rights reserved.
//

import UIKit

class spaceButton: UIButton {
    var empty = true
    var weight = 10
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 4


    }
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let touchPoint = touches.first?.location(in: self) else { return }
        guard self.bounds.contains(touchPoint) else { return }
        // Do what you wanna do here
        self.empty = !self.empty
        if empty {
            self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }else{
            self.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
        

        
    }

}



