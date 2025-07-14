package com.disuraaberathna.core.model;

import com.disuraaberathna.core.enums.TransferStatus;
import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "transfer_history")
@NamedQueries({
        @NamedQuery(name = "TransferHistory.verify", query = "select th from TransferHistory th where th.id = :id and th.otp = :otp"),
        @NamedQuery(name = "TransferHistory.getHistoryByAccount", query = "select th from TransferHistory th where th.fromAccount = :account or th.toAccount = :account order by th.id DESC"),
})
public class TransferHistory implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    @JoinColumn(name = "from_account_id", nullable = false)
    private Account fromAccount;
    @ManyToOne(optional = false, fetch = FetchType.EAGER)
    @JoinColumn(name = "to_account_id", nullable = false)
    private Account toAccount;
    private double amount;
    private double fromAccountBalance;
    private double toAccountBalance;
    private String otp;
    @Enumerated(EnumType.STRING)
    private TransferStatus status = TransferStatus.PENDING;
    @Column(updatable = false)
    private Date createdAt = new Date();

    public TransferHistory() {
    }

    public TransferHistory(Account fromAccount, Account toAccount, double amount, String otp) {
        this.fromAccount = fromAccount;
        this.toAccount = toAccount;
        this.amount = amount;
        this.otp = otp;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Account getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Account fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Account getToAccount() {
        return toAccount;
    }

    public void setToAccount(Account toAccount) {
        this.toAccount = toAccount;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getFromAccountBalance() {
        return fromAccountBalance;
    }

    public void setFromAccountBalance(double fromAccountBalance) {
        this.fromAccountBalance = fromAccountBalance;
    }

    public double getToAccountBalance() {
        return toAccountBalance;
    }

    public void setToAccountBalance(double toAccountBalance) {
        this.toAccountBalance = toAccountBalance;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public TransferStatus getStatus() {
        return status;
    }

    public void setStatus(TransferStatus status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
