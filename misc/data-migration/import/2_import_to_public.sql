-- FILES

insert into public.file (id, shasum256, filepath, filename, extension, filetype, filesize, mime_type)
select id, shasum256, filepath, filename, extension, filetype, filesize, mime_type
from import.file;

insert into public.file_name(id, fk_vwe_file, shasum256, original_filepath, original_filename, original_extension)
select id, fk_vwe_file, shasum256, original_filepath, original_filename, original_extension
from import.file_name;

-- AUCTIONS

insert into public.location (id, city, base_currency, comment, country)
select id,
       city,
       base_currency,
       comment,
       country
from import.location;

insert into public.auction_house(id, name, description, url)
select id, name, description, url
from import.auction_house;

insert into public.auction_house_location(id, fk_auction_house, fk_location, location_detail)
select id, fk_auction_house, fk_location, location_detail
from import.auction_house_location;

insert into public.auction(id, fk_auction_house_location, fk_catalog_file, fk_result_file, date_from, date_to, title, comment, codename, total_lots, sale_total, url, was_crawled, web_record, filemaker_record, is_online_only, requires_manual_attention, filemaker_id, was_only_source_filemaker)
select id, fk_auction_house_location, fk_catalog_file, fk_result_file, date_from, date_to, title, comment, codename, total_lots, sale_total, url, was_crawled, web_record, filemaker_record, is_online_only, requires_manual_attention, filemaker_id, was_only_source_filemaker
from import.auction



