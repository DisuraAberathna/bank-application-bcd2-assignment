package com.disuraaberathna.web.security;

import com.disuraaberathna.core.model.Customer;
import com.disuraaberathna.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;

import java.util.Set;

public class AppIdentityStore implements IdentityStore {
    @EJB
    private CustomerService customerService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        if (credential instanceof UsernamePasswordCredential upc) {
            if (customerService.validate(upc.getCaller(), upc.getPasswordAsString())) {
                Customer customer = customerService.getCustomerByUsername(upc.getCaller());

                return new CredentialValidationResult(customer.getUsername(), Set.of(customer.getRole().name()));
            }
        }

        return CredentialValidationResult.INVALID_RESULT;
    }
}
