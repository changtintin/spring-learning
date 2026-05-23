package water_matters.service;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import water_matters.dto.UserDTO;
import water_matters.entity.User;
import water_matters.repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public UserDTO createUser(User user) {
        User createdUser = userRepository.save(user);
        return toDto(createdUser);
    }

    @Override
    public List<UserDTO> getUsers() {
        return userRepository.findAll()
                .stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    @Override
    public UserDTO getUser(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found"));
        return toDto(user);
    }

    @Override
    public void deleteUser(Long id) {
        userRepository.deleteById(id);
    }

    private UserDTO toDto(User user) {
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setEmail(user.getEmail());
        dto.setTimezone(user.getTimezone());
        dto.setPreferredVolumeUnit(user.getPreferredVolumeUnit());
        dto.setDeletedAt(user.getDeletedAt());
        return dto;
    }
}
