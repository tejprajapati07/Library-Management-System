<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.library.model.Author" %>
<%@ page import="com.example.library.model.Book" %>

<html>
<head>
    <title>Authors</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h2 {
            color: #333;
            text-align: center;
        }

        .container {
            width: 80%;
            margin: 0 auto;
        }

        .button-back {
            background-color: #333;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            text-align: center;
            cursor: pointer;
            margin-bottom: 20px;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }

        .button-back:hover {
            background-color: #555;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #333;
            color: white;
        }

        td a {
            text-decoration: none;
            color: #007bff;
        }

        td a:hover {
            text-decoration: underline;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            table, th, td {
                font-size: 14px;
            }

            .button-back {
                padding: 8px 12px;
                font-size: 14px;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <!-- Back to Home Button -->
    <a href="/" class="button-back">&larr; Back to Home</a>

    <!-- Authors Table -->
    <h2>Authors</h2>
    <a href="/authors/new" class="button-back">Add New Author</a>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Books</th>
            <th>Actions</th>
        </tr>

        <%-- Access the authors list passed from the controller --%>
        <%
            List<Author> authors = (List<Author>) request.getAttribute("authors");
            if (authors != null) {
                for (Author author : authors) {
        %>
        <tr>
            <td><%= author.getId() %></td>
            <td><%= author.getName() %></td>
            <td><%= author.getEmail() %></td>
            <td>
                <%-- Display the list of books written by the author --%>
                <%
                    List<Book> books = author.getBooks();
                    if (books != null && !books.isEmpty()) {
                        for (Book book : books) {
                            out.print(book.getTitle() + "<br/>");
                        }
                    } else {
                        out.print("No books available");
                    }
                %>
            </td>
            <td>
                <a href="/authors/edit/<%= author.getId() %>">Edit</a> |
                <a href="/authors/delete/<%= author.getId() %>" onclick="return confirm('Are you sure you want to delete this author?');">Delete</a>
            </td>
        </tr>
        <%
                }
            }
        %>
    </table>
</div>

</body>
</html>
