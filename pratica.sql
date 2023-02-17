CREATE TABLE IF NOT EXISTS states (
    id SERIAL NOT NULL PRIMARY KEY,
    name text NOT NULL 
);

CREATE TABLE IF NOT EXISTS cities (
    id SERIAL NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    state_id INTEGER REFERENCES states(id)
);

CREATE TABLE IF NOT EXISTS customers (
    id SERIAL NOT NULL PRIMARY KEY,
    full_name text NOT NULL,
    cpf text NOT NULL UNIQUE,
    email text NOT NULL,
    password text NOT NULL
);

CREATE TABLE IF NOT EXISTS customer_phones (
    id SERIAL NOT NULL PRIMARY KEY,
    number varchar(20) NOT NULL,
    type varchar(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS customer_phones_customers (
    id SERIAL NOT NULL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    customer_phones_id INTEGER REFERENCES customer_phones(id) UNIQUE
);

CREATE TABLE IF NOT EXISTS customer_addresses (
    id SERIAL NOT NULL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id) UNIQUE,
    street TEXT NOT NULL,
    number varchar(20) NOT NULL,
    complement TEXT NOT NULL,
    postal_code TEXT NOT NULL,
    city_id INTEGER REFERENCES cities(id)
);    

CREATE TABLE IF NOT EXISTS bank_account (
    id SERIAL NOT NULL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    account_number text NOT NULL UNIQUE,
    agency TEXT NOT NULL,
    open_date date NOT NULL DEFAULT now(),
    close_date date
);

CREATE TABLE IF NOT EXISTS transactions (
    id SERIAL NOT NULL PRIMARY KEY,
    bank_account_id INTEGER REFERENCES bank_account(id),
    amount DECIMAL NOT NULL DEFAULT 0,
    type varchar(10) NOT NULL,
    time TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT NOW(),
    description TEXT NOT NULL,
    cancelled date
);

CREATE TABLE IF NOT EXISTS credit_cards (
    id SERIAL NOT NULL PRIMARY KEY,
    bank_account_id INTEGER REFERENCES bank_account(id),
    name TEXT NOT NULL,
    number varchar(20) NOT NULL,
    security_code INTEGER NOT NULL,
    expiration_month INTEGER NOT NULL,
    expiration_year INTEGER NOT NULL,
    password TEXT NOT NULL,
    limit_card decimal NOT NULL DEFAULT 0
);