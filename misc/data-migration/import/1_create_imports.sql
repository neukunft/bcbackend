create schema if not exists import;

create table location
(
    id            uuid,
    city          text,
    base_currency text,
    comment       text,
    country       text
);

create table file_name
(
    id                 uuid,
    fk_vwe_file        uuid,
    shasum256          text,
    original_filepath  text,
    original_filename  text,
    original_extension text
);

create table file
(
    id        uuid,
    shasum256 text,
    filepath  text,
    filename  text,
    extension text,
    filetype  text,
    filesize  integer,
    mime_type text
);

create table auction_house_location
(
    id               uuid,
    fk_auction_house uuid,
    fk_location      uuid,
    location_detail  text
);

create table auction_house
(
    id          uuid,
    name        text,
    description text,
    url         text
);

create table auction
(
    id                        uuid,
    fk_auction_house_location uuid,
    fk_catalog_file           uuid,
    fk_result_file            uuid,
    date_from                 date,
    date_to                   date,
    title                     text,
    comment                   text,
    codename                  text,
    total_lots                integer,
    sale_total                bigint,
    url                       text,
    was_crawled               bool,
    web_record                jsonb,
    filemaker_record          jsonb,
    is_online_only            bool,
    requires_manual_attention bool,
    filemaker_id              uuid,
    was_only_source_filemaker bool
);
