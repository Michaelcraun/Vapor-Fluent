//
//  File.swift
//  
//
//  Created by Michael Craun on 12/12/20.
//

import Foundation
import Vapor

final class MovieController {
    
    func create(_ req: Request) throws -> EventLoopFuture<Movie> {
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map { movie }  
    }
    
    func delete(_ req: Request) throws -> EventLoopFuture<HTTPStatus> {
        Movie.find(req.parameters.get("movieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
    
    func get(_ req: Request) throws -> EventLoopFuture<[Movie]> {
        return Movie.query(on: req.db).all()
    }
    
}
