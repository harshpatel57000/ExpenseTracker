package com.harsh.expensetracker.dto;
import lombok.*;
import java.time.LocalDate;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class ExpenseDTO {
    private Long id;


    @NotBlank(message ="Title is required")
    private String title;
    
    private String description;
    
    @Positive(message="Amount must be greater than 0")
    private Double amount;

    @NotNull(message="DATE is required")
    private LocalDate date;

    @NotBlank(message="Category is required")
    private String category;

}
