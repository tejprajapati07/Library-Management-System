<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Library Management System</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }

        .header {
            background-color: #3a3a3a;
            color: white;
            padding: 20px 0;
            text-align: center;
        }

        .header h1 {
            margin: 0;
            font-size: 2.5em;
        }

        .quote {
            margin-top: 10px;
            font-size: 1.2em;
            color: #ccc;
        }

        .container {
            width: 80%;
            margin: 40px auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
        }

        .card {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 10px;
            width: 30%;
            padding: 25px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card:hover {
            transform: translateY(-10px);
        }

        .card h3 {
            margin-bottom: 15px;
            font-size: 1.6em;
            color: #333;
        }

        .card p {
            font-size: 1.2em;
            color: #666;
        }

        /* Centered and small arrow button */
        .card a {
            display: inline-block;
            margin-top: 10px;
            background-color: #333;
            color: white;
            border-radius: 50%;
            text-align: center;
            width: 40px;
            height: 40px;
            line-height: 40px; /* Ensures the arrow is centered vertically */
            font-size: 1.2em;
            margin-left: auto;
            margin-right: auto;
        }

        .card a i {
            vertical-align: middle; /* Centers the icon */
        }

        .card a:hover {
            background-color: #555;
        }

        /* Responsive Design */
        @media screen and (max-width: 1024px) {
            .container {
                flex-wrap: wrap;
                justify-content: center;
            }
        }

        @media screen and (max-width: 768px) {
            .container {
                flex-direction: column;
            }

            .card {
                width: 80%;
            }
        }
    </style>
</head>
<body>

    <div class="header">
        <h1><i class="fas fa-book-reader"></i> Library Management System</h1>
        <p class="quote">"A library is not a luxury but one of the necessities of life." - Henry Ward Beecher</p>
    </div>

    <div class="container">
        <!-- Author Card -->
        <div class="card">
            <h3>Authors</h3>
            <p>Manage all authors in the library system.</p>
            <a href="/authors"><i class="fas fa-arrow-right"></i></a>
        </div>

        <!-- Books Card -->
        <div class="card">
            <h3>Books</h3>
            <p>View and manage books available in the library.</p>
            <a href="/books"><i class="fas fa-arrow-right"></i></a>
        </div>

        <!-- Borrowers Card -->
        <div class="card">
            <h3>Borrowers</h3>
            <p>View all borrowers and manage their transactions.</p>
            <a href="/borrowers"><i class="fas fa-arrow-right"></i></a>
        </div>
    </div>

</body>
</html>
