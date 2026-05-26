package water_matters.exception;

import java.time.Instant;
import java.util.List;
import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import water_matters.dto.common.ApiResponse;
import water_matters.dto.common.ValidationErrorData;
import water_matters.dto.common.ValidationFieldError;

@RestControllerAdvice
public class GlobalExceptionHandler {
    private final MessageSource messageSource;

    public GlobalExceptionHandler(MessageSource messageSource) {
        this.messageSource = messageSource;
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiResponse<ValidationErrorData>> handleValidationException(MethodArgumentNotValidException ex) {
        Locale locale = LocaleContextHolder.getLocale();
        List<ValidationFieldError> fieldErrors = ex.getBindingResult()
                .getFieldErrors()
                .stream()
                .map(error -> {
                    ValidationFieldError fieldError = new ValidationFieldError();
                    fieldError.setField(toSnakeCase(error.getField()));
                    fieldError.setMessage(resolveValidationMessage(error, locale));
                    fieldError.setRejectedValue(error.getRejectedValue());
                    return fieldError;
                })
                .toList();

        ValidationErrorData data = new ValidationErrorData();
        data.setTimestamp(Instant.now().toString());
        data.setFieldErrors(fieldErrors);

        return ResponseEntity.status(HttpStatus.UNPROCESSABLE_ENTITY)
                .body(new ApiResponse<>("422", "Validation errors", data));
    }

    @ExceptionHandler(UserNotFoundException.class)
    public ResponseEntity<ApiResponse<Void>> handleUserNotFoundException(UserNotFoundException ex) {
        return ResponseEntity.status(HttpStatus.NOT_FOUND)
                .body(ApiResponse.error("404", ex.getMessage()));
    }

    @ExceptionHandler({DuplicateKeyException.class, DataIntegrityViolationException.class})
    public ResponseEntity<ApiResponse<Void>> handleDataConflictException(Exception ex) {
        return ResponseEntity.status(HttpStatus.CONFLICT)
                .body(ApiResponse.error("409", "resource conflict"));
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiResponse<Void>> handleUnexpectedException(Exception ex) {
        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                .body(ApiResponse.error("500", "internal server error"));
    }

    private String resolveValidationMessage(FieldError error, Locale locale) {
        String paramName = toSnakeCase(error.getField());
        String errorCode = error.getCode();

        if ("Size".equals(errorCode)) {
            Number max = extractMaxFromSize(error);
            return messageSource.getMessage(
                    "validation.Size",
                    new Object[]{paramName, max},
                    paramName + " is invalid",
                    locale
            );
        }

        if ("Pattern".equals(errorCode) && "preferredVolumeUnit".equals(error.getField())) {
            return messageSource.getMessage(
                    "validation.Pattern.preferred_volume_unit",
                    null,
                    "preferred_volume_unit is invalid",
                    locale
            );
        }

        return messageSource.getMessage(
                "validation." + errorCode,
                new Object[]{paramName},
                paramName + " is invalid",
                locale
        );
    }

    private Number extractMaxFromSize(FieldError error) {
        if (error.getArguments() == null) {
            return null;
        }

        Number max = null;
        for (Object argument : error.getArguments()) {
            if (argument instanceof Number number) {
                if (max == null || number.longValue() > max.longValue()) {
                    max = number;
                }
            }
        }
        return max;
    }

    private String toSnakeCase(String value) {
        if (value == null || value.isBlank()) {
            return value;
        }
        return value
                .replaceAll("([a-z])([A-Z]+)", "$1_$2")
                .toLowerCase();
    }
}
