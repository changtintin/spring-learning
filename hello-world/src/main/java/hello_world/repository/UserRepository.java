package hello_world.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import hello_world.entity.User;

// User = 這個 Repository 操作的 Entity
// Long = User 的 id 型別
public interface UserRepository extends JpaRepository<User, Long> {
    // Jpa:
    //     findAll()
    //     findById()
    //     save()
    //     deleteById()
    //     existsById()
}