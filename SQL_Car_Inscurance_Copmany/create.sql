-- Remove conflicting tables
DROP TABLE IF EXISTS agents CASCADE;
DROP TABLE IF EXISTS branches CASCADE;
DROP TABLE IF EXISTS claims CASCADE;
DROP TABLE IF EXISTS contracts CASCADE;
DROP TABLE IF EXISTS feedback CASCADE;
DROP TABLE IF EXISTS mycustomers CASCADE;
DROP TABLE IF EXISTS payment CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
-- End of removing

CREATE TABLE agents (
    agent_id SERIAL NOT NULL,
    branch_id INTEGER NOT NULL,
    name VARCHAR(256) NOT NULL,
    phone VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL
);
ALTER TABLE agents ADD CONSTRAINT pk_agents PRIMARY KEY (agent_id);

CREATE TABLE branches (
    branch_id SERIAL NOT NULL,
    branch_name VARCHAR(256) NOT NULL,
    location VARCHAR(256) NOT NULL
);
ALTER TABLE branches ADD CONSTRAINT pk_branches PRIMARY KEY (branch_id);

CREATE TABLE claims (
    claim_id SERIAL NOT NULL,
    vehicle_id INTEGER NOT NULL,
    claim_date DATE NOT NULL,
    description VARCHAR(256) NOT NULL
);
ALTER TABLE claims ADD CONSTRAINT pk_claims PRIMARY KEY (claim_id);

CREATE TABLE contracts (
    contract_id SERIAL NOT NULL,
    branch_id INTEGER NOT NULL,
    cus_id INTEGER NOT NULL,
    contract_number VARCHAR(256) NOT NULL,
    coverage_type VARCHAR(256) NOT NULL,
    startdate VARCHAR(256) NOT NULL,
    end_date VARCHAR(256) NOT NULL
);
ALTER TABLE contracts ADD CONSTRAINT pk_contracts PRIMARY KEY (contract_id);

CREATE TABLE feedback (
    feedback_id SERIAL NOT NULL,
    branch_id INTEGER NOT NULL,
    cus_id INTEGER NOT NULL,
    feedback_type VARCHAR(256) NOT NULL,
    feedback_date DATE NOT NULL,
    comments VARCHAR(256) NOT NULL
);
ALTER TABLE feedback ADD CONSTRAINT pk_feedback PRIMARY KEY (feedback_id);

CREATE TABLE mycustomers (
    cus_id SERIAL NOT NULL,
    agent_id INTEGER,
    first_name VARCHAR(256) NOT NULL,
    last_name VARCHAR(256) NOT NULL,
    address VARCHAR(256) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(256) NOT NULL
);
ALTER TABLE mycustomers ADD CONSTRAINT pk_mycustomers PRIMARY KEY (cus_id);

CREATE TABLE payment (
    payment_id SERIAL NOT NULL,
    contract_id INTEGER NOT NULL,
    payment_date DATE NOT NULL,
    payment_method VARCHAR(256) NOT NULL,
    amount VARCHAR(256) NOT NULL
);
ALTER TABLE payment ADD CONSTRAINT pk_payment PRIMARY KEY (payment_id, contract_id);
ALTER TABLE payment ADD CONSTRAINT u_fk_payment_contracts UNIQUE (contract_id);

CREATE TABLE vehicles (
    vehicle_id SERIAL NOT NULL,
    contract_id INTEGER NOT NULL,
    make VARCHAR(256) NOT NULL,
    vin VARCHAR(256) NOT NULL,
    year VARCHAR(256) NOT NULL,
    model VARCHAR(256) NOT NULL
);
ALTER TABLE vehicles ADD CONSTRAINT pk_vehicles PRIMARY KEY (vehicle_id);
ALTER TABLE vehicles ADD CONSTRAINT u_fk_vehicles_contracts UNIQUE (contract_id);

ALTER TABLE agents ADD CONSTRAINT fk_agents_branches FOREIGN KEY (branch_id) REFERENCES branches (branch_id) ON DELETE CASCADE;

ALTER TABLE claims ADD CONSTRAINT fk_claims_vehicles FOREIGN KEY (vehicle_id) REFERENCES vehicles (vehicle_id) ON DELETE CASCADE;

ALTER TABLE contracts ADD CONSTRAINT fk_contracts_branches FOREIGN KEY (branch_id) REFERENCES branches (branch_id) ON DELETE CASCADE;
ALTER TABLE contracts ADD CONSTRAINT fk_contracts_mycustomers FOREIGN KEY (cus_id) REFERENCES mycustomers (cus_id) ON DELETE CASCADE;

ALTER TABLE feedback ADD CONSTRAINT fk_feedback_branches FOREIGN KEY (branch_id) REFERENCES branches (branch_id) ON DELETE CASCADE;
ALTER TABLE feedback ADD CONSTRAINT fk_feedback_mycustomers FOREIGN KEY (cus_id) REFERENCES mycustomers (cus_id) ON DELETE CASCADE;

ALTER TABLE mycustomers ADD CONSTRAINT fk_mycustomers_agents FOREIGN KEY (agent_id) REFERENCES agents (agent_id) ON DELETE CASCADE;

ALTER TABLE payment ADD CONSTRAINT fk_payment_contracts FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE;

ALTER TABLE vehicles ADD CONSTRAINT fk_vehicles_contracts FOREIGN KEY (contract_id) REFERENCES contracts (contract_id) ON DELETE CASCADE;

