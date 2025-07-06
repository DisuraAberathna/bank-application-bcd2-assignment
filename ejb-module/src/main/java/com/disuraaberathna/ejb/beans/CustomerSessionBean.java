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
    public Customer getCustomerByUsername(String username) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByUsername", Customer.class).setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Customer getCustomerByEmail(String email) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByEmail", Customer.class).setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Customer getCustomerByMobile(String mobile) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByMobile", Customer.class).setParameter("contact", mobile);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public Customer getCustomerById(String id) {
        try {
            return em.find(Customer.class, id);
        } catch (NoResultException e) {
            return null;
        }
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
