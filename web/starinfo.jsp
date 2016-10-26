<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="source.Movie" %>
<%@ page import="java.util.List" %>
<%@ page import="source.Star" %>
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
            String starID = request.getParameter("id");
            Statement statement = connection.createStatement();
            String query = "SELECT * FROM stars WHERE id =" + starID;
            ResultSet result = statement.executeQuery(query);
            Star myStar = new Star();
            while (result.next()) {
                myStar.setID(starID);
                myStar.setFirst_name(result.getString("first_name"));
                myStar.setLast_name(result.getString("last_name"));
                myStar.setDOB(result.getString("dob"));
                myStar.setPhoto_url(result.getString("photo_url"));
            }
    %>
    <title><%
        out.print(myStar.getFirst_name() + ' ' + myStar.getLast_name());
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
            out.print(myStar.getFirst_name() + ' ' + myStar.getLast_name());
        %>
    </h2>
    <%
            out.println("<img src= \"" + myStar.getPhoto_url() +"\" alt=\"" +myStar.getFirst_name() + ' ' + myStar.getLast_name() + " Banner\" "
                    + "width =\"128\" height=\"128\"> <br></br>");
            out.println(    "<h3> ID: </h3>" + myStar.getID() +
                            "<h3> Born: </h3>" + myStar.getDOB() +
                            "<h3> Act in: </h3>" + myStar.getMoviesOfStar(connection));
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
