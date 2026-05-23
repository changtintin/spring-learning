package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.UserProfile;

@Mapper
public interface UserProfileRepository {
    void insert(UserProfile userProfile);

    // Future methods: select/update/delete
}
