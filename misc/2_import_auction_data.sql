-- import locations
insert into public.location (id, name, base_currency)
select id,
       name,
       base_currency
from import.location;

-- import auction_houses
insert into public.auction_house (id, name)
select id, name
from import.auction_house;

-- import auction_house_locations
insert into public.auction_house_location (id, fk_auction_house, fk_location, location_detail)
select id,
       fk_auction_house,
       fk_location,
       trim(location_detail)
from import.auction_house_location;

-- import auctions
insert into public.auction (id, fk_auction_house_location, date_from, date_to, catalog_file, result_file, title, comment, codename, total_lots,
                            sale_total, url, was_crawled, web_record, filemaker_record, is_online_only,
                            requires_manual_attention, filemaker_id, was_only_source_filemaker)
select id,
       fk_auction_house_location,
       date_from,
       date_to,
       catalog_sha256,
       result_sha256,
       title,
       comment,
       codename,
       total_lots,
       sale_total,
       url,
       was_crawled,
       web_record,
       filemaker_record,
       is_online_only,
       requires_manual_attention,
       filemaker_id,
       was_only_source_filemaker
from import.auctions;


-- remove 'NO DETAILS' from location
update public.auction_house_location
set location_detail = null
where location_detail = 'No Details';
