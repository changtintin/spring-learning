package water_matters.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class CreateUserRequest {
    @NotBlank
    @Email
    @Size(max = 255)
    private String email;

    @Size(max = 50)
    private String timezone;

    @JsonProperty("preferred_volume_unit")
    @Pattern(regexp = "^(ml|oz)$")
    private String preferredVolumeUnit;

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
}
