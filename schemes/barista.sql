CREATE DATABASE IF NOT EXISTS barista_mgmt;

USE barista_mgmt;

DROP TABLE IF EXISTS switch_mgmt;
CREATE TABLE switch_mgmt
(
    DPID		BIGINT UNSIGNED NOT NULL,
    MFR_DESC		VARCHAR(256),
    HW_DESC		VARCHAR(256),
    SW_DESC		VARCHAR(256),
    SERIAL_NUM		VARCHAR(32),
    DP_DESC		VARCHAR(256),
    PKT_COUNT		BIGINT UNSIGNED,
    BYTE_COUNT		BIGINT UNSIGNED,
    FLOW_COUNT		INT UNSIGNED,
    UP_TIME             DATETIME DEFAULT CURRENT_TIMESTAMP,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY(DPID)
);

DROP TABLE IF EXISTS topo_mgmt;
CREATE TABLE topo_mgmt
(
    SRC_DPID            BIGINT UNSIGNED NOT NULL,
    SRC_PORT            INT UNSIGNED NOT NULL,
    DST_DPID            BIGINT UNSIGNED NOT NULL,
    DST_PORT            INT UNSIGNED NOT NULL,
    RX_PACKETS          BIGINT UNSIGNED,
    RX_BYTES            BIGINT UNSIGNED,
    TX_PACKETS          BIGINT UNSIGNED,
    TX_BYTES            BIGINT UNSIGNED,
    INSTANCE            VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS host_mgmt;
CREATE TABLE host_mgmt
(
    TIME                DATETIME DEFAULT CURRENT_TIMESTAMP,
    DPID                BIGINT UNSIGNED NOT NULL,
    PORT                INT UNSIGNED NOT NULL,
    IP                  INT UNSIGNED NOT NULL,
    MAC                 BIGINT UNSIGNED NOT NULL,
    INSTANCE            VARCHAR(32) NOT NULL,
    PRIMARY KEY(DPID, MAC)
);

DROP TABLE IF EXISTS flow_mgmt;
CREATE TABLE flow_mgmt
(
    TIME                DATETIME DEFAULT CURRENT_TIMESTAMP,
    DPID                BIGINT UNSIGNED,
    PORT                INT UNSIGNED,
    IDLE_TIMEOUT        INT UNSIGNED NOT NULL,
    HARD_TIMEOUT        INT UNSIGNED NOT NULL,
    WILDCARDS           INT UNSIGNED,
    VLAN_ID             INT UNSIGNED,
    VLAN_PCP            INT UNSIGNED,
    PROTOCOL            INT UNSIGNED,
    IP_TOS              INT UNSIGNED,
    SOURCE_MAC          BIGINT UNSIGNED,
    DESTINATION_MAC     BIGINT UNSIGNED,
    SOURCE_IP           INT UNSIGNED,
    DESTINATION_IP      INT UNSIGNED,
    SOURCE_PORT         SMALLINT UNSIGNED,
    DESTINATION_PORT    SMALLINT UNSIGNED,
    ACTIONS             VARCHAR(256),
    PKT_COUNT           BIGINT UNSIGNED,
    BYTE_COUNT          BIGINT UNSIGNED,
    INSTANCE            VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS resource_mgmt;
CREATE TABLE resource_mgmt
(
    ID			BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    TIME                DATETIME DEFAULT CURRENT_TIMESTAMP,
    CPU                 DOUBLE NOT NULL,
    MEM                 DOUBLE NOT NULL,
    INSTANCE            VARCHAR(32) NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS channel_mgmt;
CREATE TABLE channel_mgmt
(
    ID			BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    TIME                DATETIME DEFAULT CURRENT_TIMESTAMP,
    IN_PKT_CNT          BIGINT UNSIGNED NOT NULL,
    IN_BYTE_CNT         BIGINT UNSIGNED NOT NULL,
    OUT_PKT_CNT         BIGINT UNSIGNED NOT NULL,
    OUT_BYTE_CNT        BIGINT UNSIGNED NOT NULL,
    INSTANCE            VARCHAR(32) NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS logs;
CREATE TABLE logs
(
    ID			BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    TIME		DATETIME DEFAULT CURRENT_TIMESTAMP,
    MESSAGE             VARCHAR(1024) NOT NULL,
    INSTANCE            VARCHAR(32) NOT NULL,
    PRIMARY KEY (ID)
);

DROP TABLE IF EXISTS cluster_events;
CREATE TABLE cluster_events
(
    ID			BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    EV_ID		INT UNSIGNED NOT NULL,
    EV_TYPE		INT UNSIGNED NOT NULL,
    EV_LENGTH		INT UNSIGNED NOT NULL,
    DATA		VARCHAR(2048) NOT NULL,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY (ID)
);

CREATE DATABASE IF NOT EXISTS barista;

USE barista;

DROP TABLE IF EXISTS components;
CREATE TABLE components
(
    COMPNT_ID		INT UNSIGNED NOT NULL,
    COMPNT_NAME		VARCHAR(256) NOT NULL,
    COMPNT_ARGS		VARCHAR(256),
    COMPNT_TYPE		INT NOT NULL,
    COMPNT_SITE		INT NOT NULL,
    COMPNT_ROLE		INT NOT NULL,
    COMPNT_PERM		INT NOT NULL,
    COMPNT_STATUS	INT NOT NULL,
    COMPNT_PRIORITY	INT NOT NULL,
    COMPNT_ACTIVATED	INT NOT NULL,
    UP_TIME		DATETIME,
    DOWN_TIME		DATETIME,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY(COMPNT_ID)
);

DROP TABLE IF EXISTS applications;
CREATE TABLE applications
(
    APP_ID		INT UNSIGNED NOT NULL,
    APP_NAME		VARCHAR(256) NOT NULL,
    APP_ARGS		VARCHAR(256),
    APP_TYPE		INT NOT NULL,
    APP_SITE		INT NOT NULL,
    APP_ROLE		INT NOT NULL,
    APP_PERM		INT NOT NULL,
    APP_STATUS		INT NOT NULL,
    APP_PRIORITY	INT NOT NULL,
    APP_ACTIVATED	INT NOT NULL,
    UP_TIME		DATETIME,
    DOWN_TIME		DATETIME,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY(APP_ID)
);

DROP TABLE IF EXISTS events;
CREATE TABLE events
(
    COMPNT_ID		INT NOT NULL,
    EV_ID		INT NOT NULL,
    EV_PERM		INT NOT NULL,
    INSTANCE		VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS event_list;
CREATE TABLE event_list
(
    EV_ID		INT NOT NULL,
    EV_NAME		VARCHAR(32) NOT NULL,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY(EV_ID)
);

DROP TABLE IF EXISTS app_events;
CREATE TABLE app_events
(
    APP_ID		INT NOT NULL,
    AV_ID		INT NOT NULL,
    AV_PERM		INT NOT NULL,
    INSTANCE		VARCHAR(32) NOT NULL
);

DROP TABLE IF EXISTS app_event_list;
CREATE TABLE app_event_list
(
    AV_ID		INT NOT NULL,
    AV_NAME		VARCHAR(32) NOT NULL,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY(AV_ID)
);

DROP TABLE IF EXISTS operator_defined_policy;
CREATE TABLE operator_defined_policy
(
    ID			INT UNSIGNED NOT NULL,
    DPID		BIGINT UNSIGNED,
    PORT		SMALLINT UNSIGNED,
    PROTOCOL		SMALLINT UNSIGNED,
    VLAN		SMALLINT UNSIGNED,
    SRC_IP		INT UNSIGNED,
    DST_IP		INT UNSIGNED,
    SRC_PORT		SMALLINT UNSIGNED,
    DST_PORT		SMALLINT UNSIGNED,
    INSTANCE		VARCHAR(32) NOT NULL
);

CREATE DATABASE IF NOT EXISTS l2_learning;

USE l2_learning;

DROP TABLE IF EXISTS forwarding_table;
CREATE TABLE forwarding_table
(
    DPID		BIGINT UNSIGNED NOT NULL,
    PORT		INT UNSIGNED NOT NULL,
    MAC			BIGINT UNSIGNED NOT NULL,
    IP			INT UNSIGNED NOT NULL,
    INSTANCE		VARCHAR(32) NOT NULL,
    PRIMARY KEY(DPID, MAC)
);
