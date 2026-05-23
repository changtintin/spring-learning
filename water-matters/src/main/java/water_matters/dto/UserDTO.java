package water_matters.dto;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonProperty;

public class UserDTO {
    private Long id;
    private String email;
    private String timezone;

    @JsonProperty("preferred_volume_unit")
    private String preferredVolumeUnit;

    @JsonProperty("deleted_at")
    private LocalDateTime deletedAt;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTimezone() {
        return timezone;
    }

    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }

    public String getPreferredVolumeUnit() {
        return preferredVolumeUnit;
    }

    public void setPreferredVolumeUnit(String preferredVolumeUnit) {
        this.preferredVolumeUnit = preferredVolumeUnit;
    }

    public LocalDateTime getDeletedAt() {
        return deletedAt;
    }

    public void setDeletedAt(LocalDateTime deletedAt) {
        this.deletedAt = deletedAt;
    }
}
