package com.dma.domain.user.dto;

import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;
import com.fasterxml.jackson.databind.annotation.JsonNaming;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Data
@NoArgsConstructor
@AllArgsConstructor
@JsonNaming(PropertyNamingStrategies.UpperCamelCaseStrategy.class)
public class User implements UserDetails {

    static final long serialVersionUID = 4086111309539465670L;

    private String I_MEMID;
    private String Y_STAFF;
    private String I_ID;
    private String N_NAME;
    private String C_SEX;
    private String D_BIRTH;
    private String I_AGE;
    private Double I_HEIGHT;
    private Double I_WEIGHT;
    private Integer I_LEVEL;
    private String S_EMAIL;
    private String I_ZIPCODE;
    private String C_QCODE;
    private Integer C_SHOP;
    private String N_SHOP;
    private String S_PIC_URL;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime D_LAST_LOGIN;
    @JsonIgnore
    private String S_PW;
    private String C_LEVEL;
    private String Y_ADM;
    private String Y_ONL;
    private String Y_OFL;
    private String Y_CEL;

    @JsonIgnore
    private String ipAddress;

    @JsonIgnore
    @Builder.Default
    private String roles = "ROLE_ANNOYMOUS";

    @JsonIgnore
    public List<String> getRolesList() {
        return Arrays.asList(this.getRoles().split(","));
    }

    @JsonIgnore
    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        // for List<String>
        // return this.getRoles().stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList());
        return Arrays.stream(this.getRoles().split(",")).map(SimpleGrantedAuthority::new).collect(Collectors.toList());
    }

    @JsonIgnore
    @Override
    public String getPassword() {
        return this.S_PW;
    }

    @JsonIgnore
    @Override
    public String getUsername() {
        return this.I_ID;
    }

    @JsonIgnore
    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @JsonIgnore
    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @JsonIgnore
    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @JsonIgnore
    @Override
    public boolean isEnabled() {
        return true;
    }

}
