//
//  Int+Extension.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation

extension Int {
    
    func secondsToMinutesAndSeconds() -> String {
        let minutes = "\((self % 3600) / 60)"
        let seconds = "\((self % 3600) % 60)"
        let minuteStamp = minutes.count > 1 ? minutes : "0" + minutes
        let secondStamp = seconds.count > 1 ? seconds : "0" + seconds
        
        return "\(minuteStamp):\(secondStamp)"
        
    }
}
