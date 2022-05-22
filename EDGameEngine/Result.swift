//
//  Result.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 22/05/22.
//

import Foundation

// Because we need to have the score when we're routing
// We decided to create a data structure like a struct to prevent the
// test from failing and to make things easier

public struct Result<Question:Hashable, Answer> {
    // At first we create this first to change the router's protocol "routeTo" with the struct Result
    public let answers:[Question:Answer]
    public let score:Int
}
