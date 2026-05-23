package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.Beverage;

@Mapper
public interface BeverageRepository {
    void insert(Beverage beverage);

    // Future methods: select/update/delete
}
