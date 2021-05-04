//
//  Date+Extension.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60     //Seconds
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 30 * day
        let year = 365 * day
        
        if secondsAgo < minute {
            return "a moment ago"
            
        } else if secondsAgo < hour {
            if (secondsAgo / minute) == 1 {
                return "1 minute ago"
            }
            return "\(secondsAgo / minute) minutes ago"
            
        } else if secondsAgo < day {
            if (secondsAgo / hour) == 1 {
                return "1 hour ago"
            }
            return "\(secondsAgo / hour) hours ago"
            
        } else if secondsAgo <  week {
            if (secondsAgo / day) == 1 {
                return "1 day ago"
            }
            return "\(secondsAgo / day) days ago"
            
        } else if secondsAgo < month {
            if (secondsAgo / week) == 1 {
                return "1 week ago"
            }
            return "\(secondsAgo / week) weeks ago"
            
        } else if secondsAgo < year {
            if (secondsAgo / month) == 1 {
                return "1 month ago"
            }
            return "\(secondsAgo / month) months ago"
        
        }
        if (secondsAgo / year) == 1 {
            return "1 year ago"
        }
        return "\(secondsAgo / year) years ago"
    }
}
