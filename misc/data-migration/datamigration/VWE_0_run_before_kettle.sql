-- run this file before importing with kettle to update VWE data only

TRUNCATE import.reference CASCADE;
TRUNCATE import.reference_series CASCADE;
TRUNCATE import.reference_series_model CASCADE;

TRUNCATE public.auction_house CASCADE;
TRUNCATE public.auction_house_location CASCADE;
TRUNCATE public.event CASCADE;
TRUNCATE public.event_description CASCADE;
TRUNCATE public.no_reference_info CASCADE;
TRUNCATE public.reference CASCADE;
TRUNCATE public.vwe_abbreviation CASCADE;
TRUNCATE public.vwe_auction CASCADE;
TRUNCATE public.vwe_auction_lot CASCADE;
TRUNCATE public.vwe_condition CASCADE;
TRUNCATE public.vwe_image CASCADE;
TRUNCATE public.vwe_image_lookup CASCADE;
TRUNCATE public.vwe_watch_feature CASCADE;
TRUNCATE public.watch CASCADE;
TRUNCATE public.maker CASCADE;
