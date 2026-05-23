package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.IntakeReminder;

@Mapper
public interface IntakeReminderRepository {
    void insert(IntakeReminder intakeReminder);

    // Future methods: select/update/delete
}
