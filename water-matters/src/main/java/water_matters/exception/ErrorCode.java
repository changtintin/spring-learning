package water_matters.exception;

import org.springframework.http.HttpStatus;

public enum ErrorCode {
    USER_NOT_FOUND(3001, "user not found", HttpStatus.NOT_FOUND),
    USER_DATA_CONFLICT(3002, "resource conflict", HttpStatus.CONFLICT),
    VALIDATION_ERROR(5001, "Validation errors", HttpStatus.UNPROCESSABLE_ENTITY),
    INTERNAL_SERVER_ERROR(6001, "internal server error", HttpStatus.INTERNAL_SERVER_ERROR);

    private final int code;
    private final String message;
    private final HttpStatus httpStatus;

    ErrorCode(int code, String message, HttpStatus httpStatus) {
        this.code = code;
        this.message = message;
        this.httpStatus = httpStatus;
    }

    public int getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}
