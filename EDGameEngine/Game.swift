//
//  Game.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 22/05/22.
//

import Foundation

public func startGame<Question, Answer:Equatable, R:Router>(questions:[Question], router: R, answers:[Question:Answer]) where R.Question == Question, R.Answer == Answer {
    
}
