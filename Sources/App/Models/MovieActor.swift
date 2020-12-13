//
//  File.swift
//  
//
//  Created by Michael Craun on 12/12/20.
//

import Foundation
import Vapor
import Fluent
import FluentPostgresDriver

final class MovieActor: Model {
    
    static let schema = "movie_actors"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "movie_id")
    var movie: Movie
    
    @Parent(key: "actor_id")
    var actor: Actor
    
    init() {  }
    
    init(movie: UUID, actor: UUID) {
        self.$movie.id = movie
        self.$actor.id = actor
    }
    
}
