CREATE EXTENSION IF NOT EXISTS hstore;
CREATE TABLE web_auction
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

CREATE TABLE web_auction_lot
(
    id                             UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fk_web_auction                 uuid references web_auction not null,
    attributes                     jsonb,
    auction_house_name             text                        NOT NULL,
    calibre                        text,
    case_number                    text,
    currency                       text,
    dimensions                     text,
    estimate                       text,
    internal_auction_name          text                        NOT NULL,
    lot_number                     text                        NOT NULL,
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

CREATE OR REPLACE FUNCTION calc_lot_number_concat() RETURNS TRIGGER AS
$body$
BEGIN
    NEW.lot_number_concat := CASE
                                 WHEN NEW.lot_number_addition ISNULL THEN NEW.lot_number
                                 ELSE NEW.lot_number || NEW.lot_number_addition END;
    RETURN NEW;
END;
$body$ LANGUAGE plpgsql;

CREATE TRIGGER lotupdate
    BEFORE INSERT OR UPDATE
    ON web_auction_lot
    FOR EACH ROW
EXECUTE FUNCTION calc_lot_number_concat();

CREATE TABLE web_auction_lot_image
(
    id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fk_web_auction_lot UUID REFERENCES web_auction_lot NOT NULL,
    image_url          text,
    filepath           text,
    filename           text,
    filename_hashed    text,
    extension          text,
    UNIQUE (image_url)
);

CREATE INDEX web_auction_lot_image_idx ON web_auction_lot_image (id, fk_web_auction_lot);
CREATE INDEX web_auction_lot_idx ON web_auction_lot (id, fk_web_auction, lot_number);
CREATE INDEX lal_lot_number_col2int_idx ON web_auction_lot
    (cast(NULLIF(regexp_replace(lot_number, '\D', '', 'g'), '') AS integer));

CREATE INDEX attribute_search_idx ON web_auction_lot USING GIN (attribute_searchable_index_col);

CREATE FUNCTION lot_search_update_trigger() RETURNS trigger AS
$$
begin
    new.attribute_searchable_index_col :=
                                                            setweight(to_tsvector('pg_catalog.english',
                                                                                  coalesce(new.auction_house_name, '')),
                                                                      'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.calibre, '')),
                                                                    'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.case_number, '')),
                                                                    'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.dimensions, '')),
                                                                    'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.lot_number, '')),
                                                                    'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.material, '')),
                                                                    'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.model_name, '')),
                                                                    'A') ||
                                                            setweight(to_tsvector('pg_catalog.english',
                                                                                  coalesce(new.movement_number, '')),
                                                                      'A') ||
                                                            setweight(to_tsvector('pg_catalog.english',
                                                                                  coalesce(new.production_date, '')),
                                                                      'A') ||
                                                            setweight(
                                                                    to_tsvector('pg_catalog.english', coalesce(new.reference, '')),
                                                                    'A') ||
                                                            setweight(to_tsvector('pg_catalog.english',
                                                                                  coalesce(new.attributes ->> 'Lot Title', '')),
                                                                      'B') ||
                                                            setweight(to_tsvector('pg_catalog.english',
                                                                                  coalesce(new.attributes ->> 'Lot Details', '')),
                                                                      'C') ||
                                                            setweight(to_tsvector('pg_catalog.english',
                                                                                  coalesce(new.attributes ->> 'Essay', '')),
                                                                      'D');
    return new;
end
$$ LANGUAGE plpgsql;

CREATE TRIGGER tsvectorupdate
    BEFORE INSERT OR UPDATE
    ON web_auction_lot
    FOR EACH ROW
EXECUTE FUNCTION lot_search_update_trigger();
