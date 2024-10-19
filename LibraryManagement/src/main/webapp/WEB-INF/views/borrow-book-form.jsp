<html>
<head>
    <title>Borrow Book</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 50%; /* Adjust the width to make the form shorter */
            max-width: 400px; /* Ensure the form doesn't get too wide on larger screens */
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

        input[type="text"], input[type="email"] {
            padding: 10px;
            font-size: 1rem;
            width: 100%;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        button {
            background-color: #333;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            border-radius: 5px;
            margin-top: 20px;
        }

        button:hover {
            background-color: #555;
        }

        /* Make form responsive */
        @media (max-width: 600px) {
            .container {
                width: 95%; /* Expand the width on smaller screens */
            }

            input[type="text"], input[type="email"], button {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Borrow Book</h2>
        <form action="/borrowers/borrow/${bookId}" method="post">
            <input type="hidden" name="bookId" value="${bookId}" />
            <div>
                <label>Name:</label>
                <input type="text" name="name" required />
            </div>
            <div>
                <label>Email:</label>
                <input type="email" name="email" required />
            </div>
            <button type="submit">Borrow</button>
        </form>
    </div>

</body>
</html>
