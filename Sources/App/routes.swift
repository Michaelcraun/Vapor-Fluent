import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("movies") { req in
        Movie.query(on: req.db).all()
    }
    
    app.get("movies", ":id") { req -> EventLoopFuture<Movie> in
        
        Movie.find(req.parameters.get("id"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
    }
    
    // returns a "Promise", like in JavaScript
    app.post("movies") { (req) -> EventLoopFuture<Movie> in
        
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map({ movie })
        
    }
}
