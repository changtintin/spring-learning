DROP TABLE IF EXISTS intake_reminder_times;
DROP TABLE IF EXISTS intake_records;
DROP TABLE IF EXISTS user_favorite_beverages;
DROP TABLE IF EXISTS user_daily_goals;
DROP TABLE IF EXISTS user_auth_accounts;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS intake_reminders;
DROP TABLE IF EXISTS beverages;
DROP TABLE IF EXISTS beverage_categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id BIGINT NOT NULL AUTO_INCREMENT,
    email VARCHAR(255),
    timezone VARCHAR(50) NOT NULL DEFAULT 'Asia/Taipei',
    preferred_volume_unit ENUM('ml', 'oz') NOT NULL DEFAULT 'ml',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_profiles (
    user_id BIGINT NOT NULL,
    username VARCHAR(100),
    display_name VARCHAR(100),
    avatar_url VARCHAR(500),
    weight_kg DECIMAL(5,2),
    height_cm DECIMAL(5,2),
    birth_date DATE,
    activity_level VARCHAR(30),
    PRIMARY KEY (user_id),
    UNIQUE KEY uk_user_profiles_username (username),
    CONSTRAINT fk_user_profiles_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT chk_user_profiles_weight_kg
        CHECK (weight_kg IS NULL OR weight_kg > 0),
    CONSTRAINT chk_user_profiles_height_cm
        CHECK (height_cm IS NULL OR height_cm > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_auth_accounts (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    provider VARCHAR(30) NOT NULL,
    provider_user_id VARCHAR(255) NOT NULL,
    provider_email VARCHAR(255),
    provider_display_name VARCHAR(100),
    provider_avatar_url VARCHAR(500),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_user_auth_accounts_user
        FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE beverage_categories (
    id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
    code VARCHAR(50) NOT NULL,
    display_name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_beverage_categories_code (code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE beverages (
    id BIGINT NOT NULL AUTO_INCREMENT,
    owner_user_id BIGINT,
    name VARCHAR(100) NOT NULL,
    category_id SMALLINT UNSIGNED,
    calories_per_100ml DECIMAL(6,2) NOT NULL,
    water_ratio DECIMAL(5,4) NOT NULL,
    color_hex CHAR(7),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deleted_at DATETIME NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_beverages_owner_user
        FOREIGN KEY (owner_user_id) REFERENCES users(id),
    CONSTRAINT fk_beverages_category
        FOREIGN KEY (category_id) REFERENCES beverage_categories(id),
    CONSTRAINT chk_beverages_calories_per_100ml
        CHECK (calories_per_100ml >= 0),
    CONSTRAINT chk_beverages_water_ratio
        CHECK (water_ratio >= 0 AND water_ratio <= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_favorite_beverages (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    beverage_id BIGINT NOT NULL,
    default_amount_value DECIMAL(8,2) NOT NULL,
    default_amount_unit ENUM('ml', 'oz') NOT NULL DEFAULT 'ml',
    display_order INT NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_user_favorite_beverages_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_user_favorite_beverages_beverage
        FOREIGN KEY (beverage_id) REFERENCES beverages(id),
    CONSTRAINT chk_user_favorite_beverages_default_amount_value
        CHECK (default_amount_value > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE user_daily_goals (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    goal_date DATE NOT NULL,
    water_goal_ml INT NOT NULL,
    calorie_goal DECIMAL(8,2) NOT NULL,
    goal_source VARCHAR(30) NOT NULL DEFAULT 'PROFILE',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_user_daily_goals_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT chk_user_daily_goals_water_goal_ml
        CHECK (water_goal_ml > 0),
    CONSTRAINT chk_user_daily_goals_calorie_goal
        CHECK (calorie_goal >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE intake_records (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    beverage_id BIGINT NOT NULL,
    amount_value DECIMAL(8,2) NOT NULL,
    amount_unit ENUM('ml', 'oz') NOT NULL,
    calories DECIMAL(10,2) NOT NULL,
    intake_time DATETIME NOT NULL,
    note VARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_intake_records_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_intake_records_beverage
        FOREIGN KEY (beverage_id) REFERENCES beverages(id),
    CONSTRAINT chk_intake_records_amount_value
        CHECK (amount_value > 0),
    CONSTRAINT chk_intake_records_calories
        CHECK (calories >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE intake_reminders (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    channel VARCHAR(20) NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT TRUE,
    message VARCHAR(255),
    timezone VARCHAR(50) NOT NULL DEFAULT 'Asia/Taipei',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_intake_reminders_user
        FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE intake_reminder_times (
    id BIGINT NOT NULL AUTO_INCREMENT,
    reminder_id BIGINT NOT NULL,
    weekday TINYINT UNSIGNED,
    reminder_time TIME NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_intake_reminder_times_reminder
        FOREIGN KEY (reminder_id) REFERENCES intake_reminders(id),
    CONSTRAINT chk_intake_reminder_times_weekday
        CHECK (weekday IS NULL OR weekday BETWEEN 0 AND 6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
