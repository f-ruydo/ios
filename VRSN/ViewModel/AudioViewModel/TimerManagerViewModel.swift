//
//  TimerManagerViewModel.swift
//  VRSN
//
//  Created by Enrique on 30-04-21.
//

import Foundation

class TimerManagerViewModel: ObservableObject {
    
    enum TimerMode {
        case running
        case paused
        case initial
        case limit
    }
    
    private var secondMax = 1000
    @Published var timerMode: TimerMode = .initial
    @Published var seconds = UserDefaults.standard.integer(forKey: "timerLength")
    var timer = Timer()
    
    func setTimerLength(minutes: Int) {
        let defaults = UserDefaults.standard
        defaults.set(minutes, forKey: "timerLength")
        seconds = minutes
    }
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            self.seconds += 1
            if self.seconds == self.secondMax {
                self.limit()
                
            }
        })
    }
    
    func reset() {
        self.timerMode = .initial
        self.seconds = UserDefaults.standard.integer(forKey: "timerLength")
        timer.invalidate()
    }
    
    func pause() {
        self.timerMode = .paused
        timer.invalidate()
    }
    
    func limit() {
        self.timerMode = .paused
        timer.invalidate()
    }
}
