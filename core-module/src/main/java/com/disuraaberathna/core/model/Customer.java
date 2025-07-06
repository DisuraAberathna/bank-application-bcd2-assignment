package com.disuraaberathna.core.model;

import com.disuraaberathna.core.enums.Status;
import com.disuraaberathna.core.enums.UserRoles;
import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "customers")
@NamedQueries({
        @NamedQuery(name = "Customer.findByUsername", query = "select c from Customer c where c.username = :username"),
        @NamedQuery(name = "Customer.findByEmail", query = "select c from Customer c where c.email = :email"),
        @NamedQuery(name = "Customer.findByMobile", query = "select c from Customer c where c.contact = :contact"),
})
public class Customer implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(updatable = false, nullable = false)
    private Long id;
    @Column(nullable = false)
    private String firstName;
    @Column(nullable = false)
    private String lastName;
    @Column(unique = true, nullable = false)
    private String email;
    @Column(unique = true, nullable = false)
    private String contact;
    @Column(unique = true, nullable = false)
    private String username;
    @Column(nullable = false)
    private String password;
    private String verificationCode;
    private LocalDateTime verificationExpireAt;
    @Enumerated(EnumType.STRING)
    private UserRoles role = UserRoles.CUSTOMER;
    @OneToMany(mappedBy = "customer", cascade = CascadeType.ALL)
    private List<Account> accounts = new ArrayList<Account>();
    @Enumerated(EnumType.STRING)
    private Status status = Status.ACTIVE;
    private boolean isVerified = false;

    public Customer() {
    }

    public Customer(String firstName, String lastName, String email, String contact, String username, String password) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.contact = contact;
        this.username = username;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRoles getRole() {
        return role;
    }

    public void setRole(UserRoles role) {
        this.role = role;
    }

    public String getVerificationCode() {
        return verificationCode;
    }

    public void setVerificationCode(String verificationCode) {
        this.verificationCode = verificationCode;
    }

    public LocalDateTime getVerificationExpireAt() {
        return verificationExpireAt;
    }

    public void setVerificationExpireAt(LocalDateTime verificationExpireAt) {
        this.verificationExpireAt = verificationExpireAt;
    }

    public List<Account> getAccounts() {
        return accounts;
    }

    public void setAccounts(List<Account> accounts) {
        this.accounts = accounts;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public boolean isVerified() {
        return isVerified;
    }

    public void setVerified(boolean verified) {
        isVerified = verified;
    }
}
