package com.example.library.controller;

import com.example.library.model.Author;
import com.example.library.model.Book;
import com.example.library.repository.AuthorRepository;
import com.example.library.repository.BookRepository;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Controller
@RequestMapping("/authors")
public class AuthorController {

    private final AuthorRepository authorRepository;
    private final BookRepository bookRepository;

    public AuthorController(AuthorRepository authorRepository, BookRepository bookRepository) {
        this.authorRepository = authorRepository;
        this.bookRepository = bookRepository;
    }

    // List all authors
    @GetMapping
    public String getAllAuthors(Model model) {
        List<Author> authors = authorRepository.findAll();
        model.addAttribute("authors", authors);
        return "authors"; // Render authors.jsp
    }

    // Show form to create a new author
    @GetMapping("/new")
    public String createAuthorForm(Model model) {
        model.addAttribute("author", new Author());
        return "author-form"; // Render author-form.jsp
    }

    // Save or update an author (create or edit) with books
    @PostMapping
    public String createOrUpdateAuthor(@ModelAttribute Author author, @RequestParam("bookTitles") List<String> bookTitles) {
        // If the author ID is present, update the existing entry
        if (author.getId() != null) {
            Optional<Author> existingAuthor = authorRepository.findById(author.getId());
            if (existingAuthor.isPresent()) {
                Author updatedAuthor = existingAuthor.get();
                updatedAuthor.setName(author.getName());
                updatedAuthor.setEmail(author.getEmail());

                // Clear the old books and add new ones
                updatedAuthor.getBooks().clear();
                for (String bookTitle : bookTitles) {
                    if (!bookTitle.isEmpty()) {
                        updatedAuthor.getBooks().add(new Book(bookTitle, updatedAuthor));
                    }
                }

                authorRepository.save(updatedAuthor);
            }
        } else {
            // Create a new author with books
            List<Book> books = new ArrayList<>();
            for (String bookTitle : bookTitles) {
                if (!bookTitle.isEmpty()) {
                    books.add(new Book(bookTitle, author));
                }
            }
            author.setBooks(books);
            authorRepository.save(author); // Save the new author with books
        }

        return "redirect:/authors"; // Redirect to the list of authors
    }

    // Show form to edit an existing author
    @GetMapping("/edit/{id}")
    public String editAuthorForm(@PathVariable Long id, Model model) {
        Optional<Author> author = authorRepository.findById(id);
        if (author.isPresent()) {
            model.addAttribute("author", author.get());
            return "author-form"; // Render author-form.jsp
        }
        return "redirect:/authors"; // Redirect if not found
    }

    // Delete an author by ID
    @GetMapping("/delete/{id}")
    public String deleteAuthor(@PathVariable Long id) {
        if (authorRepository.existsById(id)) {
            authorRepository.deleteById(id);
        }
        return "redirect:/authors"; // Redirect to the list of authors after deletion
    }
}
