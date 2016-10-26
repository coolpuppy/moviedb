package source;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by hongyangjiang on 8/5/16.
 */
public class Star {

    private String id;
    private String first_name;
    private String last_name;
    private String date_of_birth;
    private String photo_url;

    public String setID(String id) {
        this.id = id;
        return id;
    }

    public String getID() {
        return id;
    }

    public String setFirst_name(String first_name) {
        this.first_name = first_name;
        return first_name;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String setLast_name(String last_name) {
        this.last_name = last_name;
        return last_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public String setDOB(String date_of_birth) {
        this.date_of_birth = date_of_birth;
        return date_of_birth;
    }

    public String getDOB() { return date_of_birth; }

    public String setPhoto_url(String photo_url) {
        this.photo_url = photo_url;
        return photo_url;
    }

    public String getPhoto_url() { return photo_url; }

    public String getMoviesOfStar(Connection connection) throws SQLException {
        String query = "SELECT * FROM movies WHERE id in (SELECT movie_id FROM stars_in_movies WHERE star_id = " + id + ")";

        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(query);

        StringBuilder sb = new StringBuilder();
        boolean moviesFound = false;
        while (rs.next()) {
            moviesFound = true;
            String movieTitle = rs.getString("title");
            String movieID = rs.getString("id");
            sb.append("<a href='movieinfo.jsp?id=" + movieID + "'>" + movieTitle + "</a>, ");
        }

        if (moviesFound)
            sb.delete(sb.length() - 2, sb.length());

        rs.close();
        statement.close();

        return sb.toString();
    }
}
