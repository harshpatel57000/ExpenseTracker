package com.harsh.expensetracker.controller;

import com.harsh.expensetracker.service.ExpenseService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import java.util.Map;


import com.harsh.expensetracker.dto.ExpenseDTO;

import jakarta.validation.Valid;



@RestController
@RequestMapping("/api/expenses")
public class ExpenseController {
    private final ExpenseService expenseService;

    public ExpenseController(ExpenseService expenseService){
        this.expenseService=expenseService;
    }


    @GetMapping
    public List<ExpenseDTO> getAllExpenses(){
        return expenseService.getAllExpenses();
    }
    @GetMapping("/{id}")
    public ExpenseDTO getExpenseById(@PathVariable Long id){
       return expenseService.getExpenseById(id);
    }

    @PostMapping
    public ExpenseDTO saveExpense(@Valid@RequestBody ExpenseDTO dto){
        return expenseService.saveExpense(dto);
    }
    @PutMapping("/{id}")
    public ExpenseDTO updateExpense(@PathVariable Long id,@Valid@RequestBody ExpenseDTO dto) {
        return expenseService.updateExpense(id,dto);
    }

    @DeleteMapping("/{id}")
    public void deleteExpense(@PathVariable Long id){
        expenseService.deleteExpense(id);
    }

    @PatchMapping("/{id}")
    public ExpenseDTO patchExpense(@PathVariable Long id,@RequestBody Map<String ,Object> updates){
        return expenseService.patchExpense(id,updates);
    }
    
}    

