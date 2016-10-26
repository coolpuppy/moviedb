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

    <title>Welcome to Fabflix</title>

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

    <!-- Main component for a primary marketing message or call to action -->
    <form class="form" action="/Fabflix/Checkout" method="post">
        <h3>Please enter your credit card information</h3>
        <label for="cardID">Card Number</label>
        <input type="text" id="cardID" name = "cardID" class="form-control" required autofocus>
        <label for="expiredDate">Password</label>
        <input type="date" id="expiredDate" name = "expireDate" class="form-control" placeholder="MM/DD/YYYY" required>
        <label for="firstname">First Name</label>
        <input type="text" id="firstname" name="firstname" class="form-control" required>
        <label for="lastname">Last Name</label>
        <input type="text" id="lastname" name="lastname" class="form-control" required>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Next</button>
    </form>

</div> <!-- /container -->


<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="../../assets/js/vendor/jquery.min.js"><\/script>')</script>
<script src="bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
