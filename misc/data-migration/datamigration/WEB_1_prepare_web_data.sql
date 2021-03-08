----- TEMPORARILY REMOVE TRIGGER TO IMPROVE PERFORMANCE
DROP TRIGGER IF EXISTS tsvectorupdate ON web_auction_lot;

------------ AUCTIONS ------------
-- date from and to
-- SOTHEBY'S
update import.web_auction
set date_from = cast(auction_date as date),
    date_to   = cast(auction_date as date)
where auction_house_name = 'Sotheby''s';

-- ANTIQUORUM
update import.web_auction
set auction_date            = concat(auction_location_detail, ' ', auction_date),
    auction_location_detail = null
where auction_house_name = 'Antiquorum'
  and auction_date similar to '\d\d\d\d';

update import.web_auction
set auction_date = replace(auction_date, 'th', '')
where auction_house_name = 'Antiquorum'
  and auction_date similar to '%\dth%';

update import.web_auction
set auction_date = replace(auction_date, 'rd', '')
where auction_house_name = 'Antiquorum'
  and auction_date similar to '%\drd%';

update import.web_auction
set auction_date = replace(auction_date, 'nd', '')
where auction_house_name = 'Antiquorum'
  and auction_date similar to '%\dnd%';

update import.web_auction
set auction_date = replace(auction_date, 'st', '')
where auction_house_name = 'Antiquorum'
  and auction_date similar to '%\dst%';

update import.web_auction
set date_from = cast(auction_date as date),
    date_to   = cast(auction_date as date)
where auction_house_name = 'Antiquorum'
  and not (auction_date similar to '%&%'
    or auction_date similar to '%-%');

-- BONHAMS
-- select auction_date
-- from import.web_auction
-- where auction_date not ilike '% - %';


update import.web_auction
set date_from = cast(auction_date as date),
    date_to   = cast(auction_date as date)
where auction_house_name = 'Bonhams'
  and auction_date not ilike '% - %'
;

-- CHRISTIES
update import.web_auction
set date_from = cast(auction_date as date),
    date_to   = cast(auction_date as date)
where auction_house_name = 'Christie''s'
  and not (auction_date similar to '%-%'
    or auction_date similar to '\d\d November');


-- PHILLIPS
update import.web_auction
set date_from = cast((select(regexp_matches(auction_date, '^.*\d\d\d\d'))[1]) as date),
    date_to   = cast((select(regexp_matches(auction_date, '^.*\d\d\d\d'))[1]) as date)
where auction_house_name = 'Phillips'
  and not (auction_date similar to '%-%' or auction_date similar to '%&%' or auction_date similar to '%–%');

-- url
update import.web_auction
set url = replace(url, '/index.html', '')
where url similar to '%index.html';


-- Antiquorum
update import.web_auction la
set auction_title = attributes ->> 'Auction Title'
from web_auction_lot lal
where auction_title isnull
  and la.id = lal.fk_web_auction
  and lal.attributes ->> 'Auction Title' notnull;

------------ AUCTION LOTS ------------

-------- ALL MAKERS ARE EITHER IN ATTRIBUTES 'MAKER'/'BRAND'/'MANUFACTURER' --------

-------- MAKER ANTIQUORUM --------
update import.web_auction_lot
set maker =
        (select 'Patek Philippe'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Pate..?.Philipp?e?)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Rolex'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Rolex)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Omega'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Omega)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Vacheron Constantin'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Vacheron.?.?.?Constan?tin)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'A. Lange & Söhne'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?([a.?]?.?lange.?.?.?s..?h?ne)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;
--
update import.web_auction_lot
set maker =
        (select 'Cartier'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(cartier)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Audemars Piguet'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(audemars?.?pi.?uet)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Jaeger LeCoultre'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(j..ger.lecoultre?)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Piaget'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(piaget)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Panerai'
         from regexp_matches(attributes ->> 'Brand', '^panerai', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Franck Muller'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(franc?k.m[u|ü]e?ller)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'IWC'
         from regexp_matches(attributes ->> 'Brand', '^iwc', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Swiss'
         from regexp_matches(attributes ->> 'Brand', '^swiss[\.,]', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Chopard'
         from regexp_matches(attributes ->> 'Brand', '^Cho.ar?d', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Heuer'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Heuer)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Ulysse Nardin'
         from regexp_matches(attributes ->> 'Brand', '^Ulyss?e.?.?Nar?din', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Hublot'
         from regexp_matches(attributes ->> 'Brand', '^Hublot', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Breitling'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Breitling?)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Longines'
         from regexp_matches(attributes ->> 'Brand', '^Longines?', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Corum'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Corum)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Zenith'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Zenith)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Roger Dubuis'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(Roger Dubuis)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'F.P. Journe'
         from regexp_matches(attributes ->> 'Brand', '^f.?p.?.?jou?rne?', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Glashütte Original'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(glash.tte.original)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Gübelin'
         from regexp_matches(attributes ->> 'Brand', '^e?.?g.belin', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

update import.web_auction_lot
set maker =
        (select 'Urban Jürgensen'
         from regexp_matches(attributes ->> 'Brand', '^("\w+" )?(urban.j.rgensen)', 'i'))
where maker isnull
  and attributes ->> 'Brand' notnull;

-------- MAKER PHILLIPS --------
update import.web_auction_lot
set maker =
        (select 'Patek Philippe'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Pate..?.Philipp?e?)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Rolex'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Rolex)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Omega'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Omega)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Vacheron Constantin'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Vacheron.?.?.?Constan?tin)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'A. Lange & Söhne'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?([a.?]?.?lange.?.?.?s..?h?ne)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;
--
update import.web_auction_lot
set maker =
        (select 'Cartier'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(cartier)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Audemars Piguet'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(audemars?.?pi.?uet)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Jaeger LeCoultre'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(j..ger.lecoultre?)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Piaget'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(piaget)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Panerai'
         from regexp_matches(attributes ->> 'Manufacturer', '^panerai', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Franck Muller'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(franc?k.m[u|ü]e?ller)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'IWC'
         from regexp_matches(attributes ->> 'Manufacturer', '^iwc', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Swiss'
         from regexp_matches(attributes ->> 'Manufacturer', '^swiss[\.,]', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Chopard'
         from regexp_matches(attributes ->> 'Manufacturer', '^Cho.ar?d', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Heuer'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Heuer)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Ulysse Nardin'
         from regexp_matches(attributes ->> 'Manufacturer', '^Ulyss?e.?.?Nar?din', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Hublot'
         from regexp_matches(attributes ->> 'Manufacturer', '^Hublot', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Breitling'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Breitling?)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Longines'
         from regexp_matches(attributes ->> 'Manufacturer', '^Longines?', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Corum'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Corum)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Zenith'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Zenith)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Roger Dubuis'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(Roger Dubuis)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'F.P. Journe'
         from regexp_matches(attributes ->> 'Manufacturer', '^f.?p.?.?jou?rne?', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Glashütte Original'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(glash.tte.original)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Gübelin'
         from regexp_matches(attributes ->> 'Manufacturer', '^e?.?g.belin', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

update import.web_auction_lot
set maker =
        (select 'Urban Jürgensen'
         from regexp_matches(attributes ->> 'Manufacturer', '^("\w+" )?(urban.j.rgensen)', 'i'))
where maker isnull
  and attributes ->> 'Manufacturer' notnull;

-------- MAKER BONHAMS --------
update import.web_auction_lot
set maker =
        (select 'Patek Philippe'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Pate..?.Philipp?e?)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Rolex'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Rolex)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Omega'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Omega)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Vacheron Constantin'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Vacheron.?.?.?Constan?tin)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'A. Lange & Söhne'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?([a.?]?.?lange.?.?.?s..?h?ne)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;
--
update import.web_auction_lot
set maker =
        (select 'Cartier'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(cartier)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Audemars Piguet'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(audemars?.?pi.?uet)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Jaeger LeCoultre'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(j..ger.lecoultre?)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Piaget'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(piaget)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Panerai'
         from regexp_matches(attributes ->> 'Maker', '^panerai', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Franck Muller'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(franc?k.m[u|ü]e?ller)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'IWC'
         from regexp_matches(attributes ->> 'Maker', '^iwc', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Swiss'
         from regexp_matches(attributes ->> 'Maker', '^swiss[\.,]', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Chopard'
         from regexp_matches(attributes ->> 'Maker', '^Cho.ar?d', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Heuer'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Heuer)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Ulysse Nardin'
         from regexp_matches(attributes ->> 'Maker', '^Ulyss?e.?.?Nar?din', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Hublot'
         from regexp_matches(attributes ->> 'Maker', '^Hublot', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Breitling'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Breitling?)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Longines'
         from regexp_matches(attributes ->> 'Maker', '^Longines?', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Corum'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Corum)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Zenith'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Zenith)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Roger Dubuis'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(Roger Dubuis)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'F.P. Journe'
         from regexp_matches(attributes ->> 'Maker', '^f.?p.?.?jou?rne?', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Glashütte Original'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(glash.tte.original)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Gübelin'
         from regexp_matches(attributes ->> 'Maker', '^e?.?g.belin', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

update import.web_auction_lot
set maker =
        (select 'Urban Jürgensen'
         from regexp_matches(attributes ->> 'Maker', '^("\w+" )?(urban.j.rgensen)', 'i'))
where maker isnull
  and attributes ->> 'Maker' notnull;

-------- MAKER ANTIQUORUM --------
update import.web_auction_lot
set maker = 'Patek Philippe'
where auction_house_name = 'Antiquorum'
  and url ilike '%/patek-%'
  and maker isnull;

update import.web_auction_lot
set maker = 'Rolex'
where auction_house_name = 'Antiquorum'
  and url ilike '%/rolex-%'
  and maker isnull;

update import.web_auction_lot
set maker = 'Omega'
where auction_house_name = 'Antiquorum'
  and url ilike '%/omega-%'
  and maker isnull;

update import.web_auction_lot
set maker = 'Vacheron Constantin'
where auction_house_name = 'Antiquorum'
  and url ilike '%/vacheron-constantin-%'
  and maker isnull;

-------- MAKER FROM ATTRIBUTES --------
update import.web_auction_lot
set maker =
        (select 'Patek Philippe'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Pate..?.Philipp?e?)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Rolex'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Rolex)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Omega'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Omega)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Vacheron Constantin'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Vacheron.?.?.?Constan?tin)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'A. Lange & Söhne'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?([a.?]?.?lange.?.?.?s..?h?ne)', 'i'))
where maker isnull;
--
update import.web_auction_lot
set maker =
        (select 'Cartier'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(cartier)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Audemars Piguet'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(audemars?.?pi.?uet)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Jaeger LeCoultre'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(j..ger.lecoultre?)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Piaget'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(piaget)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Panerai'
         from regexp_matches(attributes ->> 'Lot Title', '^panerai', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Franck Muller'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(franc?k.m[u|ü]e?ller)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'IWC'
         from regexp_matches(attributes ->> 'Lot Title', '^iwc', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Swiss'
         from regexp_matches(attributes ->> 'Lot Title', '^swiss[\.,]', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Chopard'
         from regexp_matches(attributes ->> 'Lot Title', '^Cho.ar?d', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Heuer'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Heuer)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Ulysse Nardin'
         from regexp_matches(attributes ->> 'Lot Title', '^Ulyss?e.?.?Nar?din', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Hublot'
         from regexp_matches(attributes ->> 'Lot Title', '^Hublot', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Breitling'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Breitling?)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Longines'
         from regexp_matches(attributes ->> 'Lot Title', '^Longines?', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Corum'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Corum)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Zenith'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Zenith)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Roger Dubuis'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(Roger Dubuis)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'F.P. Journe'
         from regexp_matches(attributes ->> 'Lot Title', '^f.?p.?.?jou?rne?', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Glashütte Original'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(glash.tte.original)', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Gübelin'
         from regexp_matches(attributes ->> 'Lot Title', '^e?.?g.belin', 'i'))
where maker isnull;

update import.web_auction_lot
set maker =
        (select 'Urban Jürgensen'
         from regexp_matches(attributes ->> 'Lot Title', '^("\w+" )?(urban.j.rgensen)', 'i'))
where maker isnull;

-- Movement and Casenumber
update import.web_auction_lot
set movement_number = replace(attributes ->> 'Movement No', ' ', '')
where attributes ->> 'Movement No' notnull
  and movement_number isnull;

update import.web_auction_lot
set case_number = replace(attributes ->> 'Case No', ' ', '')
where attributes ->> 'Case No' notnull
  and case_number isnull;


update import.web_auction_lot
set movement_number = (
    select replace(string_agg(t.arr[3], ''), '''', '')
    FROM regexp_matches(attributes ->> 'Lot Title', '(Movement\:?|mvt)( ?no.? ?| ?)?([\d''’]{5,9})', 'i') t(arr)
)
where movement_number isnull;

update import.web_auction_lot
set case_number = (
    select regexp_replace(string_agg(t.arr[3], ''), '[''’]', '')
    FROM regexp_matches(attributes ->> 'Lot Title', '(case)( ?no.? ?| ?)?([\d''’]{5,9})', 'i') t(arr)
)
where case_number isnull;

update import.web_auction_lot
set case_number = (
    select regexp_replace(string_agg(t.arr[3], ''), '[''’]', '')
    FROM regexp_matches(attributes ->> 'Lot Details', '(case)( ?no.? ?| ?)?([\d''’]{5,9})', 'i') t(arr)
)
where case_number isnull;

update import.web_auction_lot
set movement_number = (
    select regexp_replace(string_agg(t.arr[3], ''), '[''’]', '')
    FROM regexp_matches(attributes ->> 'Lot Details', '(Movement\:?|mvt)( ?no.? ?| ?)?([\d''’]{5,9})', 'i') t(arr)
)
where movement_number isnull;

update import.web_auction_lot
set movement_number = (
    select regexp_replace(string_agg(t.arr[2], ''), '[''’]', '')
    FROM regexp_matches(attributes ->> 'Lot Title', '(Patek\W? Philippe & Cie\.?,? Genève,? No. )([\d''’]{5,9})',
                        'i') t(arr)
)
where movement_number isnull;

-- REFERENCE
update import.web_auction_lot
set reference = attributes ->> 'Reference No'
where attributes ->> 'Reference No' notnull
  and reference isnull;


update import.web_auction_lot
set reference = (
    select string_agg(t.arr[2], '')
    FROM regexp_matches(attributes ->> 'Lot Title', '(Ref\.?\W)([\w\-\/]+)', 'i') t(arr)
)
where reference isnull;

update import.web_auction_lot
set reference = (
    select string_agg(t.arr[2], '')
    FROM regexp_matches(attributes ->> 'Lot Details', '(Ref\.?\W)([\w\-\/]+)', 'i') t(arr)
)
where reference isnull;

update import.web_auction_lot
set reference = (
    select string_agg(t.arr[2], '')
    FROM regexp_matches(attributes ->> 'Lot Title', '(Reference\:?\W)([\w\-\/]+)', 'i') t(arr)
)
where reference isnull;

update import.web_auction_lot
set reference = (
    select string_agg(t.arr[2], '')
    FROM regexp_matches(attributes ->> 'Lot Details', '(Reference\:?\W)([\w\-\/]+)', 'i') t(arr)
)
where reference isnull;

-- PRODUCTION DATE
update import.web_auction_lot
set production_date = (
    select string_agg(t.arr[1], '')
    FROM regexp_matches(attributes ->> 'Lot Title', 'made in (\d\d\d\d)', 'i') t(arr)
    where production_date isnull
)
where production_date isnull;

update import.web_auction_lot
set production_date = (
    select string_agg(t.arr[1], '')
    FROM regexp_matches(attributes ->> 'Lot Details', 'made in (\d\d\d\d)', 'i') t(arr)
    where production_date isnull
)
where production_date isnull;

update import.web_auction_lot
set movement_number = replace(movement_number, '''', '')
where movement_number similar to '%''%';

update import.web_auction_lot
set case_number = replace(case_number, '''', '')
where case_number similar to '%''%';

update import.web_auction_lot
set movement_number = replace(movement_number, '’', '')
where movement_number similar to '%’%';

update import.web_auction_lot
set case_number = replace(case_number, '’', '')
where case_number similar to '%’%';


-- estimate
update import.web_auction_lot
set estimate_currency = (
    select cast(replace(string_agg(t.arr[1], ''), 'HK$', 'HKD') as currencycode)
    FROM regexp_matches(attributes ->> 'Estimate',
                        '^([a-zA-Z]{2,3}?\$?|)( ?)([0-9.,'']+?)([.,]\d\d|)(\s?-\s?)([a-zA-Z]{2,3}?\$?|)( ?)([0-9.,'']+?)([.,]\d\d|)$') t(arr)
)
where estimate_currency isnull
  and attributes ->> 'Estimate' notnull;

update import.web_auction_lot
set estimate_from = (
    select cast(replace(string_agg(t.arr[3], ''), ',', '') as integer)
    FROM regexp_matches(attributes ->> 'Estimate',
                        '^([a-zA-Z]{2,3}?\$?|)( ?)([0-9.,'']+?)([.,]\d\d|)(\s?-\s?)([a-zA-Z]{2,3}?\$?|)( ?)([0-9.,'']+?)([.,]\d\d|)$') t(arr)
)
where estimate_from isnull
  and attributes ->> 'Estimate' notnull;

update import.web_auction_lot
set estimate_to = (
    select cast(replace(string_agg(t.arr[8], ''), ',', '') as integer)
    FROM regexp_matches(attributes ->> 'Estimate',
                        '^([a-zA-Z]{2,3}?\$?|)( ?)([0-9.,'']+?)([.,]\d\d|)(\s?-\s?)([a-zA-Z]{2,3}?\$?|)( ?)([0-9.,'']+?)([.,]\d\d|)$') t(arr)
)
where estimate_to isnull
  and attributes ->> 'Estimate' notnull;

update import.web_auction_lot
set movement_number = attributes ->> 'Movement No.'
where movement_number isnull
  and attributes ->> 'Movement No.' notnull;

update import.web_auction_lot
set case_number = attributes ->> 'Case No.'
where case_number isnull
  and attributes ->> 'Case No.' notnull;

update import.web_auction_lot
set material = attributes ->> 'Material'
where material isnull
  and attributes ->> 'Material' notnull;

update import.web_auction_lot
set calibre = attributes ->> 'Caliber'
where calibre isnull
  and attributes ->> 'Caliber' notnull;

update import.web_auction_lot
set material = 'Stainless Steel'
where material ilike 'stainless steel';

update import.web_auction_lot
set material = '18k Yellow Gold'
where material ilike '18k yellow gold';

update import.web_auction_lot
set material = '18k White Gold'
where material ilike '18k white gold';

update import.web_auction_lot
set material = '18k Pink Gold'
where material ilike '18k pink gold';

-- TODO finish
select regexp_matches(attributes ->> 'Lot Title', '(\d?\dk )(pink|yellow|white)( gold)', 'i'), material, *
from web_auction_lot
where material isnull;

update import.web_auction_lot
set sale_price = cast(attributes ->> 'Sale Price' as integer)
where sale_price isnull
  and attributes ->> 'Sale Price' notnull
  and auction_house_name != 'Bonhams';

update import.web_auction_lot
set currency = attributes ->> 'Sale Currency'
where sale_price isnull
  and attributes ->> 'Sale Currency' notnull
  and auction_house_name != 'Bonhams';

update import.web_auction_lot
set currency = (
    select cast(
                   replace(replace(replace(replace(string_agg(t.arr[3], ''), 'HK$', 'HKD'), 'US$', 'USD'), '£', 'GBP'),
                           '€', 'EUR')
               as currencycode)
    FROM regexp_matches(attributes ->> 'Sale Price', '^(Sold for)(\s)(\D{1,3})(\s)([\d.,]+)') t(arr)
)
where currency isnull
  and attributes ->> 'Sale Price' notnull
  and auction_house_name = 'Bonhams';

update import.web_auction_lot
set sale_price = (
    select cast(replace((string_agg(t.arr[5], '')), ',', '') as integer)
    FROM regexp_matches(attributes ->> 'Sale Price', '^(Sold for)(\s)(\D{1,3})(\s)([\d.,]+)') t(arr)
)
where sale_price isnull
  and attributes ->> 'Sale Price' notnull
  and auction_house_name = 'Bonhams';

-- CURRENCY
update import.web_auction_lot
set currency = attributes ->> 'Sale Currency'
where currency isnull
  and attributes ->> 'Sale Currency' notnull;


-- CORRECT PRICES OF ANTIQUORUM MILANO
update import.web_auction_lot
set sale_price        = sale_price / 1000,
    sale_price_in_usd = sale_price_in_usd / 1000
where auction_house_name = 'Antiquorum'
  and (
        internal_auction_name = '124'
        or internal_auction_name = '111'
        or internal_auction_name = '116'
    );


-- FINISH UP PRICES
update import.web_auction_lot
set sale_price_in_usd = sale_price
where sale_price_in_usd isnull
  and currency = 'USD';

update import.web_auction_lot
set was_sold = cast(attributes ->> 'Sold' as boolean)
where was_sold isnull;
