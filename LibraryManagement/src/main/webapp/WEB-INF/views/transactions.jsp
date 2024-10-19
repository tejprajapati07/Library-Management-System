<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.library.model.Transaction" %>

<html>
<head>
    <title>Borrower Transactions</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
            font-size: 2rem;
            margin-bottom: 30px;
        }

        .transaction-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin: 0 auto;
            width: 90%;
        }

        .transaction-card {
            background-color: #fff;
            border-radius: 10px;
            padding: 20px;
            width: 320px;
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .transaction-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0, 0, 0, 0.2);
        }

        .transaction-card h3 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 15px;
        }

        .transaction-card p {
            font-size: 1rem;
            color: #666;
            margin: 10px 0;
        }

        .return-btn {
            background-color: #28a745;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            border-radius: 5px;
            margin-top: 15px;
            transition: background-color 0.3s;
        }

        .return-btn:hover {
            background-color: #218838;
        }

        .returned {
            color: #28a745;
            font-weight: bold;
            font-size: 1.1rem;
        }

        /* Style for fine */
        .fine-amount {
            font-size: 1rem;
            color: #ff6347;
            font-weight: bold;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .transaction-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>

    <h2>Borrower Transactions</h2>
    <div class="transaction-container">
        <% 
            List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
            Map<Long, Long> fines = (Map<Long, Long>) request.getAttribute("fines");

            if (transactions != null) {
                for (Transaction transaction : transactions) {
                    Long fine = (fines != null) ? fines.get(transaction.getId()) : 0L; // Safe access to fines map
        %>
        <div class="transaction-card">
            <h3>Transaction ID: <%= transaction.getId() %></h3>
            <p><strong>Book Title:</strong> <%= transaction.getBook().getTitle() %></p>
            <p><strong>Borrow Date:</strong> <%= transaction.getBorrowDate() %></p>
            <p><strong>Due Date:</strong> <%= transaction.getDueDate() %></p>
            <p><strong>Return Date:</strong> <%= transaction.getReturnDate() != null ? transaction.getReturnDate() : "Not Returned" %></p>
            <p class="fine-amount"><strong>Fine:</strong> <%= fine %> USD</p>

            <% if (transaction.getReturnDate() == null) { %>
                <form action="/borrowers/return/<%= transaction.getId() %>" method="post">
                    <input type="hidden" name="borrowerId" value="<%= transaction.getBorrower().getId() %>"> <!-- Pass borrower ID -->
                    <button type="submit" class="return-btn">Return Book</button>
                </form>
            <% } else { %>
                <p class="returned">Returned</p>
            <% } %>
        </div>
        <% 
                }
            }
        %>
    </div>

</body>
</html>
