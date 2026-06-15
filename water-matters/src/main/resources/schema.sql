DROP TABLE IF EXISTS payment_transactions;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS subscriptions;
DROP TABLE IF EXISTS subscription_plans;
DROP TABLE IF EXISTS products;
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

CREATE TABLE products (
    id BIGINT NOT NULL AUTO_INCREMENT,
    code VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    product_type ENUM('SUBSCRIPTION', 'DIGITAL_ASSET', 'FEATURE') NOT NULL,
    description VARCHAR(500),
    price_amount DECIMAL(10,2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'TWD',
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_products_code (code),
    CONSTRAINT chk_products_price_amount
        CHECK (price_amount >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE subscription_plans (
    id BIGINT NOT NULL AUTO_INCREMENT,
    product_id BIGINT NOT NULL,
    plan_type ENUM('TRIAL', 'PAID') NOT NULL,
    billing_cycle ENUM('NONE', 'MONTHLY', 'YEARLY') NOT NULL DEFAULT 'NONE',
    duration_days INT NOT NULL,
    is_auto_renew BOOLEAN NOT NULL DEFAULT FALSE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_subscription_plans_product_id (product_id),
    CONSTRAINT fk_subscription_plans_product
        FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT chk_subscription_plans_duration_days
        CHECK (duration_days > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE subscriptions (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    subscription_plan_id BIGINT NOT NULL,
    status ENUM('TRIALING', 'ACTIVE', 'EXPIRED', 'CANCELLED') NOT NULL,
    start_at DATETIME NOT NULL,
    end_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_subscriptions_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_subscriptions_subscription_plan
        FOREIGN KEY (subscription_plan_id) REFERENCES subscription_plans(id),
    CONSTRAINT chk_subscriptions_period
        CHECK (end_at > start_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE carts (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    status ENUM('ACTIVE', 'CHECKOUT_PENDING', 'CHECKED_OUT', 'CANCELLED') NOT NULL DEFAULT 'ACTIVE',
    total_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    currency CHAR(3) NOT NULL DEFAULT 'TWD',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_carts_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT chk_carts_total_amount
        CHECK (total_amount >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE cart_items (
    id BIGINT NOT NULL AUTO_INCREMENT,
    cart_id BIGINT NOT NULL,
    product_id BIGINT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_cart_items_cart
        FOREIGN KEY (cart_id) REFERENCES carts(id),
    CONSTRAINT fk_cart_items_product
        FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT chk_cart_items_quantity
        CHECK (quantity > 0),
    CONSTRAINT chk_cart_items_unit_price
        CHECK (unit_price >= 0),
    CONSTRAINT chk_cart_items_subtotal
        CHECK (subtotal >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE payment_transactions (
    id BIGINT NOT NULL AUTO_INCREMENT,
    user_id BIGINT NOT NULL,
    cart_id BIGINT NOT NULL,
    status ENUM('INITIATED', 'SUCCEEDED', 'FAILED', 'CANCELLED') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    currency CHAR(3) NOT NULL DEFAULT 'TWD',
    external_payment_id VARCHAR(255),
    idempotency_key VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uk_payment_transactions_external_payment_id (external_payment_id),
    UNIQUE KEY uk_payment_transactions_idempotency_key (idempotency_key),
    CONSTRAINT fk_payment_transactions_user
        FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_payment_transactions_cart
        FOREIGN KEY (cart_id) REFERENCES carts(id),
    CONSTRAINT chk_payment_transactions_amount
        CHECK (amount >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
