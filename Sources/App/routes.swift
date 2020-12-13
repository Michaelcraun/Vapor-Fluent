import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let movies = MovieController()
    app.post("movies", use: movies.create)
    app.get("movies", use: movies.get)
    app.delete("movies", ":movieID", use: movies.delete)
    
    let reviews = ReviewController()
    app.post("reviews", use: reviews.create)
    app.get("movies", ":movieID", "reviews", use: reviews.get)
    
}
