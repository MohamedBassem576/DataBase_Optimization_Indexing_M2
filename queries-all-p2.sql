--Query 1

select i.*, t."Name" as TrackName, ar."Name" as ArtistName
from "InvoiceLine" i, "Track" t, "Album" al, "Artist" ar
where i."TrackId" = t."TrackId"
and t."AlbumId" = al."AlbumId"
and al."ArtistId" = ar."ArtistId";

--Query 2

select count(t."TrackId") as sales
from "InvoiceLine" il join "Invoice" i using ("InvoiceId") join "Track" t on t."TrackId" = il."TrackId"
where Extract('Year' from i."InvoiceDate") = 2013;

--Query 3

select ar."Name", count(i."TrackId") as sales
from "Artist" ar, "Album" a, "Track" t, "InvoiceLine" i
where ar."ArtistId" = a."ArtistId"
and a."AlbumId" =t."AlbumId"
and t."TrackId" = i."TrackId"
group by ar."Name"
order by sales desc limit 3;

--Query 4

select ar."Name", t."Name", a."Title"
from "Artist" ar, "Album" a, "Track" t, "InvoiceLine" i
where ar."ArtistId" = a."ArtistId"
and a."AlbumId" =t."AlbumId"
and t."TrackId" = i."TrackId"
and a."Title" = 'The Battle Rages On';

--Query 5

select t."Name" as track, al."Title" as album, m."Name" as mediatype, g."Name" as genre
from "Track" t, "Album" al, "MediaType" m, "Genre" g
where t."AlbumId" =al."AlbumId"
and t."GenreId" =g."GenreId"
and t."MediaTypeId"=m."MediaTypeId"
and g."Name" = 'Jazz';

--Query 6

select t."Name" , t."TrackId", a."Title", a."ArtistId"
from "Album" a left join "Track" t using ("AlbumId") join "Artist" ar using ("ArtistId") 
where ar."Name" = 'Pink Floyd';

--Query 7

select "Name" 
from "Track"
where "AlbumId" = (select "AlbumId"
from "Album"
where "Title" = 'Californication');

--Query 8

select ar."Name", ar."ArtistId"
from "Artist" ar
where ar."ArtistId" not in (select "ArtistId"
from "Album");

--Query 9

 select p."Name" as PlaylistName, count(pt."PlaylistId") as TrackCount from "PlaylistTrack" pt
left join "Playlist" p on p."PlaylistId" = pt."PlaylistId"
group by p."Name";

--Query 10

select t."Name", count(t."Name") as PurchaseCount
from "Track" t 
join "InvoiceLine" l on l."TrackId" = t."TrackId"
group by t."Name"
order by PurchaseCount DESC;

--Query 11

select t."Name", count(t."Name") as PurchaseCount
from "Track" t 
join "InvoiceLine" l on l."TrackId" = t."TrackId" join "Invoice" i on i."InvoiceId" = l."InvoiceId"
where i."BillingCity" like 'B%'
group by t."Name";

--Query 12

select i.*, t."Name" as PurchasedTrackName from "InvoiceLine" i
join "Track" t on i."TrackId" = t."TrackId"
join "Album" al on al."AlbumId" = t."AlbumId"
join "Artist" a on a."ArtistId" = al."ArtistId"
where a."Name" = 'Accept';