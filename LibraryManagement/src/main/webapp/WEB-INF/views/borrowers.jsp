<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.library.model.Borrower" %>

<html>
<head>
    <title>Borrowers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #333;
            color: white;
        }

        td {
            background-color: #fff;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        a {
            text-decoration: none;
            color: white;
            padding: 8px 12px;
            background-color: #333;
            border-radius: 4px;
            font-size: 0.9rem;
        }

        a:hover {
            background-color: #555;
        }

        .status-open {
            color: green;
            font-weight: bold;
        }

        .status-closed {
            color: red;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            table {
                width: 100%;
            }

            th, td {
                font-size: 0.9rem;
                padding: 8px;
            }

            a {
                font-size: 0.8rem;
                padding: 6px 10px;
            }
        }
    </style>
</head>
<body>

    <h2>Borrowers</h2>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Status</th> <!-- Status column -->
            <th>Actions</th>
        </tr>

        <% 
            List<Borrower> borrowers = (List<Borrower>) request.getAttribute("borrowers");
            Map<Long, String> borrowerStatuses = (Map<Long, String>) request.getAttribute("borrowerStatuses");

            if (borrowers != null) {
                for (Borrower borrower : borrowers) {
        %>
        <tr>
            <td><%= borrower.getId() %></td>
            <td><%= borrower.getName() %></td>
            <td><%= borrower.getEmail() %></td>
            <td>
                <% String status = borrowerStatuses.get(borrower.getId()); %>
                <span class="<%= "Open".equals(status) ? "status-open" : "status-closed" %>">
                    <%= status %>
                </span> <!-- Display Open or Closed based on transaction status -->
            </td>
            <td>
                <a href="/borrowers/<%= borrower.getId() %>/transactions">View Transactions</a>
            </td>
        </tr>
        <% 
                }
            }
        %>
    </table>

</body>
</html>
