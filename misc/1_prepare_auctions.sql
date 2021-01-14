create table import.auctions
(
    id                        uuid                  not null,
    auction_house_name        text                  not null,
    date_from                 date                  not null,
    date_to                   date,
    location                  text                  not null,
    location_detail           text,
    catalog_sha256            text,
    result_sha256             text,
    title                     text,
    comment                   text,
    codename                  text,
    total_lots                integer,
    sale_total                integer,
    url                       text,
    base_currency             text,
    was_crawled               boolean default false not null,
    web_record                jsonb,
    filemaker_record          jsonb,
    is_online_only            boolean               not null,
    requires_manual_attention boolean               not null,
    was_only_source_filemaker boolean               not null,
    filemaker_id              uuid
);

update import.auctions
set base_currency = 'CHF'
where location in ('Geneva', 'Zürich', 'Basel')
  and base_currency isnull ;

update import.auctions
set base_currency = 'USD'
where location in ('New York', 'Los Angeles')
  and base_currency isnull ;

update import.auctions
set base_currency = 'EUR'
where location in ('Mönchengladbach', 'Düsseldorf', 'Frankfurt', 'Madrid', 'Amsterdam', 'Hamburg', 'Mannheim', 'Cologne', 'Lindau', 'Stuttgart', 'Reutlingen', 'Paris', 'Milano', 'Rome')
  and base_currency isnull ;



update import.auctions
set base_currency = 'HKD'
where location in ('Hong Kong')
  and base_currency isnull ;

update import.auctions
set base_currency = 'GBP'
where location in ('London', 'Oxford', 'Newbury, UK')
  and base_currency isnull ;

update import.auctions
set base_currency = 'DEM'
where location in ('Aachen')
  and base_currency isnull ;

select distinct location, count(location)
from import.auctions
where base_currency isnull
group by location;

-- create locations
create table import.location
(
    id   uuid primary key default gen_random_uuid(),
    name text not null,
    base_currency text,
    unique (name)
);

insert into import.location (name)
select distinct location
from import.auctions
order by location;

-- create auction_house
create table import.auction_house
(
    id   uuid primary key default gen_random_uuid(),
    name text not null,
    unique (name)
);

insert into import.auction_house (name)
select distinct auction_house_name
from import.auctions;

-- create auction_house_locations
create table import.auction_house_location
(
    id               uuid primary key default gen_random_uuid(),
    fk_auction_house uuid references import.auction_house not null,
    fk_location      uuid references import.location      not null,
    location_detail  text,
    unique (fk_auction_house, fk_location, location_detail)
);

insert into import.auction_house_location (fk_auction_house, fk_location, location_detail)
select distinct ah.id, l.id, a.location_detail
from import.auctions a
         left join import.auction_house ah on ah.name = a.auction_house_name
         left join import.location l on l.name = a.location;

-- add auction_house_location to auctions
update import.auctions
set location_detail = 'No Details'
where location_detail isnull;

update import.auction_house_location
set location_detail = 'No Details'
where location_detail isnull;

update import.auctions a
set fk_auction_house_location = ahl.id
from import.auction_house_location ahl
         left join import.auction_house ah on ahl.fk_auction_house = ah.id
         left join import.location l on ahl.fk_location = l.id
where a.location_detail = ahl.location_detail
  and a.location = l.name
  and a.auction_house_name = ah.name;

