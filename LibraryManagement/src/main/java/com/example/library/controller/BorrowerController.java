package com.example.library.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.library.model.Borrower;
import com.example.library.model.Transaction;
import com.example.library.service.BookService;
import com.example.library.service.BorrowerService;

@Controller
@RequestMapping("/borrowers")
public class BorrowerController {

    private final BorrowerService borrowerService;
    private final BookService bookService;

    public BorrowerController(BorrowerService borrowerService, BookService bookService) {
        this.borrowerService = borrowerService;
        this.bookService = bookService;
    }

    // List all borrowers and determine their status (Open/Closed)
    @GetMapping
    public String getAllBorrowers(Model model) {
        List<Borrower> borrowers = borrowerService.getAllBorrowers();

        // Create a map to store borrower statuses (Open/Closed)
        Map<Long, String> borrowerStatuses = new HashMap<>();

        // Loop through each borrower and determine if they have open transactions
        for (Borrower borrower : borrowers) {
            List<Transaction> transactions = borrowerService.getBorrowedBooks(borrower.getId());
            boolean hasOpenTransactions = false;

            for (Transaction transaction : transactions) {
                if (transaction.getReturnDate() == null) {
                    hasOpenTransactions = true;
                    break;
                }
            }

            borrowerStatuses.put(borrower.getId(), hasOpenTransactions ? "Open" : "Closed");
        }

        model.addAttribute("borrowers", borrowers);
        model.addAttribute("borrowerStatuses", borrowerStatuses); // Pass borrower statuses to the view
        return "borrowers"; // Render borrowers.jsp
    }

    // Show form to borrow a book
    @GetMapping("/borrow/{bookId}")
    public String borrowBookForm(@PathVariable Long bookId, Model model) {
        model.addAttribute("borrower", new Borrower());
        model.addAttribute("bookId", bookId);
        return "borrow-book-form"; // Render borrow-book-form.jsp
    }

    // Borrow a book
    @PostMapping("/borrow/{bookId}")
    public String borrowBook(@PathVariable Long bookId, @ModelAttribute Borrower borrower) {
        Borrower savedBorrower = borrowerService.saveBorrower(borrower);
        borrowerService.borrowBook(savedBorrower.getId(), bookId);
        return "redirect:/books"; // Redirect to the list of books after borrowing
    }

    // Show list of borrowed books (transactions) with fines
    @GetMapping("/{id}/transactions")
    public String getBorrowedBooks(@PathVariable Long id, Model model) {
        List<Transaction> transactions = borrowerService.getBorrowedBooks(id);

        // Calculate fines for each transaction
        Map<Long, Long> fines = new HashMap<>();
        for (Transaction transaction : transactions) {
            long fine = borrowerService.calculateFine(transaction.getId());
            fines.put(transaction.getId(), fine); // Store fine for each transaction
        }

        model.addAttribute("transactions", transactions);
        model.addAttribute("fines", fines); // Pass fines map to the view
        return "transactions"; // Render transactions.jsp
    }

    // Return a book and calculate fine
    @PostMapping("/return/{transactionId}")
    public String returnBook(@PathVariable Long transactionId, @RequestParam("borrowerId") Long borrowerId) {
        // Mark the book as returned and update the return date
        borrowerService.returnBook(transactionId);
        
        // Redirect to the borrower's transactions after returning the book
        return "redirect:/borrowers/" + borrowerId + "/transactions"; // Correctly include the borrower ID in the URL
    }
}
