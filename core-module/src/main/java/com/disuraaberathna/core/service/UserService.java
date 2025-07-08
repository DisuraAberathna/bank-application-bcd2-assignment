package com.disuraaberathna.core.service;

import com.disuraaberathna.core.model.User;
import jakarta.ejb.Remote;

import java.util.Optional;

@Remote
public interface UserService {
    boolean validate(String username, String password);

    User getUserByUsername(String username);

    User getUserByEmail(String email);

    void addUser(User user);

    void updateUser(User user);

    void deleteUser(User user);
}
