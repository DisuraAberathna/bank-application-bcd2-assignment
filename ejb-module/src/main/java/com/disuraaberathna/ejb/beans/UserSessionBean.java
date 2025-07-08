package com.disuraaberathna.ejb.beans;

import com.disuraaberathna.core.model.User;
import com.disuraaberathna.core.service.UserService;
import com.disuraaberathna.core.util.Encryptor;
import jakarta.annotation.security.RolesAllowed;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;

import java.util.Optional;

@Stateless
public class UserSessionBean implements UserService {
    @PersistenceContext
    private EntityManager em;

    @Override
    public boolean validate(String username, String password) {
        try {
            User user = em.createNamedQuery("Customer.findByUsername", User.class).setParameter("username", username).getSingleResult();

            return user != null && Encryptor.checkPassword(password, user.getPassword());
        } catch (NoResultException e) {
            return false;
        }
    }

    @Override
    public User getUserByUsername(String username) {
        try {
            TypedQuery<User> query = em.createNamedQuery("User.findByUsername", User.class).setParameter("username", username);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public User getUserByEmail(String email) {
        try {
            TypedQuery<User> query = em.createNamedQuery("User.findByEmail", User.class).setParameter("email", email);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Override
    public void addUser(User user) {
        em.persist(user);
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void updateUser(User user) {
        em.merge(user);
    }

    @Override
    @RolesAllowed({"USER", "ADMIN", "SUPER_ADMIN"})
    public void deleteUser(User user) {
        em.remove(user);
    }
}
