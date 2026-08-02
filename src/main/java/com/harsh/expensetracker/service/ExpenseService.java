package com.harsh.expensetracker.service;
import com.harsh.expensetracker.entity.Expense;
import com.harsh.expensetracker.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
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

    public Expense getExpenseById(Long id){
        return expenserepository.findById(id).orElseThrow(() -> new RuntimeException("Expense not found"));
    }
    
   /*public void deleteExpense(Long id){
        expenserepository.deleteById(id);
    }*/

    public Expense updateExpense(Long id, Expense updatedExpense) {

        Expense expense = expenserepository.findById(id)
            .orElseThrow(() -> new RuntimeException("Expense not found"));

       expense.setTitle(updatedExpense.getTitle());
       expense.setAmount(updatedExpense.getAmount());
       expense.setCategory(updatedExpense.getCategory());
       expense.setDate(updatedExpense.getDate());
       expense.setDescription(updatedExpense.getDescription());

       return expenserepository.save(expense);
    }


    public void deleteExpense(Long id){
        Expense expense = expenserepository.findById(id).orElseThrow(() -> new RuntimeException("Expense not found"));
        expenserepository.delete(expense);
    } 

    public Expense patchExpense(Long id,Map<String,Object> updates){
        Expense expense = expenserepository.findById(id).orElseThrow(() -> new RuntimeException("Expense not found"));
        if(updates.containsKey("title")){
            expense.setTitle((String) updates.get("title"));

        }
        if(updates.containsKey("amount")){
            expense.setAmount((Double.valueOf(updates.get("amount").toString())));

        }
        if(updates.containsKey("category")){
            expense.setCategory ((String) updates.get("category"));
        }
        if(updates.containsKey("description")){
            expense.setDescription((String) updates.get("description"));
        }
        return expenserepository.save(expense);
    }
}


