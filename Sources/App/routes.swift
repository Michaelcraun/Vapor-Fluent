import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.get("movies") { req in
        Movie.query(on: req.db).all()
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
    
    // returns a "Promise", like in JavaScript
    app.post("movies") { (req) -> EventLoopFuture<Movie> in
        
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map({ movie })
        
    }
}
