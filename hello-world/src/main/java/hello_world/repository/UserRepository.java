package hello_world.repository;

import java.util.List;
import java.util.Optional;

import hello_world.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserRepository {
    void insert(User user);

    List<User> findAll();

    User selectById(Long id);

    void deleteById(Long id);

    default User save(User user) {
        insert(user);
        return user;
    }

    default Optional<User> findById(Long id) {
        return Optional.ofNullable(selectById(id));
    }
}
