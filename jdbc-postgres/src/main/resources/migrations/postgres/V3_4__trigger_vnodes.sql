ALTER TABLE triggers add "vnode" INTEGER GENERATED ALWAYS AS (CAST(value ->> 'vnode' AS INTEGER)) STORED; 
ALTER TABLE triggers add "locked" BOOLEAN GENERATED ALWAYS AS (CAST(value ->> 'locked' AS BOOLEAN)) STORED; 

CREATE INDEX IF NOT EXISTS idx_triggers_vnode ON triggers (vnode); 
CREATE INDEX IF NOT EXISTS idx_triggers_locked ON triggers (locked); 

CREATE TABLE IF NOT EXISTS queue_trigger_event ( 
    "offset" BIGSERIAL PRIMARY KEY, key VARCHAR(250),
    value JSONB NOT NULL, 
    vnode SMALLINT NOT NULL, 
    created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
); 

CREATE INDEX IF NOT EXISTS ix_queue_trigger_event_vnode_offset ON queue_trigger_event (vnode, "offset");

CREATE TABLE IF NOT EXISTS queue_scheduler_event (
    "offset" BIGSERIAL PRIMARY KEY, key VARCHAR(250), 
    value JSONB NOT NULL, 
    created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP 
);