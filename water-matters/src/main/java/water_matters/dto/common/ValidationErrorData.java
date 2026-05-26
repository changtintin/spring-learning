package water_matters.dto.common;

import java.util.List;

public class ValidationErrorData {
    private String timestamp;
    private List<ValidationFieldError> fieldErrors;

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public List<ValidationFieldError> getFieldErrors() {
        return fieldErrors;
    }

    public void setFieldErrors(List<ValidationFieldError> fieldErrors) {
        this.fieldErrors = fieldErrors;
    }
}
