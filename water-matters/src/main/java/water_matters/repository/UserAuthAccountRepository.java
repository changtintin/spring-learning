package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.UserAuthAccount;

@Mapper
public interface UserAuthAccountRepository {
    void insert(UserAuthAccount userAuthAccount);

    // Future methods: select/update/delete
}
