import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/CateringServlet")
public class CateringServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect("index.html");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");
        String[] selectedFoods = request.getParameterValues("food"); // get all selected checkboxes
        String guestsStr = request.getParameter("guests"); // number of guests
        int numberOfGuests = 1;

        try {
            numberOfGuests = Integer.parseInt(guestsStr);
            if (numberOfGuests < 1) numberOfGuests = 1;
        } catch (Exception e) {
            numberOfGuests = 1;
        }

        if (selectedFoods == null || selectedFoods.length == 0) {
            response.getWriter().println("No food items selected.");
            return;
        }

        StringBuilder foodItems = new StringBuilder();
        int totalPrice = 0;

        for (String item : selectedFoods) {
            // item format: "FoodName:Price"
            String[] parts = item.split(":");
            String foodName = parts[0];
            int pricePerItem = Integer.parseInt(parts[1]);
            foodItems.append(foodName).append(","); // append name
            totalPrice += pricePerItem * numberOfGuests; // multiply by number of guests
        }

        if (foodItems.length() > 0) {
            foodItems.setLength(foodItems.length() - 1); // remove last comma
        }

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "manager");

            String sql = "UPDATE registration SET cfi = ?, cfp = ?, guests = ? WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, foodItems.toString());
            ps.setInt(2, totalPrice);
            ps.setInt(3, numberOfGuests); // store number of guests
            ps.setString(4, userEmail);

            int updated = ps.executeUpdate();
            if (updated > 0) {
                response.sendRedirect("events.jsp");
            } else {
                response.getWriter().println("Error: Could not update food selection. Please try again.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            if (ps != null) try { ps.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception e) {}
        }
    }
}
