----- TEMPORARILY REMOVE TRIGGER TO IMPROVE PERFORMANCE
DROP TRIGGER IF EXISTS tsvectorupdate ON web_auction_lot;

TRUNCATE public.web_auction CASCADE;
TRUNCATE public.web_auction_lot CASCADE;
TRUNCATE public.web_auction_lot_image CASCADE;

INSERT INTO public.web_auction (id, auction_date, auction_house_name, auction_location, auction_location_detail,
                                auction_title, comment, date_to, date_from, internal_auction_name, lot_count,
                                sale_total, url, base_currency)
SELECT id,
       auction_date,
       auction_house_name,
       auction_location,
       auction_location_detail,
       auction_title,
       comment,
       date_to,
       date_from,
       internal_auction_name,
       lot_count,
       sale_total,
       url,
       base_currency
FROM import.web_auction
WHERE cast(id as uuid) NOT IN (SELECT id from web_auction);

INSERT INTO public.web_auction_lot (id, fk_web_auction, "attributes", auction_house_name, calibre, case_number,
                                    currency, dimensions, estimate, internal_auction_name, lot_number,
                                    lot_number_addition, material, model_name, movement_number, maker,
                                    production_date, sale_price, url, reference, sale_price_in_usd,
                                    estimate_to_in_usd, estimate_from_in_usd, estimate_from, estimate_to,
                                    estimate_currency, was_sold)
SELECT id,
       fk_web_auction,
       attributes,
       auction_house_name,
       calibre,
       case_number,
       currency,
       dimensions,
       estimate,
       internal_auction_name,
       lot_number,
       lot_number_addition,
       material,
       model_name,
       movement_number,
       maker,
       production_date,
       sale_price,
       url,
       reference,
       sale_price_in_usd,
       estimate_to_in_usd,
       estimate_from_in_usd,
       estimate_from,
       estimate_to,
       estimate_currency,
       was_sold
FROM import.web_auction_lot
ON CONFLICT do nothing;

INSERT INTO public.web_auction_lot_image (id, fk_web_auction_lot, image_url, filepath, filename,
                                          filename_hashed,
                                          extension)
SELECT id, fk_web_auction_lot, image_url, filepath, filename, filename_hashed, extension
FROM import.web_auction_lot_image
ON CONFLICT do nothing;

INSERT INTO public.exchange_rate (currency, date, value, base_currency)
SELECT cast(currency as currencycode),
       cast("YYYY/MM/DD" as date),
       value,
       cast(base_currency as currencycode)
FROM import.historical_exchange_rates
ON CONFLICT do nothing;

----- UPDATE SEARCH & RE-APPLY TRIGGER
update web_auction_lot
set attribute_searchable_index_col = (
                                                    setweight(to_tsvector('pg_catalog.english',
                                                                          coalesce(auction_house_name, '')),
                                                              'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(calibre, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(case_number, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(dimensions, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(lot_number, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(material, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(model_name, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(movement_number, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(production_date, '')),
                                                            'A') ||
                                                    setweight(
                                                            to_tsvector('pg_catalog.english', coalesce(reference, '')),
                                                            'A') ||
                                                    setweight(to_tsvector('pg_catalog.english',
                                                                          coalesce(attributes ->> 'Lot Title', '')),
                                                              'B') ||
                                                    setweight(to_tsvector('pg_catalog.english',
                                                                          coalesce(attributes ->> 'Lot Details', '')),
                                                              'C') ||
                                                    setweight(to_tsvector('pg_catalog.english',
                                                                          coalesce(attributes ->> 'Essay', '')),
                                                              'D'))
WHERE true
;

CREATE TRIGGER tsvectorupdate
    BEFORE INSERT OR UPDATE
    ON web_auction_lot
    FOR EACH ROW
EXECUTE FUNCTION lot_search_update_trigger();
