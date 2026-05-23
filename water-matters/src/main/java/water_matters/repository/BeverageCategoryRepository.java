package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.BeverageCategory;

@Mapper
public interface BeverageCategoryRepository {
    void insert(BeverageCategory beverageCategory);

    // Future methods: select/update/delete
}
