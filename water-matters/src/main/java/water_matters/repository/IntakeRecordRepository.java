package water_matters.repository;

import org.apache.ibatis.annotations.Mapper;

import water_matters.entity.IntakeRecord;

@Mapper
public interface IntakeRecordRepository {
    void insert(IntakeRecord intakeRecord);

    // Future methods: select/update/delete
}
