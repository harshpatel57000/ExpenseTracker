package com.harsh.expensetracker.controller;
import com.harsh.expensetracker.entity.Expense;
import com.harsh.expensetracker.service.ExpenseService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.PathVariable;
import java.util.Map;



@RestController
@RequestMapping("/api/expenses")
public class ExpenseController {
    private final ExpenseService expenseService;

    public ExpenseController(ExpenseService expenseService){
        this.expenseService=expenseService;
    }


    @GetMapping
    public List<Expense> getAllExpenses(){
        return expenseService.getAllExpenses();
    }
    @GetMapping("/{id}")
    public Expense getExpenseById(@PathVariable Long id){
        return expenseService.getExpenseById(id);
    }

    @PostMapping
    public Expense saveExpense(@RequestBody Expense expense){
        return expenseService.saveExpense(expense);
    }
    @PutMapping("/{id}")
    public Expense updateExpense(@PathVariable Long id, @RequestBody Expense expense) {
        return expenseService.updateExpense(id,expense);
    }

    @DeleteMapping("/{id}")
    public void deleteExpense(@PathVariable Long id){
        expenseService.deleteExpense(id);
    }

    @PatchMapping("/{id}")
    public Expense patchExpense(@PathVariable Long id,@RequestBody Map<String ,Object> updates){
        return expenseService.patchExpense(id,updates);
    }
    
}    

