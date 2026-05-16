package hello_world.entity;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

public class User {
    private Long id;

    private String username;

    private String email;

    private String displayName;

    private String avatarUrl;

    private BigDecimal weightKg;

    private String weightUnit;

    private BigDecimal heightCm;

    private String heightUnit;

    private LocalDate birthDate;

    private String activityLevel;

    private String timezone;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private Boolean isDeleted;

    public Long getId(){
        return id;
    }

    public String getUsername(){
        return username;
    }

    public Boolean getIsDeleted(){
        return isDeleted;
    }

    public String getEmail() {
        return email;
    }

    public String getDisplayName() {
        return displayName;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public BigDecimal getWeightKg() {
        return weightKg;
    }

    public String getWeightUnit() {
        return weightUnit;
    }

    public BigDecimal getHeightCm() {
        return heightCm;
    }

    public String getHeightUnit() {
        return heightUnit;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public String getActivityLevel() {
        return activityLevel;
    }

    public String getTimezone() {
        return timezone;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setId(Long id){
        this.id = id;
    }

    public void setUsername(String name){
        this.username = name;
    }

    public void setIsDeleted(Boolean isDeleted){
        this.isDeleted = isDeleted;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public void setWeightKg(BigDecimal weightKg) {
        this.weightKg = weightKg;
    }

    public void setWeightUnit(String weightUnit) {
        this.weightUnit = weightUnit;
    }

    public void setHeightCm(BigDecimal heightCm) {
        this.heightCm = heightCm;
    }

    public void setHeightUnit(String heightUnit) {
        this.heightUnit = heightUnit;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public void setActivityLevel(String activityLevel) {
        this.activityLevel = activityLevel;
    }

    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
