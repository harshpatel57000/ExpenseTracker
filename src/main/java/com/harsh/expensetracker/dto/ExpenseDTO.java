package com.harsh.expensetracker.dto;
import lombok.*;
import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder

public class ExpenseDTO {
    private Long id;
    private String title;
    private String description;
    private Double amount;
    private LocalDate date;
    private String category;

}
