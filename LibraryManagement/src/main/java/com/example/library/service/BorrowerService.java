package com.example.library.service;

import com.example.library.model.Borrower;
import com.example.library.model.Transaction;
import com.example.library.repository.BorrowerRepository;
import com.example.library.repository.TransactionRepository;
import com.example.library.repository.BookRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class BorrowerService {

    private final BorrowerRepository borrowerRepository;
    private final TransactionRepository transactionRepository;
    private final BookRepository bookRepository;

    public BorrowerService(BorrowerRepository borrowerRepository, TransactionRepository transactionRepository, BookRepository bookRepository) {
        this.borrowerRepository = borrowerRepository;
        this.transactionRepository = transactionRepository;
        this.bookRepository = bookRepository;
    }

    // Save a new borrower or update an existing one
    public Borrower saveBorrower(Borrower borrower) {
        return borrowerRepository.save(borrower);
    }

    // Get all borrowed books (transactions) for a specific borrower
    public List<Transaction> getBorrowedBooks(Long borrowerId) {
        return transactionRepository.findByBorrowerId(borrowerId);
    }

    // Borrow a book
    public void borrowBook(Long borrowerId, Long bookId) {
        // Create a new transaction
        Transaction transaction = new Transaction();
        transaction.setBorrower(borrowerRepository.findById(borrowerId).orElse(null));
        transaction.setBook(bookRepository.findById(bookId).orElse(null));
        transaction.setBorrowDate(LocalDate.now());
        transaction.setDueDate(LocalDate.now().plusDays(10)); // 2 weeks loan period
        transactionRepository.save(transaction);
    }

    // Mark the book as returned and update the return date
    public void returnBook(Long transactionId) {
        Transaction transaction = transactionRepository.findById(transactionId).orElse(null);
        if (transaction != null) {
            transaction.setReturnDate(LocalDate.now()); // Mark the return date as the current date
            transactionRepository.save(transaction);
        }
    }

    // Calculate fine based on the number of overdue days
    public long calculateFine(Long transactionId) {
        Transaction transaction = transactionRepository.findById(transactionId).orElse(null);
        if (transaction != null && transaction.getReturnDate() != null) {
            long overdueDays = ChronoUnit.DAYS.between(transaction.getDueDate(), transaction.getReturnDate());
            return overdueDays > 0 ? overdueDays * 5 : 0; // Fine of $5 per day for overdue days
        }
        return 0;
    }

    // Get a list of all borrowers
    public List<Borrower> getAllBorrowers() {
        return borrowerRepository.findAll();
    }

    // Check if a borrower has open transactions (i.e., books that are not returned)
    public boolean hasOpenTransactions(Long borrowerId) {
        List<Transaction> transactions = transactionRepository.findByBorrowerId(borrowerId);
        for (Transaction transaction : transactions) {
            if (transaction.getReturnDate() == null) {
                return true; // There is at least one open transaction
            }
        }
        return false; // All transactions are closed (returned)
    }
}
