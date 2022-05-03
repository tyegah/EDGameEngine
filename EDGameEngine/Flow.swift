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
    func routeTo(question:String, answerCallback: @escaping (String) -> Void)
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
        if let firstQuestion = questions.first {
            router.routeTo(question: firstQuestion) { [weak self] _ in
                guard let self = self else {return}
                let firstQuestionIndex = self.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = self.questions[firstQuestionIndex+1]
                self.router.routeTo(question: nextQuestion) { _ in }
            }
        }
    }
}
