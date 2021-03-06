package com.dma.security;

import com.dma.domain.common.dto.AppDto;
import com.dma.property.FileStorageProperties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.access.expression.SecurityExpressionHandler;
import org.springframework.security.access.hierarchicalroles.RoleHierarchy;
import org.springframework.security.access.hierarchicalroles.RoleHierarchyImpl;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.FilterInvocation;
import org.springframework.security.web.access.expression.DefaultWebSecurityExpressionHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.CorsUtils;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import lombok.RequiredArgsConstructor;


@RequiredArgsConstructor
@Configuration
public class BaseSecurityConfiguration extends WebSecurityConfigurerAdapter {

    private final UserDetailsServiceImpl userDetailsServiceImpl;
    private final JwtAuthenticationFilter jwtAuthenticationFilter;
    private final FileStorageProperties fileStorage;
    private final String authAccessUrlPattern = "/**";
    private final String anonymousAccessUrlPattern = "/data/**";
    private final AppDto appDto;
    
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        
        if (!appDto.isDevProfile()) {
            // local profile ?????? ?????? ????????? ?????? ?????? ??? ?????? ??????
            http
                    .authorizeRequests()
                    .antMatchers(anonymousAccessUrlPattern).permitAll()
                    .antMatchers(authAccessUrlPattern).authenticated()
                    .expressionHandler(expressionHandler());
        }
        
        http
            .cors()
                .and()

            // SockJS??? ??????????????? HTML iframe ????????? ?????? ????????? ???????????? ????????? ??????????????? ?????? ????????? ????????????.
            .headers()
                .frameOptions().sameOrigin() 
                .and()
            
            // rest api ????????? ???????????? ????????????. ??????????????? ???????????? ???????????? ???????????? ??????????????? ??????.
            .httpBasic()
                .disable() 

            // ???????????? ??????
            // ?????? ??? ?????? ????????? ????????? ?????? ??????
            // ?????? GET?????? ???????????? ????????? ?????? ??????
            .authorizeRequests() 
                .requestMatchers(CorsUtils::isPreFlightRequest).permitAll() 
                .antMatchers("/signin", "/signin/**", "/signup", "/signup/**", "/social/**").permitAll() 
                .antMatchers(fileStorage.getAccessUrl()).permitAll()
                .antMatchers(HttpMethod.GET, "/exception/**", "/favicon.ico").permitAll() 
                .antMatchers("/external/**").permitAll()
                .antMatchers(anonymousAccessUrlPattern).permitAll()
                .antMatchers("/selectList/**","/selectOne/**", "/modify/**").authenticated()
                .antMatchers("/oauth/**").permitAll()
                .antMatchers("/h2-console/**").permitAll()
                .antMatchers("/ws-stomp/**").permitAll()
                .anyRequest().permitAll()
                .and()

            // rest api????????? csrf ????????? ?????????????????? disable??????.
            .csrf()
                .disable() 

            // jwt token?????? ?????? ??? ???????????? ?????? ????????????. ????????????.
            .sessionManagement()
                .sessionCreationPolicy(SessionCreationPolicy.STATELESS) 
                .and()

            .exceptionHandling()
                .accessDeniedHandler(new CustomAccessDeniedHandler())
                .and()

            .exceptionHandling()
                .authenticationEntryPoint(new CustomAuthenticationEntryPoint())
                .and()

            // jwt token ????????? id/password ?????? ?????? ?????? ????????? ??????.
            .addFilterBefore(jwtAuthenticationFilter, UsernamePasswordAuthenticationFilter.class); 

    }

    // cors ??????
    // https://stackoverflow.com/questions/40286549/spring-boot-security-cors#answer-40431994
    @Bean
    CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.applyPermitDefaultValues();
        configuration.setAllowCredentials(true);    // false ??? ?????? ??? websock connection ??? cors ????????? ????????????.
        configuration.addExposedHeader("Client-Addr");
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source; 
    }

    @Override // ignore swagger security config
    public void configure(WebSecurity web) {
        if (!appDto.isDevProfile()) {
            web.ignoring().antMatchers("/external/**", "/webjars/**");
        } else {
            web.ignoring().antMatchers("/**");
        }
    }

    @Override
    public void configure(AuthenticationManagerBuilder builder)
    throws Exception {
        // custom user?????? ???????????? ?????????????????? ???????????????. 
        builder.authenticationProvider(authenticationProvider());
    }

    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        PasswordEncoder encoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
        return  encoder;
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        // custom user?????? ???????????? ?????????????????? ???????????????. 
        DaoAuthenticationProvider authenticationProvider = new DaoAuthenticationProvider();
        authenticationProvider.setUserDetailsService(userDetailsServiceImpl);
        authenticationProvider.setPasswordEncoder(passwordEncoder());
        return authenticationProvider;
    }

    @Bean
    public RoleHierarchy roleHierarchy() {
        RoleHierarchyImpl roleHierarchy = new RoleHierarchyImpl();

        /* 
         * ?????? ?????? ???????????? 
            + ROLE_MANAGER ??? ROLE_POST, ROLE_COMMENT, ROLE_FILE ???????????? ????????? ?????? ????????? ?????????.
            + ROLE_ADMIN ??? ROLE_MANAGER ??? ????????? ????????? ?????? ?????????.
         */
        // Map<String, List<String>> roleHierarchyMap = new HashMap<>();
        // roleHierarchyMap.put("ROLE_ADMIN", Arrays.asList("ROLE_MANAGER"));
        // roleHierarchyMap.put("ROLE_MANAGER", Arrays.asList("ROLE_POST", "ROLE_COMMENT", "ROLE_FILE"));
        // roleHierarchyMap.put("ROLE_USER", Arrays.asList("ROLE_POST"));

        // String roles = RoleHierarchyUtils.roleHierarchyFromMap(roleHierarchyMap);
        // roleHierarchy.setHierarchy(roles);
        return roleHierarchy;
    }

    @Bean
    public SecurityExpressionHandler<FilterInvocation> expressionHandler() {
        DefaultWebSecurityExpressionHandler webSecurityExpressionHandler = new DefaultWebSecurityExpressionHandler();
        webSecurityExpressionHandler.setRoleHierarchy(roleHierarchy());
        return webSecurityExpressionHandler;
    }

}
