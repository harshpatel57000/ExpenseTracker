package com.harsh.expensetracker.service;
import com.harsh.expensetracker.entity.Expense;
import com.harsh.expensetracker.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ExpenseService {
    @Autowired
    private ExpenseRepository expenserepository;

    public Expense saveExpense(Expense expense){
        return expenserepository.save(expense);
    }
    
    public List<Expense> getAllExpenses() {
        return expenserepository.findAll();
    }

    public Expense getExpenseByid(Long id){
        return expenserepository.findById(id).orElse(null);
    }
    
    public void deleteExpense(Long id){
        expenserepository.deleteById(id);
    }
}


