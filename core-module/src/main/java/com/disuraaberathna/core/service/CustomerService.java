package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.Customer;
import jakarta.ejb.Remote;

import java.util.Optional;

@Remote
public interface CustomerService {
    boolean validate(String username, String password);

    Optional<Customer> getCustomerByUsername(String username);

    Optional<Customer> getCustomerById(String id);

    void addCustomer(Customer customer);

    void updateCustomer(Customer customer);
}
