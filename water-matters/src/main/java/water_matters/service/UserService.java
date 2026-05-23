package water_matters.service;

import java.util.List;

import water_matters.dto.UserDTO;
import water_matters.entity.User;

public interface UserService {
    UserDTO createUser(User user);

    List<UserDTO> getUsers();

    UserDTO getUser(Long id);

    void deleteUser(Long id);
}
