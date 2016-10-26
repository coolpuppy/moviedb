package source;

import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hongyangjiang on 8/5/16.
 */
@WebServlet("/BrowseByMovieGenre")
public class BrowseByMovieGenre extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String genre = request.getParameter("genre");
        PrintWriter out = response.getWriter();
        if (genre == null) {
            out.println("No genre selected!");
        } else {
            try {
                List<Movie> movies = getMovieListByGenre(genre);
                request.setAttribute("movies", movies);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/movielistpage.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        out.close();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doGet(request, response);
    }

    private List<Movie> getMovieListByGenre(String genre) {
        List<Movie> selectedMovies = new ArrayList<Movie>();
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "jhy921101");
            String query = "SELECT * FROM movies WHERE id IN (SELECT movie_id FROM genres_in_movies WHERE genre_id = (SELECT id FROM genres WHERE name = '" + genre + "')) ORDER BY title";
            Statement statement = connection.createStatement();
            ResultSet result = statement.executeQuery(query);
            while (result.next()) {
                Movie newMovie = new Movie();
                newMovie.setID(result.getString("id"));
                newMovie.setTitle(result.getString("title"));
                newMovie.setYear(result.getString("year"));
                newMovie.setDirector(result.getString("director"));
                newMovie.setBannerURL(result.getString("banner_url"));
                newMovie.setTrailerURL(result.getString("trailer_url"));
                selectedMovies.add(newMovie);
            }
            result.close();
            statement.close();
            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return selectedMovies;
    }
}