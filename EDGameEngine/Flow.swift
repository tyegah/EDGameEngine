//
//  Flow.swift
//  EDGameEngine
//
//  Created by Ty Septiani on 29/04/22.
//

import Foundation

protocol Router {
    
}
// we make this as a class because it has a behaviour and not just values
class Flow {
    private let router:Router
    init(router:Router) {
        self.router = router
    }
    
    func start() {
        
    }
}
