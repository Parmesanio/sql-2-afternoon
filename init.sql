

--Nested Queries

-- 1
select * from invoice
where InvoiceId IN (select InvoiceId from InvoiceLine where UnitPrice > .99);

-- 2
select * from playlisttrack
where playlistid in (select playlistid from playlist where name = 'Music');

-- 3
select name from track
where TrackId in (select TrackId from PlaylistTrack where PlaylistId = 5); 

-- 4
select name from track
where GenreId in (select GenreId from Genre where Name = 'Comedy');

-- 5
select name from track
where AlbumId in (select AlbumId from Album where title = 'Fireball');

-- 6
select name from track
where AlbumId in (select ArtistId from Album where ArtistId in (select ArtistId from Artist where name = 'Queen'));


-- Updating Rows

-- 1
update customer
set fax = null;

-- 2
update Customer
set Company = 'Self'
where Company is null;

-- 3
update customer
set lastname = 'Thompson'
where firstname = 'Julia' and lastname = 'Barnett';

-- 4
update customer
set supportrepid = 4
where email = 'luisrojas@yahoo.cl';

-- 5
update track
set composer = 'The darkness around us'
where GenreId in (select GenreId from Genre where name = 'Metal') and composer is null;

-- Group By

-- 1 Looked at solution.. what is happening
SELECT Count(*), g.Name
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.Name;


-- 2
SELECT Count(*), g.Name
FROM Track t
JOIN Genre g ON t.GenreId = g.GenreId
where g.Name = "Pop" or g.Name = "Rock"
GROUP BY g.Name;

-- 3


-- Use Distinct

-- 1
select distinct(composer) from track;

-- 2
select distinct(BillingPostalCode) from invoice;

-- 3
select distinct(company) from customer;

-- Delete Rows

-- 2
delete from practice_delete where type='bronze';

-- 3
delete from practice_delete where type='bronze';

-- 4
delete from practice_delete where value=150;


-- eCommerce Simulation

create table users(
    UserId serial primary key,
    name text,
    email text
);
insert into users
(name, email)values
('Sean', 'sean@yahoo.cl'),
('Austin', 'Austin@yahoo.cl'),
('Hunter', 'Hunter@yahoo.cl')

create table products(
    product_id serial primary key,
    name text,
    price decimal
);
insert into products
(name, price) VALUES
('Chocolate', 5.60),
('latte', 3.60),
('Choco', 55.60)

create table orders(
    order_id serial PRIMARY KEY,
    product int references products(product_id),
    order_user int references users(UserId) 
);
insert into orders
(product) VALUES
(1), (2), (3);

select * from users;
select * from products;
select * from orders;


-- Products from first order
select * from products
where product_id in (select product from orders where order_id = 1);

-- All Orders
select * from orders;

-- Sum cost of order
select sum(price) from products
where product_id in (select product from orders where order_id = 1);


