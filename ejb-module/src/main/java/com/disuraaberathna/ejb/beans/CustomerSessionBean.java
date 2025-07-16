package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.annotation.Audit;
import com.disuraaberathna.core.annotation.Performance;
import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.util.Encryptor;
import jakarta.annotation.security.DenyAll;
import jakarta.annotation.security.PermitAll;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.*;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

@Stateless
@Audit
@Performance
@TransactionManagement(TransactionManagementType.CONTAINER)
public class CustomerSessionBean implements CustomerService {
    @PersistenceContext
    private EntityManager em;

    @Override
    @PermitAll
    public boolean validate(String username, String password) {
        try {
            Customer customer = em.createNamedQuery("Customer.findByUsername", Customer.class).setParameter("username", username).getSingleResult();

            return customer != null && Encryptor.checkPassword(password, customer.getPassword());
        } catch (NoResultException e) {
            return false;
        }
    }

    @Override
    @PermitAll
    public Customer getCustomerByUsername(String username) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByUsername", Customer.class).setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    @TransactionAttribute(TransactionAttributeType.SUPPORTS)
    public Customer getCustomerByEmail(String email) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByEmail", Customer.class).setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public Customer getCustomerByMobile(String mobile) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByMobile", Customer.class).setParameter("contact", mobile);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @PermitAll
    public Customer getCustomerById(Long id) {
        try {
            return em.find(Customer.class, id);
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public Customer findCustomerByNic(String nic) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByNic", Customer.class).setParameter("nic", nic);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @PermitAll
    public Customer findCustomerByNicAndOtp(String nic, String otp) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findByNicAndOtp", Customer.class).setParameter("nic", nic).setParameter("otp", otp);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void addCustomer(Customer customer) {
        em.persist(customer);
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void updateCustomer(Customer customer) {
        em.merge(customer);
    }

    @Override
    @DenyAll
    public void deleteCustomer(Customer customer) {
        em.remove(customer);
    }

    @Override
    @PermitAll
    public boolean verifyCustomer(String username, String password, String nic, String otp) {
        Customer customer = findCustomerByNicAndOtp(nic, otp);
        if (customer != null) {
            customer.setUsername(username);
            customer.setPassword(password);
            customer.setVerified(true);
            customer.setVerificationCode(null);
            customer.setVerificationExpireAt(null);
            em.merge(customer);
            return true;
        }

        return false;
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public Customer isExist(String email, String mobile, String nic) {
        try {
            TypedQuery<Customer> query = em.createNamedQuery("Customer.findExists", Customer.class).setParameter("email", email).setParameter("nic", nic).setParameter("contact", mobile);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }
}
