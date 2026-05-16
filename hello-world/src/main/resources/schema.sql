CREATE TABLE IF NOT EXISTS users (
    id BIGINT NOT NULL AUTO_INCREMENT,
    username VARCHAR(100),
    email VARCHAR(255),
    display_name VARCHAR(100),
    avatar_url VARCHAR(500),
    weight DECIMAL(5,2),
    weight_unit VARCHAR(10) NOT NULL DEFAULT 'kg',
    height DECIMAL(5,2),
    height_unit VARCHAR(10) NOT NULL DEFAULT 'cm',
    birth_date DATE,
    activity_level VARCHAR(30),
    timezone VARCHAR(50) NOT NULL DEFAULT 'Asia/Taipei',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
    PRIMARY KEY (id),
    UNIQUE KEY uk_users_email (email)
);

CREATE TABLE IF NOT EXISTS user_auth_accounts (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  provider VARCHAR(50) NOT NULL,
  provider_user_id VARCHAR(255) NOT NULL,
  provider_email VARCHAR(255),
  provider_display_name VARCHAR(100),
  provider_avatar_url VARCHAR(500),
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  CONSTRAINT fk_auth_account_user
    FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE KEY uk_provider_user (provider, provider_user_id),
  KEY idx_auth_user_id (user_id)
);

CREATE TABLE IF NOT EXISTS user_daily_goals (
  id BIGINT NOT NULL AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  goal_date DATE NOT NULL,
  water_goal_ml INT NOT NULL,
  calorie_goal DECIMAL(8,2) NOT NULL,
  recommendation_source VARCHAR(50) DEFAULT 'PROFILE',
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  UNIQUE KEY uk_user_goal_date (user_id, goal_date)
);

CREATE TABLE IF NOT EXISTS beverages (
	id BIGINT NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
	calories_per_100ml DECIMAL(6,2) NOT NULL DEFAULT 0,
	water_ratio DECIMAL(5,4) NOT NULL DEFAULT 1.0000,
	category VARCHAR(50),
	is_deleted BOOLEAN NOT NULL DEFAULT FALSE,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
);

CREATE TABLE IF NOT EXISTS user_favorite_beverages (
	id BIGINT NOT NULL AUTO_INCREMENT,
	user_id BIGINT NOT NULL,
	beverage_id BIGINT NOT NULL,
	default_amount_ml INT NOT NULL,
	display_order INT NOT NULL DEFAULT 0,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (beverage_id) REFERENCES beverages(id),
	UNIQUE KEY uk_user_beverage (user_id, beverage_id)
);

CREATE TABLE intake_records (
	id BIGINT NOT NULL AUTO_INCREMENT,
	user_id BIGINT NOT NULL,
	beverage_id BIGINT NOT NULL,
	amount_ml INT NOT NULL,
	water_ml DECIMAL(8,2) NOT NULL,
	calories DECIMAL(8,2) NOT NULL,
	intake_time DATETIME NOT NULL,
	note VARCHAR(255),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (beverage_id) REFERENCES beverages(id),
	KEY idx_user_intake_time (user_id, intake_time)
);

CREATE TABLE intake_reminders (
	id BIGINT NOT NULL AUTO_INCREMENT,
	user_id BIGINT NOT NULL,
	reminder_time TIME NOT NULL,
	enabled BOOLEAN NOT NULL DEFAULT TRUE,
	message VARCHAR(255),
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES users(id),
	KEY idx_user_enabled_time (user_id, enabled, reminder_time)
);