package com.harsh.expensetracker.mapper;
import com.harsh.expensetracker.dto.ExpenseDTO;
import com.harsh.expensetracker.entity.Expense;

public class ExpenseMapper {
    //entity ->dto
    public static ExpenseDTO toDTO(Expense expense){
        if(expense == null){
            return null;
        }
        return ExpenseDTO.builder().id(expense.getId()).title(expense.getTitle()).amount(expense.getAmount()).category(expense.getCategory()).date(expense.getDate()).description(expense.getDescription()).build();
                
    }

public static Expense toEntity(ExpenseDTO dto){
    if(dto ==null){
        return null;
    }

        return Expense.builder().id(dto.getId()).title(dto.getTitle()).amount(dto.getAmount()).category(dto.getCategory()).date(dto.getDate()).description(dto.getDescription()).build();
}
}