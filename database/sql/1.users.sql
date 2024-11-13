DO $$
BEGIN
    CREATE EXTENSION IF NOT EXISTS citext;
    IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname='email') THEN
        CREATE DOMAIN email AS citext
            CHECK (
                VALUE ~ '^[a-zA-Z0-9.!#$%&''*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$'
        );
    END IF;
END
$$;

CREATE TABLE IF NOT EXISTS users (
    id              SERIAL PRIMARY KEY,
    created_at      TIMESTAMP NOT NULL,
    first_name      VARCHAR(32) NOT NULL,
    last_name       VARCHAR(32) NOT NULL,
    phone_num       VARCHAR(9) NOT NULL UNIQUE,
    email           email NOT NULL UNIQUE,
    hashed_password TEXT NOT NULL,
    deleted_at      TIMESTAMP DEFAULT NULL,
    tokens          TEXT[3] DEFAULT '{}'::TEXT[]
);
