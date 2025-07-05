package com.disuraaberathna.web.security;

import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.model.User;
import com.disuraaberathna.core.service.CustomerService;
import com.disuraaberathna.core.service.UserService;
import jakarta.ejb.EJB;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;

import java.util.Optional;
import java.util.Set;

public class AppIdentityStore implements IdentityStore {
    @EJB
    private CustomerService customerService;

    @EJB
    private UserService userService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential upc) {
            if (customerService.validate(upc.getCaller(), upc.getPasswordAsString())) {
                Optional<Customer> optionalCustomer = customerService.getCustomerByUsername(upc.getCaller());

                if (optionalCustomer.isPresent()) {
                    Customer customer = optionalCustomer.get();
                    return new CredentialValidationResult(customer.getUsername(), Set.of(customer.getRole().name()));
                }
            }

            if (userService.validate(upc.getCaller(), upc.getPasswordAsString())) {
                Optional<User> optionalUser = userService.getUserByUsername(upc.getCaller());

                if (optionalUser.isPresent()) {
                    User user = optionalUser.get();
                    return new CredentialValidationResult(user.getUsername(), Set.of(user.getRole().name()));
                }
            }
        }

        return CredentialValidationResult.INVALID_RESULT;
    }
}
