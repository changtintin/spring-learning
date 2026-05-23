package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.UserDailyGoal;

@Mapper
public interface UserDailyGoalRepository {
    void insert(UserDailyGoal userDailyGoal);

    // Future methods: select/update/delete
}
