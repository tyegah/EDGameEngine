//
//  Flow.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 29/04/22.
//

import Foundation

// This router is responsible for routing/navigating between questions
// For example, if it's storyboards, we can implement it in StoryboardRouter,
// if it's navigation controller, it can be NavigationControllerRouter
protocol Router {
    func routeTo(question:String)
}
// we make this as a class because it has a behaviour and not just values
class Flow {
    private let router:Router
    let questions:[String]
    init(questions: [String], router:Router) {
        self.router = router
        self.questions = questions
    }
    
    func start() {
        router.routeTo(question: "")
    }
}
