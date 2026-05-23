package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.UserFavoriteBeverage;

@Mapper
public interface UserFavoriteBeverageRepository {
    void insert(UserFavoriteBeverage userFavoriteBeverage);

    // Future methods: select/update/delete
}
