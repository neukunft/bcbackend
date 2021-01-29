create extension if not exists pgcrypto;
create extension if not exists hstore;

create table file
(
    id        uuid primary key default gen_random_uuid(),
    shasum256 varchar(64) not null,
    filepath  text        not null,
    filename  text        not null,
    extension text,
    filetype  text,
    filesize  integer,
    mime_type text,
    unique (shasum256)
);

create table file_name
(
    id                 uuid primary key default gen_random_uuid() not null,
    fk_file        uuid,
    shasum256          varchar(64),
    original_filepath  text,
    original_filename  text,
    original_extension text,
    unique (original_filepath, original_filename)
);

create table auction_house
(
    id          uuid primary key default gen_random_uuid(),
    name        text not null,
    description text,
    url         text,
    unique (name),
    unique (url)
);

create table location
(
    id            uuid primary key default gen_random_uuid(),
    city          text not null,
    country       text,
    base_currency varchar(3),
    comment       text
);

create table auction_house_location
(
    id               uuid primary key default gen_random_uuid(),
    fk_auction_house uuid references auction_house,
    fk_location      uuid references location,
    location_detail  text
);

create table auction
(
    id                        uuid primary key default gen_random_uuid(),
    fk_auction_house_location uuid references auction_house_location,
    fk_catalog_file           uuid references file,
    fk_result_file            uuid references file,
    date_from                 date not null,
    date_to                   date not null check ( date_to >= auction.date_from ),
    title                     text,
    comment                   text,
    codename                  text,
    total_lots                bigint,
    sale_total                bigint,
    url                       text,
    was_crawled               boolean          default false,
    web_record                jsonb,
    filemaker_record          jsonb,
    is_online_only            boolean          default false,
    requires_manual_attention boolean          default false,
    filemaker_id              uuid,
    was_only_source_filemaker boolean          default false
);
