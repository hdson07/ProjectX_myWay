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
            self.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4431372549, blue: 0.4745098039, alpha: 1)
        }else{
            self.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }
        

        
    }

}



