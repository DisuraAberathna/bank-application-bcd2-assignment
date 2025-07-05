package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.CustomerService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

@Stateless
public class CustomerSessionBean implements CustomerService {
    @PersistenceContext
    private EntityManager em;

    @Override
    public boolean validate(String username, String password) {
        return false;
    }

    @Override
    public Customer getCustomerByUsername(String username) {
        return null;
    }

    @Override
    public Customer getCustomerById(String id) {
        return null;
    }
}
