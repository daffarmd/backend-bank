CREATE TABLE accounts (
  id bigserial PRIMARY KEY,
  owner varchar NOT NULL,
  balance bigint NOT NULL,
  currency varchar NOT NULL,
  created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE entries (
  id serial PRIMARY KEY,
  account_id bigint NOT NULL,
  amount bigint NOT NULL,
  created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE transfers (
  id serial PRIMARY KEY,
  from_account_id bigint NOT NULL,
  to_account_id bigint NOT NULL,
  amount bigint NOT NULL,
  created_at timestamptz NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX ON accounts (owner);
CREATE INDEX ON entries (account_id);
CREATE INDEX ON transfers (from_account_id);
CREATE INDEX ON transfers (to_account_id);
CREATE INDEX ON transfers (from_account_id, to_account_id);

COMMENT ON COLUMN entries.amount IS 'bisa negatif dan positif';
COMMENT ON COLUMN transfers.amount IS 'data harus positif';

ALTER TABLE entries ADD FOREIGN KEY (account_id) REFERENCES accounts (id);
ALTER TABLE transfers ADD FOREIGN KEY (from_account_id) REFERENCES accounts (id);
ALTER TABLE transfers ADD FOREIGN KEY (to_account_id) REFERENCES accounts (id);
