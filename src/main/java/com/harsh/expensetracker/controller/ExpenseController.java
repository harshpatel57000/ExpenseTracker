package com.harsh.expensetracker.controller;

import com.harsh.expensetracker.service.ExpenseService;


import org.springframework.web.bind.annotation.*;

import java.util.*;


import com.harsh.expensetracker.dto.ExpenseDTO;
import com.harsh.expensetracker.response.ApiResponse;

import jakarta.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;




@RestController
@RequestMapping("/api/expenses")
public class ExpenseController {
    private final ExpenseService expenseService;

    public ExpenseController(ExpenseService expenseService){
        this.expenseService=expenseService;
    }


    @GetMapping("/search")
    public ResponseEntity<List<ExpenseDTO>> getdata(@RequestParam String Category) {
        List<ExpenseDTO> returndata=expenseService.searchedData(Category);

        return ResponseEntity.ok(returndata);
    }
    
   @GetMapping("/page")
    public ResponseEntity<Page<ExpenseDTO>> someExpenses(Pageable pageable){
        Page<ExpenseDTO> expense=expenseService.someExpenses(pageable);
        return ResponseEntity.ok(expense);
    }
    @GetMapping
    public ResponseEntity<Map<String,List<ExpenseDTO>>> getAllExpenses(Pageable pageable){
        List<ExpenseDTO> expenses=expenseService.getAllExpenses(pageable);
        Map<String,List<ExpenseDTO>> response=new HashMap<>();
        response.put("List of All Expense",expenses);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/{id}")
    public ResponseEntity<ApiResponse<ExpenseDTO>> getExpenseById(@PathVariable Long id){
        ExpenseDTO expenseDTO= expenseService.getExpenseById(id);
        ApiResponse<ExpenseDTO> response=new ApiResponse<>(true,"Data is available",expenseDTO);
       return ResponseEntity.ok(response);
    }

    @PostMapping
    public ResponseEntity<ApiResponse<ExpenseDTO>> saveExpense(@Valid@RequestBody ExpenseDTO dto){
        ExpenseDTO savedExpense=expenseService.saveExpense(dto);
        ApiResponse<ExpenseDTO> response=new ApiResponse<>(true,"Expense Created Successfully",savedExpense);
        return new ResponseEntity<>(response,HttpStatus.CREATED);
    }
    @PutMapping("/{id}")
    public ResponseEntity<ApiResponse<ExpenseDTO>> updateExpense(@PathVariable Long id,@Valid@RequestBody ExpenseDTO dto) {
        ExpenseDTO updatedExpense =expenseService.updateExpense(id,dto);
        ApiResponse<ExpenseDTO> response=new ApiResponse<>(true,"Data update successfully",updatedExpense);
        return ResponseEntity.ok(response);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteExpense(@PathVariable Long id){

        expenseService.deleteExpense(id);
        return ResponseEntity.noContent().build();
    }

    @PatchMapping("/category")
    public ResponseEntity<ApiResponse<ExpenseDTO>> patchExpense(@PathVariable Long id,@RequestBody Map<String ,Object> updates){
        ExpenseDTO expenseDTO=expenseService.patchExpense(id,updates);
        ApiResponse<ExpenseDTO> response=new ApiResponse<>(true,"Data is Change",expenseDTO);
        return ResponseEntity.ok(response);
    }
    
}    

