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

struct CreateMovieActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("movie_actors")
            .id()
            .field("movie_id", .uuid, .required, .references("movies", "id"))
            .field("actor_id", .uuid, .required, .references("actors", "id"))
            .create()
        
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("movie_actors").delete()
        
    }
}
