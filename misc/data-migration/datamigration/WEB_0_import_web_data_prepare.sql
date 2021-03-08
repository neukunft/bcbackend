CREATE EXTENSION IF NOT EXISTS hstore;

DROP TABLE IF EXISTS import.web_auction_lot_image;
DROP TABLE IF EXISTS import.web_auction_lot;
DROP TABLE IF EXISTS import.web_auction;

CREATE TABLE IF NOT EXISTS import.web_auction
(
    id                      UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    auction_date            text,
    auction_house_name      text,
    auction_location        text,
    auction_location_detail text,
    auction_title           text,
    comment                 text,
    date_to                 date,
    date_from               date,
    internal_auction_name   text,
    lot_count               integer,
    sale_total              integer,
    url                     text,
    base_currency           text,
    UNIQUE (internal_auction_name, auction_house_name),
    UNIQUE (url)
);

CREATE TABLE IF NOT EXISTS import.web_auction_lot
(
    id                             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fk_web_auction                 uuid references import.web_auction not null,
    attributes                     jsonb,
    auction_house_name             text                               NOT NULL,
    calibre                        text,
    case_number                    text,
    currency                       text,
    dimensions                     text,
    estimate                       text,
    internal_auction_name          text                               NOT NULL,
    lot_number                     text                               NOT NULL,
    lot_number_addition            text,
    lot_number_concat              text GENERATED ALWAYS AS ( CASE
                                                                  WHEN lot_number_addition ISNULL THEN lot_number
                                                                  ELSE lot_number || lot_number_addition END) STORED,
    material                       text,
    model_name                     text,
    movement_number                text,
    maker                          text,
    production_date                text,
    sale_price                     integer,
    url                            text,
    reference                      text,
    sale_price_in_usd              integer,
    estimate_to_in_usd             integer,
    estimate_from_in_usd           integer,
    estimate_from                  integer,
    estimate_to                    integer,
    estimate_currency              currencycode,
    attribute_searchable_index_col tsvector,
    was_sold                       boolean,
    UNIQUE (fk_web_auction, lot_number_concat)
);


CREATE TABLE IF NOT EXISTS import.web_auction_lot_image
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fk_web_auction_lot UUID REFERENCES import.web_auction_lot NOT NULL,
    image_url          text,
    filepath           text,
    filename           text,
    filename_hashed    text,
    extension          text,
    UNIQUE (image_url)
);



INSERT INTO import.web_auction (id, auction_date, auction_house_name, auction_location, auction_location_detail,
                                auction_title, comment, internal_auction_name, lot_count,
                                sale_total, url, base_currency)
SELECT cast(id as uuid),
       auction_date,
       auction_house_name,
       auction_location,
       auction_location_detail,
       auction_title,
       comment,
       internal_auction_name,
       cast(lot_count as integer),
       cast(sale_total as integer),
       url,
       base_currency
FROM import.l_auction
WHERE cast(id as uuid) NOT IN (SELECT id from import.web_auction);

INSERT INTO import.web_auction_lot (id, fk_web_auction, "attributes", auction_house_name, calibre, case_number,
                                    currency, dimensions, estimate, internal_auction_name, lot_number,
                                    lot_number_addition, material, model_name, movement_number, maker,
                                    production_date, sale_price, url, reference)
SELECT cast(id as uuid),
       cast(fk_parsed_auction_page as uuid),
       cast("attributes" as jsonb),
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
       reference
FROM import.l_auction_lot
WHERE cast(fk_parsed_auction_page as uuid) IN (SELECT id FROM import.web_auction)
ON CONFLICT do nothing;

INSERT INTO import.web_auction_lot_image (id, fk_web_auction_lot, image_url, filepath, filename,
                                          filename_hashed,
                                          extension)
SELECT cast(id as uuid),
       cast(fk_parsed_lot_page as uuid),
       url,
       filepath,
       filename,
       filename_hashed,
       extension
FROM import.l_auction_lot_image
WHERE cast(fk_parsed_lot_page as uuid) IN (SELECT id FROM import.web_auction_lot)
ON CONFLICT do nothing;
