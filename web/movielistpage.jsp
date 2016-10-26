<%@ page import="source.Movie" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %><%--
  Created by IntelliJ IDEA.
  User: hongyangjiang
  Date: 8/11/16
  Time: 3:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="image/favicon.ico">

    <title>Movie Result</title>

    <!-- Bootstrap core CSS -->
    <link href="bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="bootstrap/css/navbar.css" rel="stylesheet">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">

    <!-- Static navbar -->
    <nav class="navbar navbar-default">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="main.html">Fabflix</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <li><a href="main.html">Home</a></li>
                    <li><a href="browse.jsp">Browse</a></li>
                    <li><a href="#">Search</a></li>
                </ul>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="shoppingcart.jsp">Shopping Cart</a></li>
                    <li><a href="/Fabflix/Logout">Log Out</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
    </nav>
    <h2 class="sub-header">The movies you are looking for:</h2>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>id</th>
                <th>title</th>
                <th>Year</th>
                <th>Director</th>
                <th>List of Genres</th>
                <th>Cast</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver").newInstance();
                    Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "jhy921101");
                    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
                    for (Movie movie : movies) {
                        out.println("<tr>");
                        out.println("<td>" + movie.getID() + "</td>");
                        out.println("<td>" + "<h3 class=\"movieCardAnchor\" id=\"${movie.id}\"><a href = movieinfo.jsp?id='" + movie.getID() + "'>" + movie.getTitle() + "</td>");
                        out.println("<td>" + movie.getYear() + "</td>");
                        out.println("<td>" + movie.getDirector() + "</td>");
                        List<String> genres = movie.getGenresOfMovie(connection);
                        out.print("<td>");
                        for (int i = 0; i < genres.size(); i++) {
                            out.print("<a href='/Fabflix/BrowseByMovieGenre?genre=" + genres.get(i) + "'>" + genres.get(i) + "</a>");
                            if (i < genres.size() - 1) {
                                out.print(',');
                            }
                        }
                        out.println("</td>");
                        out.println("<td>" + movie.getStarsOfMovie(connection) + "</td>");
                        out.println("</tr>");
                    }
                    connection.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
            <h3 class="movie"
            </tbody>
        </table>
    </div>
</div>
<!-- Bootstrap core JavaScript
    ================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>