<html>
<head>
    <title>Add/Edit Author</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 20px;
        }

        h2, h3 {
            color: #333;
            text-align: center;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="email"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        button {
            background-color: #333;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            font-size: 14px;
            margin-top: 10px;
        }

        button:hover {
            background-color: #555;
        }

        .button-back {
            background-color: #333;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            text-align: center;
            margin-bottom: 20px;
            text-decoration: none;
            display: inline-block;
            font-size: 14px;
        }

        .button-back:hover {
            background-color: #555;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .container {
                padding: 15px;
            }

            input[type="text"],
            input[type="email"] {
                font-size: 13px;
            }

            button, .button-back {
                font-size: 13px;
                padding: 7px 10px;
            }
        }
    </style>

    <script>
        // Function to dynamically add new book input fields
        function addBookField() {
            var bookFields = document.getElementById("bookFields");
            var newField = document.createElement("div");
            newField.innerHTML = '<input type="text" name="bookTitles" placeholder="Book Title" />';
            bookFields.appendChild(newField);
        }
    </script>
</head>
<body>

<div class="container">
    <!-- Back to Authors Button -->
    <a href="/authors" class="button-back">&larr; Back to Authors</a>

    <h2>${author.id == null ? 'Add Author' : 'Edit Author'}</h2>
    <form action="/authors" method="post">
        <!-- Include the ID field as a hidden input if we're editing -->
        <c:if test="${author.id != null}">
            <input type="hidden" name="id" value="${author.id}" />
        </c:if>

        <!-- Author Information -->
        <div>
            <label>Name:</label>
            <input type="text" name="name" value="${author.name}" required />
        </div>
        <div>
            <label>Email:</label>
            <input type="email" name="email" value="${author.email}" required />
        </div>

        <!-- Books Section -->
        <h3>Books</h3>
        <div id="bookFields">
            <!-- If editing, display existing books -->
            <c:if test="${author.id != null}">
                <c:forEach var="book" items="${author.books}">
                    <div>
                        <input type="text" name="bookTitles" value="${book.title}" placeholder="Book Title" />
                    </div>
                </c:forEach>
            </c:if>
        </div>

        <!-- Button to Add More Book Input Fields -->
        <button type="button" onclick="addBookField()">Add Book</button>

        <!-- Submit Button -->
        <button type="submit">${author.id == null ? 'Add' : 'Update'}</button>
    </form>
</div>

</body>
</html>
