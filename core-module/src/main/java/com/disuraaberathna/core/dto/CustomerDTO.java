package com.disuraaberathna.core.dto;

public class CustomerDTO {
    private String name;
    private String nic;
    private String email;
    private String mobile;
    private boolean verified;

    public CustomerDTO() {
    }

    public CustomerDTO(String name, String nic, String email, String mobile, boolean verified) {
        this.name = name;
        this.nic = nic;
        this.email = email;
        this.mobile = mobile;
        this.verified = verified;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNic() {
        return nic;
    }

    public void setNic(String nic) {
        this.nic = nic;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }
}
