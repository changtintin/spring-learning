package water_matters.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class UserDailyGoal {
    private Long id;
    private Long userId;
    private LocalDate goalDate;
    private Integer waterGoalMl;
    private BigDecimal calorieGoal;
    private String goalSource;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public LocalDate getGoalDate() {
        return goalDate;
    }

    public void setGoalDate(LocalDate goalDate) {
        this.goalDate = goalDate;
    }

    public Integer getWaterGoalMl() {
        return waterGoalMl;
    }

    public void setWaterGoalMl(Integer waterGoalMl) {
        this.waterGoalMl = waterGoalMl;
    }

    public BigDecimal getCalorieGoal() {
        return calorieGoal;
    }

    public void setCalorieGoal(BigDecimal calorieGoal) {
        this.calorieGoal = calorieGoal;
    }

    public String getGoalSource() {
        return goalSource;
    }

    public void setGoalSource(String goalSource) {
        this.goalSource = goalSource;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
