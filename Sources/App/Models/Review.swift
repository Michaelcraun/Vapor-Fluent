//
//  File.swift
//  
//
//  Created by Michael Craun on 12/12/20.
//

import Foundation
import Fluent
import FluentPostgresDriver
import Vapor

final class Review: Model, Content {
    
    static let schema = "reviews"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    @Parent(key: "movie_id")
    var movie: Movie
    
    init() {  }
    
    init(id: UUID? = nil, title: String, body: String, movie: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movie
    }
}
