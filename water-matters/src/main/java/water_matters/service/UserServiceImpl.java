package water_matters.service;

import java.util.List;

import org.springframework.stereotype.Service;

import water_matters.dto.request.CreateUserRequest;
import water_matters.dto.response.UserDTO;
import water_matters.entity.User;
import water_matters.exception.UserNotFoundException;
import water_matters.mapper.UserMapper;
import water_matters.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final UserMapper userMapper;

    public UserServiceImpl(UserRepository userRepository, UserMapper userMapper) {
        this.userRepository = userRepository;
        this.userMapper = userMapper;
    }

    @Override
    public UserDTO createUser(CreateUserRequest request) {
        User user = userMapper.toEntity(request);
        User createdUser = userRepository.save(user);
        return userMapper.toDto(createdUser);
    }

    @Override
    public List<UserDTO> getUsers() {
        return userMapper.toDtoList(userRepository.findAll());
    }

    @Override
    public UserDTO getUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
        return userMapper.toDto(user);
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException(id));
        userRepository.deleteById(id);
    }
}
