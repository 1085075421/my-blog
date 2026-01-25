package com.blog.repository;

import com.blog.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByAccount(String account);
    Optional<User> findByUsername(String username);
    Optional<User> findByEmail(String email);
    boolean existsByAccount(String account);
    boolean existsByUsername(String username);
    boolean existsByEmail(String email);
}
