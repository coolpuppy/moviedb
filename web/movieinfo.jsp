<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="source.Movie" %>
<%@ page import="java.util.List" %>
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
    <%
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "jhy921101");
            String movieID = request.getParameter("id");
            Statement statement = connection.createStatement();
            String query = "SELECT * FROM movies WHERE id =" + movieID;
            ResultSet result = statement.executeQuery(query);
            Movie myMovie = new Movie();
            while (result.next()) {
                myMovie.setID(result.getString("id"));
                myMovie.setTitle(result.getString("title"));
                myMovie.setDirector(result.getString("director"));
                myMovie.setYear(result.getString("year"));
                myMovie.setBannerURL(result.getString("banner_url"));
                myMovie.setTrailerURL(result.getString("trailer_url"));
            }
    %>
    <title><%
        out.print(myMovie.getTitle() + "(" + myMovie.getYear() + ")");
    %></title>

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
    <h2>
        <%
            out.print(myMovie.getTitle());
        %>
    </h2>
    <div class="row">
        <div class="left col-lg-8">
            <div class="row">
                <div class="col-lg-5">
            <%
                out.println("<img class=\"featurette-image img-responsive center-block\" src= \"" + myMovie.getBanner_url()+"\" alt=\"" +myMovie.getTitle()+" Banner\" ");
            %>
                </div>
                <div class="col-lg-7">
            <%
                out.println(
                "<h3> Movie Title: </h3>" + myMovie.getTitle() +
                "<h3> Director: </h3>" + myMovie.getDirector() +
                "<h3> Year: </h3>" + myMovie.getYear() +
                "<h3> Trailer Link: </h3> <a href = \""+ myMovie.getTrailer_url() +"\"> " + myMovie.getTitle() + " trailer </a> ");
                List<String> genres = myMovie.getGenresOfMovie(connection);
                out.println("<h3> Genres: </h3>");
                for (int i = 0; i < genres.size(); i++) {
                    out.print("<a href = '/Fabflix/BrowseByMovieGenre?genre=" + genres.get(i) + "'>" + genres.get(i) + "</a>");
                    if (i < genres.size() - 1) {
                        out.print(',');
                    }
                }
                out.println("<h3> Cast: </h3>" + myMovie.getStarsOfMovie(connection));
            %>
                </div>
            </div>
        </div>
        <div class="right col-lg-4">
            <form method="post" action="addtocart.jsp">
                <label for="quantity">Qty: </label>
                <select name="quantity" id="quantity">
                    <option value="1" selected>1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
                <input type="hidden" id="movieID" name="movieID" value="<%out.print(myMovie.getID());%>">
                <input id="add-to-cart-button" name="add-to-cart" title="Add to Shopping Cart" type="submit" value="Add to Cart">
            </form>
        </div>
    </div>
    <%
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</div>
</body>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
