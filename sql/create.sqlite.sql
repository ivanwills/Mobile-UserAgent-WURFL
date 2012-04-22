CREATE TABLE capability (
    device_id VARCHAR(255) NOT NULL default '',
    name      VARCHAR(255) NOT NULL default '',
    value     VARCHAR(255) default '',
    group_id  VARCHAR(255) NOT NULL default '',
    ts        TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX groupid ON capability (group_id);
CREATE INDEX name_device_id ON capability (name, device_id);

CREATE TABLE device (
    device_id          VARCHAR(255) NOT NULL default '',
    user_agent         VARCHAR(255) NOT NULL default '',
    actual_device_root VARCHAR(255),
    fall_back          VARCHAR(255) NOT NULL default '',
    ts                 TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP
);
CREATE INDEX user_agent ON device (user_agent);
CREATE INDEX device_id ON device (device_id);

