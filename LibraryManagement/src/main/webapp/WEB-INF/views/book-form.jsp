<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.library.model.Author" %>
<%@ page import="com.example.library.model.Book" %>

<html>
<head>
    <title>Add/Edit Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%; /* Make the form narrower */
            max-width: 600px; /* Ensure it doesn't get too wide */
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 10px 0 5px;
            font-weight: bold;
        }

        input[type="text"], input[type="email"], textarea, select {
            padding: 10px;
            font-size: 1rem;
            width: 100%;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
        }

        input[type="radio"] {
            margin-right: 5px;
        }

        button {
            background-color: #333;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            border-radius: 5px;
            margin: 20px 0;
        }

        button:hover {
            background-color: #555;
        }

        .back-btn {
            display: inline-block;
            margin-top: 15px;
            background-color: #333;
            color: white;
            text-decoration: none;
            padding: 10px 15px;
            border-radius: 5px;
        }

        .back-btn:hover {
            background-color: #555;
        }

        /* Make form responsive */
        @media (max-width: 600px) {
            .container {
                width: 95%; /* Expand width on smaller screens */
            }

            input[type="text"], input[type="email"], textarea, select, button {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2><%= (request.getAttribute("book") == null || ((Book) request.getAttribute("book")).getId() == null) ? "Add New Book" : "Edit Book" %></h2>
        <form action="/books" method="post">

            <% 
                // Fetch the book and authors from the request attributes
                Book book = (Book) request.getAttribute("book");
                List<Author> authors = (List<Author>) request.getAttribute("authors");
            %>

            <!-- Book ID (hidden when editing an existing book) -->
            <%
                if (book != null && book.getId() != null) {
            %>
                <input type="hidden" name="id" value="<%= book.getId() %>" />
            <%
                }
            %>

            <!-- Book Title -->
            <div>
                <label>Title:</label>
                <input type="text" name="title" value="<%= book != null ? book.getTitle() : "" %>" required />
            </div>

            <!-- Book Description -->
            <div>
                <label>Description:</label>
                <textarea name="description" required><%= book != null ? book.getDescription() : "" %></textarea>
            </div>

            <!-- Author Dropdown -->
            <div>
                <label>Author:</label>
                <select name="author.id">
                    <%
                        if (authors != null) {
                            for (Author author : authors) {
                    %>
                                <option value="<%= author.getId() %>" <%= (book != null && book.getAuthor() != null && book.getAuthor().getId().equals(author.getId())) ? "selected" : "" %>>
                                    <%= author.getName() %>
                                </option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>

            <!-- Book Image URL -->
            <div>
                <label>Image URL:</label>
                <input type="text" name="imageUrl" value="<%= book != null ? book.getImageUrl() : "" %>" placeholder="Enter image URL" />
            </div>

            <!-- Availability Radio Buttons -->
            <div>
                <label>Available:</label>
                <input type="radio" name="available" value="true" <%= (book != null && book.isAvailable()) ? "checked" : "" %> /> Yes
                <input type="radio" name="available" value="false" <%= (book != null && !book.isAvailable()) ? "checked" : "" %> /> No
            </div>

            <!-- Submit Button -->
            <button type="submit"><%= (book != null && book.getId() != null) ? "Update Book" : "Add Book" %></button>

        </form>

        <!-- Back Button -->
        <a href="/books" class="back-btn">Back to Books</a>
    </div>

</body>
</html>
