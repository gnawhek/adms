package com.dma.config;

import java.io.IOException;

import javax.sql.DataSource;

import com.dma.Intercepts.SqlStatementInterceptor;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.LocalCacheScope;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Configuration
@EnableTransactionManagement
public class DatabaseConfiguration {

    @Autowired
    private ApplicationContext applicationContext;

    @Value("${spring.datasource.driver-class-name}")
	private String driverClassName;
	@Value("${spring.datasource.url}")
	private String url;
	@Value("${spring.datasource.username}")
	private String username;
	@Value("${spring.datasource.password}")
	private String password;
	@Value("${spring.mybatis.mapper-locations:classpath:/mapper/**/*.xml}")
	private String mapperLocations;
	@Value("${spring.mybatis.configuration.mapUnderscoreToCamelCase:false}")
	private Boolean mapUnderscoreToCamelCase;
	@Value("${spring.mybatis.configuration.cacheEnabled:false}")
	private Boolean cacheEnabled;
	@Value("${spring.mybatis.configuration.callSettersOnNulls:true}")
    private Boolean callSettersOnNulls;
    @Value("${spring.datasource.hikari.connectionTimeout:600000}")
	private long connectionTimeout;
	@Value("${spring.datasource.hikari.maximumPoolSize:20}")
	private int maximumPoolSize;
	@Value("${spring.datasource.hikari.maxLifetime:600000}")
	private long maxLifetime;
	@Value("${spring.datasource.hikari.minimumIdle:10}")
	private int minimumIdle;
	@Value("${spring.datasource.hikari.validationTimeout:30000}")
	private long validationTimeout;
	@Value("${spring.datasource.hikari.idleTimeout:300000}")
	private long idleTimeout;

    @Bean
    public SqlStatementInterceptor interceptor() {
        return new SqlStatementInterceptor();
    }

    @Bean
    public DataSource getDataSource() throws IOException{
        // String ip = System.getProperty("server.ip");
        // String url = "jdbc:postgresql://"+ip+":5432/capstonedb";
        HikariConfig config = new HikariConfig();
        config.setDriverClassName(driverClassName);
        config.setJdbcUrl(url);
        config.setMaximumPoolSize(maximumPoolSize);
        config.setIdleTimeout(idleTimeout);
        config.setConnectionTimeout(connectionTimeout);
        config.setMaxLifetime(maxLifetime);
        config.setMinimumIdle(minimumIdle);
        config.setValidationTimeout(validationTimeout);
        config.setUsername(username);
        config.setPassword(password);
        return new HikariDataSource(config);
    }

    @Bean
    public SqlSessionFactory getSqlSessionFactory() throws Exception{
        SqlSessionFactoryBean sqlSessionFactoryBean = new SqlSessionFactoryBean();
        sqlSessionFactoryBean.setDataSource(getDataSource());
        sqlSessionFactoryBean.setMapperLocations(applicationContext.getResources(mapperLocations));

        org.apache.ibatis.session.Configuration configuration = new org.apache.ibatis.session.Configuration();
        configuration.setMapUnderscoreToCamelCase(mapUnderscoreToCamelCase);
        configuration.setCacheEnabled(cacheEnabled);
        configuration.setJdbcTypeForNull(JdbcType.NULL);    //  jdbcType=VARCHAR 사용 없이 null 처리함.
        configuration.setLocalCacheScope(LocalCacheScope.STATEMENT);
        configuration.setCallSettersOnNulls(callSettersOnNulls);
        sqlSessionFactoryBean.setConfiguration(configuration);
        sqlSessionFactoryBean.setPlugins(new Interceptor[] { interceptor() });
        return sqlSessionFactoryBean.getObject();
    }

    @Bean
    public SqlSessionTemplate getSqlSessionTemplate() throws Exception{
        return new SqlSessionTemplate(getSqlSessionFactory());
    }

    
}
