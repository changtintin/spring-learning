package water_matters.entity;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class UserFavoriteBeverage {
    private Long id;
    private Long userId;
    private Long beverageId;
    private BigDecimal defaultAmountValue;
    private String defaultAmountUnit;
    private Integer displayOrder;
    private LocalDateTime createdAt;

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

    public Long getBeverageId() {
        return beverageId;
    }

    public void setBeverageId(Long beverageId) {
        this.beverageId = beverageId;
    }

    public BigDecimal getDefaultAmountValue() {
        return defaultAmountValue;
    }

    public void setDefaultAmountValue(BigDecimal defaultAmountValue) {
        this.defaultAmountValue = defaultAmountValue;
    }

    public String getDefaultAmountUnit() {
        return defaultAmountUnit;
    }

    public void setDefaultAmountUnit(String defaultAmountUnit) {
        this.defaultAmountUnit = defaultAmountUnit;
    }

    public Integer getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(Integer displayOrder) {
        this.displayOrder = displayOrder;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
