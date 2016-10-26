package source;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

@WebServlet("/Login")
public class Login extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        PrintWriter out = response.getWriter();
        out.println("<h1> username: " + username + "</h1>");
        out.println("<h1> password: " + password + "</h1>");
        HttpSession mySession = request.getSession(true);
        try {
            /*Context ctx = new InitialContext();
            DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/moviedb");
            Connection connection = ds.getConnection();*/
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            Connection connection = DriverManager.getConnection("jdbc:mysql:///moviedb","root", "jhy921101");
            Statement statement =  connection.createStatement();
            String query = "SELECT * FROM customers WHERE email = '" + username + "'";
            ResultSet resultSet = statement.executeQuery(query);
            User customer = null;
            while (resultSet.next()) {
                customer = new User();
                customer.setID(resultSet.getString("id"));
                customer.setFirst_name(resultSet.getString("first_name"));
                customer.setLast_name(resultSet.getString("last_name"));
                customer.setEmail(resultSet.getString("email"));
                customer.setPassword(resultSet.getString("password"));
            }
            if (customer != null && customer.getPassword().equals(password)) {
                out.println("<h1> Login Successful! </h1>");
                mySession.setAttribute("user_object", customer);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/main.html");
                dispatcher.forward(request, response);
            } else {
                RequestDispatcher dispatcher = request.getRequestDispatcher("/login_failed.html");
                dispatcher.forward(request, response);
                doPost(request, response);
            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
