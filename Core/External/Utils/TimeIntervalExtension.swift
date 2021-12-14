//
//  TimeIntervalExtension.swift
//  AppleMusic
//
//  Created by Diffa Desyawan on 12/12/21.
//

import Foundation

public extension TimeInterval{
    
    func toMinutesAndSecond() -> String {
        let time = NSInteger(self)
        let seconds = time % 60
        let minutes = (time / 60) % 60
        return String(format: "%0.2d:%0.2d",minutes,seconds)
    }
}
