<html>
<head>
    <title>Return Confirmation</title>
</head>
<body>
    <h2>Book Returned</h2>
    <p>Your book has been successfully returned.</p>
    <c:if test="${fine > 0}">
        <p>You have a fine of $${fine} for returning the book late.</p>
    </c:if>
    <c:if test="${fine == 0}">
        <p>No fine applied. Thank you for returning the book on time!</p>
    </c:if>
    <a href="/books">Go back to Books</a>
</body>
</html>
