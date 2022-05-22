//
//  Router.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 22/05/22.
//

import Foundation

// This router is responsible for routing/navigating between questions
// For example, if it's storyboards, we can implement it in StoryboardRouter,
// if it's navigation controller, it can be NavigationControllerRouter
protocol Router {
    associatedtype Answer // we make the answer and question to be associatedtype to support any type of answer and question.
    associatedtype Question:Hashable // Question needs to be hashable because it will be dictionary
//    typealias AnswerCallback = (String) -> Void // Because the callback will cause the compiler error, we revert it back to just plain closure
    func routeTo(question:Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result:Result<Question,Answer>)
}
