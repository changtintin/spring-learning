package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.UserAccount;

@Mapper
public interface UserAccountRepository {
    void insert(UserAccount userAccount);

    // Future methods: select/update/delete
}
