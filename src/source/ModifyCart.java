package source;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Created by hongyangjiang on 8/15/16.
 */
@WebServlet("/ModifyCart")
public class ModifyCart extends HttpServlet {

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession mySession = request.getSession();
        Cart myCart = (Cart) mySession.getAttribute("shoppingcart");
        String movieID = request.getParameter("movieID");
        if (request.getParameter("delete") != null) {
            myCart.removeFromCart(movieID);
        } else if (request.getParameter("increase") != null) {
            myCart.increaseQuantity(movieID, 1);
        } else if (request.getParameter("decrease") != null) {
            myCart.decreaseQuantity(movieID, 1);
        }
        mySession.setAttribute("shoppingcart", myCart);
        RequestDispatcher view = request.getRequestDispatcher("/shoppingcart.jsp");
        view.forward(request, response);
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request, response);
    }
}
