CREATE TABLE e2e_users (
	id UUID NOT NULL,
	created_at TIMESTAMP NOT NULL,
	updated_at TIMESTAMP NOT NULL,
	username VARCHAR(255) NULL,
	CONSTRAINT "primary" PRIMARY KEY (id ASC),
	FAMILY "primary" (id, created_at, updated_at, username)
);

CREATE TABLE e2e_user_notes (
	id UUID NOT NULL,
	user_id UUID NOT NULL,
	slug VARCHAR(64) NOT NULL,
	notes VARCHAR(255) NULL,
	CONSTRAINT "primary" PRIMARY KEY (id ASC),
	INDEX e2e_user_notes_user_id_idx (user_id ASC),
	UNIQUE INDEX e2e_user_notes_slug_idx (slug ASC),
	FAMILY "primary" (id, user_id, slug, notes)
);

CREATE TABLE schema_migration (
	version VARCHAR(14) NOT NULL,
	UNIQUE INDEX schema_migration_version_idx (version ASC),
	FAMILY "primary" (version, rowid)
);

ALTER TABLE e2e_user_notes ADD CONSTRAINT e2e_user_notes_e2e_users_id_fk FOREIGN KEY (user_id) REFERENCES e2e_users(id) ON DELETE CASCADE;

-- Validate foreign key constraints. These can fail if there was unvalidated data during the dump.
ALTER TABLE e2e_user_notes VALIDATE CONSTRAINT e2e_user_notes_e2e_users_id_fk;
