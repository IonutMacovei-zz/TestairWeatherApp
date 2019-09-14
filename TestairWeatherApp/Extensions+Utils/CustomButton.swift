//
//  CustomButton.swift
//  TestairWeatherApp
//
//  Created by Macovei, Ionut on 14/09/2019.
//  Copyright © 2019 Macovei, Ionut. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if var frame = titleLabel?.frame {
            frame.size.height = bounds.size.height
            frame.origin.y = titleEdgeInsets.top
            titleLabel?.frame = frame
        }
    }
    
    func setup() {
        layer.cornerRadius = 10.0
        clipsToBounds = true
        tintColor = .white
        backgroundColor = UIColor.white.withAlphaComponent(0.10)
    }
}

