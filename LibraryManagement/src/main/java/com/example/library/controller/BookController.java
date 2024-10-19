package com.example.library.controller;

import com.example.library.model.Author;
import com.example.library.model.Book;
import com.example.library.repository.AuthorRepository;
import com.example.library.repository.BookRepository;
import com.example.library.repository.TransactionRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/books")
public class BookController {

    private final BookRepository bookRepository;
    private final AuthorRepository authorRepository;
    private final TransactionRepository transactionRepository;

    public BookController(BookRepository bookRepository, AuthorRepository authorRepository, TransactionRepository transactionRepository) {
        this.bookRepository = bookRepository;
        this.authorRepository = authorRepository;
        this.transactionRepository = transactionRepository;
    }

    // List all books
    @GetMapping
    public String getAllBooks(Model model, @RequestParam(value = "borrowerId", required = false) Long borrowerId) {
        List<Book> books = bookRepository.findAll();
        Map<Long, Boolean> bookBorrowedMap = new HashMap<>();

        // Check if borrowerId is provided
        if (borrowerId != null) {
            // Check if the borrower has already borrowed each book
            for (Book book : books) {
                boolean alreadyBorrowed = transactionRepository.existsByBorrowerIdAndBookIdAndReturnDateIsNull(borrowerId, book.getId());
                bookBorrowedMap.put(book.getId(), alreadyBorrowed);
            }
        }

        model.addAttribute("books", books);
        model.addAttribute("bookBorrowedMap", bookBorrowedMap); // Pass the map to JSP (if available)
        model.addAttribute("borrowerId", borrowerId);  // Still pass the borrowerId even if it's null
        return "books";  // books.jsp view
    }


    // Show form to create a new book
    @GetMapping("/new")
    public String createBookForm(Model model) {
        model.addAttribute("book", new Book());
        List<Author> authors = authorRepository.findAll();
        model.addAttribute("authors", authors);
        return "book-form";  // book-form.jsp view
    }

    // Save a new book or update an existing one
    @PostMapping
    public String saveOrUpdateBook(@ModelAttribute Book book, @RequestParam("available") boolean isAvailable) {
        book.setAvailable(isAvailable);  // Handle the availability radio buttons
        bookRepository.save(book);
        return "redirect:/books";
    }

    // Show form to edit an existing book
    @GetMapping("/edit/{id}")
    public String editBookForm(@PathVariable Long id, Model model) {
        Optional<Book> book = bookRepository.findById(id);
        if (book.isPresent()) {
            model.addAttribute("book", book.get());
            List<Author> authors = authorRepository.findAll();
            model.addAttribute("authors", authors);
            return "book-form";  // book-form.jsp view
        }
        return "redirect:/books";  // If the book is not found, redirect to the books list
    }

    // Delete a book by ID
    @GetMapping("/delete/{id}")
    public String deleteBook(@PathVariable Long id) {
        bookRepository.deleteById(id);
        return "redirect:/books";
    }
}