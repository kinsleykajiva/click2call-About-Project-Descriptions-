use `auth-db`;





create table if not exists companyAccessPackages
(
    id    int auto_increment
        primary key,
    title varchar(200) null
);

create table if not exists companies
(
    id                     int auto_increment
        primary key,
    apiWidgetAccessToken   longtext                           null,
    companyAccessPackageId int                                not null,
    dateCreated            datetime default CURRENT_TIMESTAMP null,
    dnsTxtRecord           longtext                           null,
    domain                 longtext                           null,
    isDomainVerified       int      default 0                 not null,
    title                  varchar(200)                       not null,
    isDeleted              int      default 0                 null,
    deleteDate             datetime                           null,
    constraint companies_companyAccessPackages_id_fk
        foreign key (companyAccessPackageId) references companyAccessPackages (id)
);

create table if not exists domains
(
    id           int auto_increment
        primary key,
    companyId    int           null,
    domain       text          null,
    dnsTxtRecord text          null,
    isVerified   int default 0 null
);

create table if not exists generalLog
(
    id          int auto_increment
        primary key,
    location    text                               null,
    userId      int      default 0                 null,
    ipAddress   varchar(222)                       null,
    url         text                               null,
    dateCreated datetime default CURRENT_TIMESTAMP null
)
    comment 'to track the users access';

create table if not exists hibernate_sequence
(
    next_val bigint null
);

create table if not exists lastLogins
(
    id          int auto_increment
        primary key,
    userId      int      default 0                 null,
    client      varchar(90)                        null,
    dateCreated datetime default CURRENT_TIMESTAMP null
);

create table if not exists roles
(
    id    int auto_increment
        primary key,
    title varchar(200) null
);

create table if not exists statuses
(
    id    int auto_increment
        primary key,
    title varchar(200) null
);

create table if not exists users
(
    id                     int auto_increment
        primary key,
    companyId              int                                null,
    statusId               int                                null,
    email                  varchar(200)                       null,
    fullName               varchar(200)                       null,
    isEmailAddressVerified int                                null,
    lastTimeOnline         datetime(6)                        null,
    passwordHash           longtext                           null,
    profileImageUrl        longtext                           null,
    roleId                 int                                null,
    dateCreated            datetime default CURRENT_TIMESTAMP null,
    accountActivationCode  text                               null,
    isDeleted              int      default 0                 null,
    constraint users_companies_id_fk
        foreign key (companyId) references companies (id),
    constraint users_roles_id_fk
        foreign key (roleId) references roles (id),
    constraint users_statuses_id_fk
        foreign key (statusId) references statuses (id)
);

create table if not exists organisations
(
    id                   int auto_increment
        primary key,
    companyId            int                                null,
    dateCreated          datetime default CURRENT_TIMESTAMP null,
    savedByUserId        int                                null,
    title                varchar(200)                       not null,
    url                  text                               null,
    companyTax           varchar(222)                       null,
    companyAddress       text                               null,
    unitNumberStreetName text                               null,
    city                 text                               null,
    province             text                               null,
    postalCode           varchar(100)                       null,
    profileImageUrl      text                               null,
    country              varchar(200)                       null,
    constraint organisations_companies_id_fk
        foreign key (companyId) references companies (id),
    constraint organisations_users_id_fk
        foreign key (savedByUserId) references users (id)
);

create table if not exists teams
(
    id              int auto_increment
        primary key,
    companyId       int                                null,
    createdByUserId int                                null,
    description     text                               null,
    organisationId  int      default 0                 null,
    dateCreated     datetime default CURRENT_TIMESTAMP null,
    title           varchar(200)                       not null,
    constraint teams_companies_id_fk
        foreign key (companyId) references companies (id),
    constraint teams_users_id_fk
        foreign key (createdByUserId) references users (id)
);

create table if not exists teamGroups
(
    id          int auto_increment
        primary key,
    dateCreated datetime default CURRENT_TIMESTAMP null,
    teamId      int                                null,
    userId      int                                null,
    constraint teamGroups_teams_id_fk
        foreign key (teamId) references teams (id),
    constraint teamGroups_users_id_fk
        foreign key (userId) references users (id)
);

create table if not exists teamGroups_userList
(
    TeamGroup_id int not null,
    userList_id  int not null,
    constraint UK_vf13cvsbfxaabrkxxi3w0wfv
        unique (userList_id),
    constraint FKdd48p11nj9m4srv9y071748s1
        foreign key (TeamGroup_id) references teamGroups (id),
    constraint FKhm4mkd12e2r0sca8v2br18u86
        foreign key (userList_id) references users (id)
);

create table if not exists users_roles
(
    User_id  int not null,
    roles_id int not null,
    roleId   int not null,
    id       int not null,
    constraint FK8gquw7h1ooiijjv2iw3nq0ybr
        foreign key (id) references roles (id),
    constraint FKa62j07k5mhgifpp955h37ponj
        foreign key (roles_id) references roles (id),
    constraint FKe6k7h92pkxjim6t1176b7h95x
        foreign key (User_id) references users (id),
    constraint FKmtgjlgl02y4ikj31mltgkpcgi
        foreign key (roleId) references users (id)
);

create table if not exists widgets
(
    id                         int auto_increment
        primary key,
    backgroundHexColorCode     varchar(11)   null,
    codeSnippets               longtext      null,
    companyId                  int           null,
    enableSocialMediaBarOption int           null,
    iconUrl                    longtext      null,
    linkedInUrl                longtext      null,
    messengerUrl               longtext      null,
    nameShown                  varchar(200)  null,
    topBarMessage              varchar(200)  null,
    whatsAppUrl                longtext      null,
    isActive                   int default 1 null,
    constraint widgets_companies_id_fk
        foreign key (companyId) references companies (id)
);


use `calls-messages`;



create table if not exists `chat-conversations`
(
    id              int auto_increment
        primary key,
    senderId        int           null,
    mergeId         text          null,
    messageTypeId   int default 1 null,
    content         text          null,
    updateTimestamp datetime      null,
    hasRead         int           null,
    dateCreated     datetime      null,
    ticketId        int default 0 null,
    recipientId     int           null,
    isAgent         int default 0 null
);

create table if not exists customers
(
    id              int auto_increment
        primary key,
    fullName        mediumtext    null,
    phoneNumber     mediumtext    null,
    email           mediumtext    null,
    notes           text          null,
    dateCreated     datetime      null,
    companyId       int           null,
    address         text          null,
    updateTimestamp datetime      null,
    isCustomer      int default 0 null,
    unifierId       text          null
)
    comment 'will have all the uses that come to use the widget to interface with the agents';

create table if not exists messageTypes
(
    id    int        null,
    title mediumtext null
);

create table if not exists pendingIncomings
(
    id                int auto_increment
        primary key,
    senderId          int           null,
    messageTypeId     int default 0 null,
    content           text          null,
    handledByDateTime datetime      null,
    companyId         int           null,
    handledByUserId   int           null,
    dateCreated       datetime      null,
    constraint pendingIncomings_id_uindex
        unique (id)
)
    comment 'this will store all pding chats , calls incoming ';


use `cron-jobs`;


create table if not exists QRTZ_CALENDARS
(
    SCHED_NAME    varchar(120) not null,
    CALENDAR_NAME varchar(190) not null,
    CALENDAR      blob         not null,
    primary key (SCHED_NAME, CALENDAR_NAME)
);

create table if not exists QRTZ_FIRED_TRIGGERS
(
    SCHED_NAME        varchar(120) not null,
    ENTRY_ID          varchar(95)  not null,
    TRIGGER_NAME      varchar(190) not null,
    TRIGGER_GROUP     varchar(190) not null,
    INSTANCE_NAME     varchar(190) not null,
    FIRED_TIME        bigint(13)   not null,
    SCHED_TIME        bigint(13)   not null,
    PRIORITY          int          not null,
    STATE             varchar(16)  not null,
    JOB_NAME          varchar(190) null,
    JOB_GROUP         varchar(190) null,
    IS_NONCONCURRENT  varchar(1)   null,
    REQUESTS_RECOVERY varchar(1)   null,
    primary key (SCHED_NAME, ENTRY_ID)
);

create index IDX_QRTZ_FT_INST_JOB_REQ_RCVRY
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME, REQUESTS_RECOVERY);

create index IDX_QRTZ_FT_JG
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_J_G
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_FT_TG
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_FT_TRIG_INST_NAME
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, INSTANCE_NAME);

create index IDX_QRTZ_FT_T_G
    on QRTZ_FIRED_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create table if not exists QRTZ_JOB_DETAILS
(
    SCHED_NAME        varchar(120) not null,
    JOB_NAME          varchar(190) not null,
    JOB_GROUP         varchar(190) not null,
    DESCRIPTION       varchar(250) null,
    JOB_CLASS_NAME    varchar(250) not null,
    IS_DURABLE        varchar(1)   not null,
    IS_NONCONCURRENT  varchar(1)   not null,
    IS_UPDATE_DATA    varchar(1)   not null,
    REQUESTS_RECOVERY varchar(1)   not null,
    JOB_DATA          blob         null,
    primary key (SCHED_NAME, JOB_NAME, JOB_GROUP)
);

create index IDX_QRTZ_J_GRP
    on QRTZ_JOB_DETAILS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_J_REQ_RECOVERY
    on QRTZ_JOB_DETAILS (SCHED_NAME, REQUESTS_RECOVERY);

create table if not exists QRTZ_LOCKS
(
    SCHED_NAME varchar(120) not null,
    LOCK_NAME  varchar(40)  not null,
    primary key (SCHED_NAME, LOCK_NAME)
);

create table if not exists QRTZ_PAUSED_TRIGGER_GRPS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_GROUP varchar(190) not null,
    primary key (SCHED_NAME, TRIGGER_GROUP)
);

create table if not exists QRTZ_SCHEDULER_STATE
(
    SCHED_NAME        varchar(120) not null,
    INSTANCE_NAME     varchar(190) not null,
    LAST_CHECKIN_TIME bigint(13)   not null,
    CHECKIN_INTERVAL  bigint(13)   not null,
    primary key (SCHED_NAME, INSTANCE_NAME)
);

create table if not exists QRTZ_TRIGGERS
(
    SCHED_NAME     varchar(120) not null,
    TRIGGER_NAME   varchar(190) not null,
    TRIGGER_GROUP  varchar(190) not null,
    JOB_NAME       varchar(190) not null,
    JOB_GROUP      varchar(190) not null,
    DESCRIPTION    varchar(250) null,
    NEXT_FIRE_TIME bigint(13)   null,
    PREV_FIRE_TIME bigint(13)   null,
    PRIORITY       int          null,
    TRIGGER_STATE  varchar(16)  not null,
    TRIGGER_TYPE   varchar(8)   not null,
    START_TIME     bigint(13)   not null,
    END_TIME       bigint(13)   null,
    CALENDAR_NAME  varchar(190) null,
    MISFIRE_INSTR  smallint(2)  null,
    JOB_DATA       blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, JOB_NAME, JOB_GROUP) references QRTZ_JOB_DETAILS (SCHED_NAME, JOB_NAME, JOB_GROUP)
);

create table if not exists QRTZ_BLOB_TRIGGERS
(
    SCHED_NAME    varchar(120) not null,
    TRIGGER_NAME  varchar(190) not null,
    TRIGGER_GROUP varchar(190) not null,
    BLOB_DATA     blob         null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_BLOB_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create index SCHED_NAME
    on QRTZ_BLOB_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP);

create table if not exists QRTZ_CRON_TRIGGERS
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(190) not null,
    TRIGGER_GROUP   varchar(190) not null,
    CRON_EXPRESSION varchar(120) not null,
    TIME_ZONE_ID    varchar(80)  null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_CRON_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create table if not exists QRTZ_SIMPLE_TRIGGERS
(
    SCHED_NAME      varchar(120) not null,
    TRIGGER_NAME    varchar(190) not null,
    TRIGGER_GROUP   varchar(190) not null,
    REPEAT_COUNT    bigint(7)    not null,
    REPEAT_INTERVAL bigint(12)   not null,
    TIMES_TRIGGERED bigint(10)   not null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_SIMPLE_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create table if not exists QRTZ_SIMPROP_TRIGGERS
(
    SCHED_NAME    varchar(120)   not null,
    TRIGGER_NAME  varchar(190)   not null,
    TRIGGER_GROUP varchar(190)   not null,
    STR_PROP_1    varchar(512)   null,
    STR_PROP_2    varchar(512)   null,
    STR_PROP_3    varchar(512)   null,
    INT_PROP_1    int            null,
    INT_PROP_2    int            null,
    LONG_PROP_1   bigint         null,
    LONG_PROP_2   bigint         null,
    DEC_PROP_1    decimal(13, 4) null,
    DEC_PROP_2    decimal(13, 4) null,
    BOOL_PROP_1   varchar(1)     null,
    BOOL_PROP_2   varchar(1)     null,
    primary key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP),
    constraint QRTZ_SIMPROP_TRIGGERS_ibfk_1
        foreign key (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP) references QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP)
);

create index IDX_QRTZ_T_C
    on QRTZ_TRIGGERS (SCHED_NAME, CALENDAR_NAME);

create index IDX_QRTZ_T_G
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP);

create index IDX_QRTZ_T_J
    on QRTZ_TRIGGERS (SCHED_NAME, JOB_NAME, JOB_GROUP);

create index IDX_QRTZ_T_JG
    on QRTZ_TRIGGERS (SCHED_NAME, JOB_GROUP);

create index IDX_QRTZ_T_NEXT_FIRE_TIME
    on QRTZ_TRIGGERS (SCHED_NAME, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_MISFIRE
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE, NEXT_FIRE_TIME);

create index IDX_QRTZ_T_NFT_ST_MISFIRE
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_STATE);

create index IDX_QRTZ_T_NFT_ST_MISFIRE_GRP
    on QRTZ_TRIGGERS (SCHED_NAME, MISFIRE_INSTR, NEXT_FIRE_TIME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_N_G_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_N_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_NAME, TRIGGER_GROUP, TRIGGER_STATE);

create index IDX_QRTZ_T_STATE
    on QRTZ_TRIGGERS (SCHED_NAME, TRIGGER_STATE);



use `statistics`;

create table if not exists widgetAccess
(
    id          int auto_increment
        primary key,
    apiKey      varchar(120)                       null,
    domain      text                               null,
    ipAddress   varchar(120)                       null,
    agent       text                               null,
    dateCreated datetime default CURRENT_TIMESTAMP null
);



use `ticketing`;

create table if not exists ticketHandlers
(
    id            int auto_increment
        primary key,
    userId        int                                null,
    savedByUserId int                                null,
    dateCreated   datetime default CURRENT_TIMESTAMP null,
    ticketId      int                                null
);

create table if not exists ticketHandlersTracking
(
    id               int auto_increment
        primary key,
    assignedToUserId int                                null,
    assignedByUserId int                                null,
    ticketId         int                                null,
    dateCreated      datetime default CURRENT_TIMESTAMP null
);

create table if not exists ticketLifeCycle
(
    id            int auto_increment
        primary key,
    ticketId      int                                null,
    oldStatusId   int                                null,
    savedByUserId int                                null,
    dateCreated   datetime default CURRENT_TIMESTAMP null,
    newStatusId   int                                null
);

create table if not exists ticketPriorities
(
    id    int auto_increment
        primary key,
    title text null
);

create table if not exists ticketStatuses
(
    id    int auto_increment
        primary key,
    title varchar(200) null
);

create table if not exists ticketTicketTags
(
    id             int auto_increment
        primary key,
    ticketId       int  null,
    ticketTagId    int  null,
    ticketTagTitle text null
);

create table if not exists tickets
(
    id              int auto_increment
        primary key,
    title           text                               null,
    statusId        int                                null,
    companyId       int                                null,
    createdByUserId int                                null,
    dateCreated     datetime default CURRENT_TIMESTAMP null,
    priorityId      int      default 3                 not null,
    constraint tickets_ticketStatuses_id_fk
        foreign key (statusId) references ticketStatuses (id)
);

create table if not exists ticketsTags
(
    id    int auto_increment
        primary key,
    title text not null
)
    comment 'will have all the tagges associated with tickets';





