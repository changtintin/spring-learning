package water_matters.dto.common;

public class ErrorData {
    private String timestamp;

    public ErrorData() {
    }

    public ErrorData(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }
}
