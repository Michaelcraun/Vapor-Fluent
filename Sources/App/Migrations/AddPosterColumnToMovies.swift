//
//  File.swift
//  
//
//  Created by Michael Craun on 12/12/20.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct AddPosterColoumnToMovies: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .field("poster", .string)
            .update()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("movies")
            .deleteField("poster")
            .delete()
    }
    
}
