//
//  ContentViewModel.swift
//  To-Do List App
//
//  Created by Roman on 10/16/23.
//

import Foundation

public class ContentViewModel {
    let id: Int
    let name: String
    var isComplete: Bool
    
    init(id: Int, name: String, isComplete: Bool) {
        self.id = id
        self.name = name
        self.isComplete = isComplete
    }
}
