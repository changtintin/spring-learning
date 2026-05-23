package water_matters.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Beverage {
    private Long id;
    private Long ownerUserId;
    private String name;
    private Integer categoryId;
    private BigDecimal caloriesPer100ml;
    private BigDecimal waterRatio;
    private String colorHex;
    private Boolean isActive;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private LocalDateTime deletedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getOwnerUserId() {
        return ownerUserId;
    }

    public void setOwnerUserId(Long ownerUserId) {
        this.ownerUserId = ownerUserId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public BigDecimal getCaloriesPer100ml() {
        return caloriesPer100ml;
    }

    public void setCaloriesPer100ml(BigDecimal caloriesPer100ml) {
        this.caloriesPer100ml = caloriesPer100ml;
    }

    public BigDecimal getWaterRatio() {
        return waterRatio;
    }

    public void setWaterRatio(BigDecimal waterRatio) {
        this.waterRatio = waterRatio;
    }

    public String getColorHex() {
        return colorHex;
    }

    public void setColorHex(String colorHex) {
        this.colorHex = colorHex;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean active) {
        isActive = active;
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

    public LocalDateTime getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(LocalDateTime deletedAt) {
        this.deletedAt = deletedAt;
    }
}
