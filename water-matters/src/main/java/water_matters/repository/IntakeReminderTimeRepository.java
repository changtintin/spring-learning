package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.IntakeReminderTime;

@Mapper
public interface IntakeReminderTimeRepository {
    void insert(IntakeReminderTime intakeReminderTime);

    // Future methods: select/update/delete
}
