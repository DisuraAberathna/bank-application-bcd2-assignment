package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.Customer;
import jakarta.ejb.Remote;

@Remote
public interface CustomerService {
    boolean validate(String username, String password);
    Customer getCustomerByUsername(String username);
    Customer getCustomerById(String id);
    void addCustomer(Customer customer);
    void updateCustomer(Customer customer);
}
