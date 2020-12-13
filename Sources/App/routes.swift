import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("movies") { req in
        Movie.query(on: req.db).with(\.$reviews).with(\.$actors).all()
    }
    
    // /movies/{ id }
    app.get("movies", ":id") { req -> EventLoopFuture<Movie> in
        
        Movie.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
    }
    
    // /movies PUT
    app.put("movies") { (req) -> EventLoopFuture<HTTPStatus> in
        
        let movie = try req.content.decode(Movie.self)
        return Movie.find(movie.id, on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = movie.title
                return $0.update(on: req.db).transform(to: .ok)
            }
        
    }
    
    // /movies/id DELETE
    app.delete("movies", ":id") { (req) -> EventLoopFuture<HTTPStatus> in
        
        Movie.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
        
    }
    
    // returns a "Promise", like in JavaScript
    app.post("movies") { (req) -> EventLoopFuture<Movie> in
        
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map({ movie })
        
    }
    
    // Reviews
    app.post("reviews") { req -> EventLoopFuture<Review> in
        
        let review = try req.content.decode(Review.self)
        return review.create(on: req.db).map({ review })
        
    }
    
    // Actors
    app.post("actors") { req -> EventLoopFuture<Actor> in
        
        let actor = try req.content.decode(Actor.self)
        return actor.create(on: req.db).map({ actor })
        
    }
    
    app.get("actors") { req in
        Actor.query(on: req.db).with(\.$movies).all()
    }
    
    // Create relation between movie and actor
    app.post("movie", ":movieID", "actor", ":actorID") { (req) -> EventLoopFuture<HTTPStatus> in
        
        let movie = Movie.find(req.parameters.get("movieID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        print("Found movie!")
        
        let actor = Actor.find(req.parameters.get("actorID"), on: req.db)
            .unwrap(or: Abort(.notFound))
        print("Found actor!")
        
        return movie.and(actor).flatMap { (movie, actor) in
            movie.$actors.attach(actor, on: req.db)
        }.transform(to: .ok)
        
    }
    
}
