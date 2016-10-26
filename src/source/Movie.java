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
public class Movie {

    private String id;
    private String title;
    private String year;
    private String director;
    private String banner_url;
    private String trailer_url;

    public String setID(String id) {
        this.id = id;
        return id;
    }

    public String getID() {
        return id;
    }

    public String setTitle(String title) {
        this.title = title;
        return title;
    }

    public String getTitle() {
        return title;
    }

    public String setYear(String year) {
        this.year = year;
        return year;
    }

    public String getYear() {
        return year;
    }

    public String setDirector(String director) {
        this.director = director;
        return director;
    }

    public String getDirector() {
        return director;
    }

    public String setBannerURL(String banner_url) {
        this.banner_url = banner_url;
        return banner_url;
    }

    public String getBanner_url() {
        return banner_url;
    }

    public String setTrailerURL(String trailer_url) {
        this.trailer_url = trailer_url;
        return trailer_url;
    }

    public String getTrailer_url() {
        return trailer_url;
    }

    public List<String> getGenresOfMovie(Connection connection) throws SQLException {
        String query = "SELECT name FROM (genres g JOIN genres_in_movies gm " + "ON g.id = gm.genre_id) WHERE gm.movie_id=" + id;

        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(query);

        List<String> ret = new ArrayList<>();
        while (rs.next()) {
            String s_NA = rs.getString("name");
            ret.add(s_NA);
        }


        rs.close();
        statement.close();

        return ret;
    }

    public String getStarsOfMovie(Connection connection) throws SQLException {
        String query = "SELECT first_name, last_name, photo_url, s.id FROM (movies m JOIN stars_in_movies sm " + "NATURAL JOIN stars s "
                + "ON m.id = sm.movie_id AND sm.star_id = s.id) WHERE m.id=" + id;

        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery(query);

        StringBuilder sb = new StringBuilder();
        boolean starsFound = false;
        while (rs.next()) {
            starsFound = true;
            String s_NA = rs.getString("first_name") + " " + rs.getString("last_name");
            String s_ID = rs.getString("s.id");
            sb.append("<a href='starinfo.jsp?id=" + s_ID + "'>" + s_NA + "</a>, ");

        }

        if (starsFound)
            sb.delete(sb.length() - 2, sb.length());

        rs.close();
        statement.close();

        return sb.toString();
    }
}
