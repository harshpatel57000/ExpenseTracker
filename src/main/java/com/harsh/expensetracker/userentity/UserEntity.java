package com.harsh.expensetracker.userentity;
import lombok.Builder;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder

@Data


public class UserEntity {

    private String userName;

    private String email;

    private double pssawoed;



}
