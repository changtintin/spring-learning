package water_matters.mapper;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Component;

import water_matters.dto.request.CreateUserRequest;
import water_matters.dto.response.UserDTO;
import water_matters.entity.User;

@Component
public class UserMapper {
    public User toEntity(CreateUserRequest request) {
        if (request == null) {
            return null;
        }
        User user = new User();
        user.setEmail(trim(request.getEmail()));
        user.setTimezone(defaultIfBlank(request.getTimezone(), "Asia/Taipei"));
        user.setPreferredVolumeUnit(defaultIfBlank(request.getPreferredVolumeUnit(), "ml"));
        return user;
    }

    public UserDTO toDto(User user) {
        if (user == null) {
            return null;
        }
        UserDTO dto = new UserDTO();
        dto.setId(user.getId());
        dto.setEmail(trim(user.getEmail()));
        dto.setTimezone(trim(user.getTimezone()));
        dto.setPreferredVolumeUnit(trim(user.getPreferredVolumeUnit()));
        return dto;
    }

    public List<UserDTO> toDtoList(List<User> users) {
        if (users == null) {
            return List.of();
        }
        return users.stream()
                .map(this::toDto)
                .collect(Collectors.toList());
    }

    private String trim(String value) {
        return value == null ? null : value.trim();
    }

    private String defaultIfBlank(String value, String defaultValue) {
        if (value == null || value.isBlank()) {
            return defaultValue;
        }
        return value.trim();
    }
}
