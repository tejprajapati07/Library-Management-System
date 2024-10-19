package com.example.library.repository;

import com.example.library.model.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface TransactionRepository extends JpaRepository<Transaction, Long> {

    // Find all transactions for a specific borrower
    List<Transaction> findByBorrowerId(Long borrowerId);

    // Check if a specific borrower has already borrowed a book and not returned it
    boolean existsByBorrowerIdAndBookIdAndReturnDateIsNull(Long borrowerId, Long bookId);
}
