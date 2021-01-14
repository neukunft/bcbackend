create extension if not exists pgcrypto;
create extension if not exists hstore;

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
    id      uuid primary key default gen_random_uuid(),
    name    text not null,
    comment text
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
    id uuid primary key default gen_random_uuid()
);
