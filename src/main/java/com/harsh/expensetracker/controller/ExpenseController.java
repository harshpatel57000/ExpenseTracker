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

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;




@RestController
@RequestMapping("/api/expenses")
public class ExpenseController {
    private final ExpenseService expenseService;

    public ExpenseController(ExpenseService expenseService){
        this.expenseService=expenseService;
    }


    @GetMapping
    public ResponseEntity<List<ExpenseDTO>> getAllExpenses(){
        List<ExpenseDTO> expenses=expenseService.getAllExpenses();
        return ResponseEntity.ok(expenses);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ExpenseDTO> getExpenseById(@PathVariable Long id){
        ExpenseDTO expenseDTO= expenseService.getExpenseById(id);
       return ResponseEntity.ok(expenseDTO);
    }

    @PostMapping
    public ResponseEntity<ExpenseDTO> saveExpense(@Valid@RequestBody ExpenseDTO dto){
        ExpenseDTO savedExpense=expenseService.saveExpense(dto);
        return new ResponseEntity<>(savedExpense,HttpStatus.CREATED);
    }
    @PutMapping("/{id}")
    public ResponseEntity<ExpenseDTO> updateExpense(@PathVariable Long id,@Valid@RequestBody ExpenseDTO dto) {
        ExpenseDTO updatedExpense =expenseService.updateExpense(id,dto);
        return ResponseEntity.ok(updatedExpense);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExpense(@PathVariable Long id){

        expenseService.deleteExpense(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/{id}")
    public ResponseEntity<String> patchExpense(@PathVariable Long id,@RequestBody Map<String ,Object> updates){
        expenseService.patchExpense(id,updates);
        
        return ResponseEntity.ok("data update successfuly");
    }
    
}    

