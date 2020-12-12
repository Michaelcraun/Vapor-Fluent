import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // returns a "Promise", like in JavaScript
    app.post("movies") { (req) -> EventLoopFuture<Movie> in
        
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map({ movie })
        
    }
}
