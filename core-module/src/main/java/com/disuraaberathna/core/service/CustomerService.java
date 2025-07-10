package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.Customer;
import jakarta.ejb.Remote;

@Remote
public interface CustomerService {
    boolean validate(String username, String password);

    Customer getCustomerByUsername(String username);

    Customer getCustomerByEmail(String email);

    Customer getCustomerByMobile(String mobile);

    Customer getCustomerById(Long id);

    Customer findCustomerByNic(String nic);

    Customer findCustomerByNicAndOtp(String nic, String otp);

    void addCustomer(Customer customer);

    void updateCustomer(Customer customer);

    void deleteCustomer(Customer customer);

    boolean verifyCustomer(String username, String password, String nic, String otp);

    boolean isExist(String email, String mobile, String nic);
}
