<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.example.library.model.Book" %>

<html>
<head>
    <title>Books</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        .header {
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
        }

        .card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            width: 250px;
            padding: 15px;
            margin: 15px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .card img {
            width: 100px;
            height: auto;
            margin-bottom: 10px;
        }

        .card h3 {
            margin: 10px 0;
            font-size: 1.2em;
            color: #333;
        }

        .card p {
            font-size: 0.9em;
            color: #666;
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            padding: 8px 12px;
            background-color: #333;
            color: #fff;
            border-radius: 5px;
            text-decoration: none;
            font-size: 0.9em;
        }

        .card a:hover {
            background-color: #555;
        }

        /* Back to home button */
        .back-button {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 15px;
            background-color: #333;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .back-button:hover {
            background-color: #555;
        }

        /* Responsive design */
        @media (max-width: 768px) {
            .card {
                width: 100%;
                margin-bottom: 20px;
            }

            .container {
                justify-content: center;
            }

            .back-button {
                font-size: 0.9em;
            }
        }
    </style>
</head>
<body>

    <div class="header">
        <h2>Books</h2>
        <a href="/" class="back-button">&larr; Back to Home</a> <!-- Back to Home button -->
        <a href="/books/new" class="back-button">Add New Book</a>
    </div>

    <div class="container">
        <% 
            List<Book> books = (List<Book>) request.getAttribute("books"); 
            Map<Long, Boolean> bookBorrowedMap = (Map<Long, Boolean>) request.getAttribute("bookBorrowedMap");
            Long borrowerId = (Long) request.getAttribute("borrowerId");

            if (books != null) {
                for (Book book : books) {
                    Boolean alreadyBorrowed = (bookBorrowedMap != null) ? bookBorrowedMap.get(book.getId()) : null;
        %>
        <div class="card">
            <h3><%= book.getTitle() %></h3>
            <p><strong>Author:</strong> <%= book.getAuthor().getName() %></p>
            <p><strong>Description:</strong> <%= book.getDescription() != null ? book.getDescription() : "No description" %></p>
            <div>
                <% if (book.getImageUrl() != null && !book.getImageUrl().isEmpty()) { %>
                    <img src="<%= book.getImageUrl() %>" alt="<%= book.getTitle() %>" />
                <% } else { %>
                    <p>No Image Available</p>
                <% } %>
            </div>
            <p><strong>Availability:</strong> <%= book.isAvailable() ? "Available" : "Not Available" %></p>
            <div>
                <% if ((alreadyBorrowed == null || !alreadyBorrowed) && book.isAvailable()) { %>
                    <a href="/borrowers/borrow/<%= book.getId() %>?borrowerId=<%= borrowerId %>">Borrow</a>
                <% } %>
                <a href="/books/edit/<%= book.getId() %>">Edit</a> |
                <a href="/books/delete/<%= book.getId() %>" onclick="return confirm('Are you sure you want to delete this book?');">Delete</a>
            </div>
        </div>
        <% 
                }
            } 
        %>
    </div>

</body>
</html>
