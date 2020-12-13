//
//  File.swift
//  
//
//  Created by Michael Craun on 12/12/20.
//

import Foundation
import Vapor

final class ReviewController {
    
    func create(_ req: Request) throws -> EventLoopFuture<Review> {
        let review = try req.content.decode(Review.self)
        return review.save(on: req.db).map { review }
    }
    
    func get(_ req: Request) throws -> EventLoopFuture<[Review]> {
        
        guard let id = req.parameters.get("movieID", as: UUID.self) else { throw Abort(.notFound) }
        return Review.query(on: req.db)
            .filter(\.$movie.$id, .equal, id)
            .with(\.$movie)
            .all()
            
    }
    
}
