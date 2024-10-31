# Library Management System

This is a **Library Management System** built using **Spring Boot**. It provides functionality to manage library resources, including books, authors, and users. The system allows users to perform various operations such as borrowing, returning books, and tracking available books in the library. It is designed to be simple, scalable, and maintainable.

## Features

- **User Management**: Allows the registration of new users (students, librarians) and provides authentication for existing users.
- **Book Management**: Add, update, and delete books in the system, with details like title, author, genre, and publication date.
- **Borrow and Return Books**: Users can borrow and return books, with validations on availability and due dates.
- **Book Availability Tracking**: Displays available copies of books and updates when books are borrowed or returned.
- **Search Functionality**: Users can search for books by title, author, or genre.
- **Role-Based Access**: Different access levels for librarians (administrative tasks) and users (book borrowing/return).
- **Error Handling and Validations**: Comprehensive error handling for invalid operations (e.g., trying to borrow unavailable books).
- **Database Integration**: Uses a relational database (e.g., MySQL, PostgreSQL) for persistent storage of library data.
- **RESTful API**: Exposes a set of RESTful APIs to manage the library, suitable for integrating with frontend interfaces.

## Tech Stack

- **Backend**: Spring Boot, Spring MVC, Spring Data JPA
- **Database**: MySQL (or any other relational database, configurable)
- **Security**: Spring Security with JWT for authentication and authorization
- **Build Tool**: Maven
- **Deployment**: Can be deployed on any server that supports Spring Boot (e.g., Tomcat)

## Screenshots

![Screenshot 2024-10-20 014555](https://github.com/user-attachments/assets/5aee7f95-a025-496b-8921-f33084198231)
![Screenshot 2024-10-20 014606](https://github.com/user-attachments/assets/5727f1a5-d9d0-40d8-a937-10717c04fe38)
![Screenshot 2024-10-20 014617](https://github.com/user-attachments/assets/7b43cb93-d0bd-46a5-b964-32677bbf42e6)
![Screenshot 2024-10-20 014637](https://github.com/user-attachments/assets/db0a17ad-7d67-4d72-b9a7-db742a5c9c07)
![Screenshot 2024-10-20 014648](https://github.com/user-attachments/assets/ecb3b802-6fd4-478b-a1b9-e9a72c07e3bc)
![Screenshot 2024-10-20 014656](https://github.com/user-attachments/assets/18d5a674-f473-4ac9-adce-5272f785960a)
![Screenshot 2024-10-20 014706](https://github.com/user-attachments/assets/cdc50791-b47d-4cf8-a841-8453cfa46675)

