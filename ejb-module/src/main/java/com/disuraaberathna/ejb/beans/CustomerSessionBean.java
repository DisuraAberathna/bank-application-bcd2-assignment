package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.util.Encryptor;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.Optional;

@Stateless
public class CustomerSessionBean implements CustomerService {
    @PersistenceContext
    private EntityManager em;

    @Override
    public boolean validate(String username, String password) {
        try {
            Customer customer = em.createNamedQuery("Customer.findByUsername", Customer.class).setParameter("username", username).getSingleResult();

            return customer != null && Encryptor.checkPassword(password, customer.getPassword());
        } catch (NoResultException e) {
            return false;
        }
    }

    @Override
    public Optional<Customer> getCustomerByUsername(String username) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByUsername", Customer.class).setParameter("username", username);
            return Optional.ofNullable(query.getSingleResult());
        } catch (NoResultException e) {
            return Optional.empty();
        }
    }

    @Override
    public Optional<Customer> getCustomerById(String id) {
        return Optional.ofNullable(em.find(Customer.class, id));
    }

    @Override
    public void addCustomer(Customer customer) {
        em.persist(customer);
    }

    @Override
    @RolesAllowed({"CUSTOMER", "USER", "ADMIN", "SUPER_ADMIN"})
    public void updateCustomer(Customer customer) {
        em.merge(customer);
    }
}
