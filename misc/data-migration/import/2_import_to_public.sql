-- TRUNCATE
truncate public.file_name, public.auction, public.file, public.auction_house_location, public.auction_house, public.location;

-- FILES

insert into public.file (id, shasum256, filepath, filename, extension, filetype, filesize, mime_type)
select cast(id as uuid),
       shasum256,
       filepath,
       filename,
       extension,
       filetype,
       cast(filesize as integer),
       mime_type
from import.file;

insert into public.file_name(id, fk_file, shasum256, original_filepath, original_filename, original_extension)
select cast(id as uuid),
       cast(fk_vwe_file as uuid),
       shasum256,
       original_filepath,
       original_filename,
       original_extension
from import.file_name;

-- AUCTIONS
insert into public.location (id, city, base_currency, comment, country)
select cast(id as uuid),
       city,
       base_currency,
       comment,
       country
from import.location;

insert into public.auction_house(id, name, description, url)
select cast(id as uuid),
       name,
       description,
       url
from import.auction_house;

insert into public.auction_house_location(id, fk_auction_house, fk_location, location_detail)
select cast(id as uuid),
       cast(fk_auction_house as uuid),
       cast(fk_location as uuid),
       location_detail
from import.auction_house_location;

insert into public.auction(id, fk_auction_house_location, fk_catalog_file, fk_result_file, date_from, date_to, title,
                           comment, codename, total_lots, sale_total, url, was_crawled, web_record, filemaker_record,
                           is_online_only, requires_manual_attention, filemaker_id, was_only_source_filemaker)
select cast(id as uuid),
       cast(fk_auction_house_location as uuid),
       cast(fk_catalog_file as uuid),
       cast(fk_result_file as uuid),
       cast(date_from as date),
       cast(date_to as date),
       title,
       comment,
       codename,
       cast(total_lots as integer),
       cast(sale_total as bigint),
       url,
       cast(was_crawled as bool),
       cast(web_record as jsonb),
       cast(filemaker_record as jsonb),
       cast(is_online_only as bool),
       cast(requires_manual_attention as bool),
       cast(filemaker_id as uuid),
       cast(was_only_source_filemaker as bool)
from import.auction



