package com.harsh.expensetracker.service;
import com.harsh.expensetracker.entity.Expense;
import com.harsh.expensetracker.repository.ExpenseRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.harsh.expensetracker.dto.ExpenseDTO;
import com.harsh.expensetracker.mapper.ExpenseMapper;

import com.harsh.expensetracker.exception.ResourceNotFoundException;


import java.util.List;
import java.util.Map;
@Service
public class ExpenseService {
    @Autowired
    private ExpenseRepository expenserepository;

    public ExpenseDTO saveExpense(ExpenseDTO dto){
        Expense expense = ExpenseMapper.toEntity(dto);
        Expense savedExpense=expenserepository.save(expense);
        return ExpenseMapper.toDTO(savedExpense);
    }
    
    public List<ExpenseDTO> getAllExpenses() {
        return expenserepository.findAll().stream().map(ExpenseMapper::toDTO).toList();
    }

    public ExpenseDTO getExpenseById(Long id){
        Expense expense = expenserepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Wrong Table -- INDEX"));
        return ExpenseMapper.toDTO(expense);
    }
    
   /*public void deleteExpense(Long id){
        expenserepository.deleteById(id);
    }*/

    public ExpenseDTO updateExpense(Long id, ExpenseDTO dto) {
        
        Expense expense = expenserepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Expense not found"));

       expense.setTitle(dto.getTitle());
       expense.setAmount(dto.getAmount());
       expense.setCategory(dto.getCategory());
       expense.setDate(dto.getDate());
       expense.setDescription(dto.getDescription());

       Expense updatedExpense = expenserepository.save(expense);

       return ExpenseMapper.toDTO(updatedExpense);
    }


    public void deleteExpense(Long id){
        Expense expense = expenserepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Expense not found"));
        expenserepository.delete(expense);
    } 

    public ExpenseDTO patchExpense(Long id,Map<String,Object> updates){
        Expense expense = expenserepository.findById(id).orElseThrow(() -> new ResourceNotFoundException("Expense not found"));
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
        return ExpenseMapper.toDTO(expenserepository.save(expense));
    }
}


