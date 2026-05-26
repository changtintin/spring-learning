package water_matters.service;

import java.util.List;

import water_matters.dto.request.CreateUserRequest;
import water_matters.dto.response.UserDTO;

public interface UserService {
    UserDTO createUser(CreateUserRequest request);

    List<UserDTO> getUsers();

    UserDTO getUser(Long id);

    void deleteUser(Long id);
}
