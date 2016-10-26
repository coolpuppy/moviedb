<%@ page import="source.Movie" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="source.Cart" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %><%--
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

    <title>Shopping Cart</title>

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
                    <li class="active"><a href="shoppingcart.jsp">Shopping Cart</a></li>
                    <li><a href="/Fabflix/Logout">Log Out</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
    </nav>
    <h2 class="sub-header">Shopping Cart</h2>
    <div>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb", "root", "jhy921101");
                HttpSession mySession = request.getSession();
                Cart myCart = (Cart) mySession.getAttribute("shoppingcart");
                if (myCart == null) {
                    myCart = new Cart();
                    mySession.setAttribute("shoppingcart", myCart);
                }
                Map<String, Integer> items = myCart.getItems();
                String movieIDSet = "";
                int index = 0;
                for (String movieID : items.keySet()) {
                    movieIDSet = movieIDSet + movieID;
                    if (index < items.keySet().size() - 1) {
                        movieIDSet = movieIDSet + ",";
                    }
                    index++;
                }
                String query = "SELECT * FROM movies where id in (" + movieIDSet + ")";
                Statement statement = connection.createStatement();
                ResultSet result = statement.executeQuery(query);
                while (result.next()) {
                    String movieID = result.getString("id");
                    out.println("<a href='movieinfo.jsp?id='" + movieID + "'><span> Movie Title: " + result.getString("title") + "</span></a>");
                    out.println("<span> Year: " + result.getString("year") + "</span>");
                    out.println("<span> Quantity: " + items.get(movieID) + "</span>");
                %>
                    <form method="post" action="/Fabflix/ModifyCart">
                        <input type="submit" name="delete" value="Delete">
                        <input type="submit" name="increase" value="Increase">
                        <input type="submit" name="decrease" value="Decrease">
                        <input type="hidden" name="movieID" value="<%out.print(movieID);%>">
                    </form>
                <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </div>
    <div>
        <form method="post" action="checkout.jsp">
            <input type="submit" name="checkout" value="Checkout">
        </form>
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