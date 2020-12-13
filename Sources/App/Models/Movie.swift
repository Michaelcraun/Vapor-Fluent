//
//  File.swift
//  
//
//  Created by Michael Craun on 12/12/20.
//

import Foundation
import Fluent
import Vapor

final class Movie: Model, Content {
    
    static let schema = "movies"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Children(for: \.$movie)
    var reviews: [Review]
    
    @Siblings(through: MovieActor.self, from: \.$movie, to: \.$actor)
    var actors: [Actor]
    
    init() {  }
    
    init(id: UUID? = nil, title: String) {
        self.id = id
        self.title = title
    }
}
