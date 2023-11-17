create database QLBH;
use QLBH;
create table Customer(
cID int primary key,
cName varchar(25),
cAge tinyint
);
insert into Customer(cID,cName,cAge) values
(1,'Minh Quan',10),
(2,'Ngoc Oanh',20),
(3,'Hong Ha',50);
create table Orders(
oID int primary key,
cID int,
oDate datetime,
oTotalPrice int,
foreign key (cID) references Customer (cID)
);
insert into Orders(oID,cID,oDate,oTotalPrice) values
(1,1,'2006-3-21',Null),
(2,2,'2006-3-23',Null),
(3,1,'2006-3-16',Null);

create table Product(
pID int primary key,
pName varchar(25),
pPrice int
);
insert into Product(pID,pName,pPrice) values
(1,'May Giat',3),
(2,'Tu Lanh',5),
(3,'Dieu Hoa',7),
(4,'Quat',1),
(5,'Bep Dien',1);
create table OrderDetail(
oID int,
pID int,
primary key (oID,pID),
odQTY int,
foreign key (oID) references Orders (oID),
foreign key (pID) references Product (pID)
);
insert into OrderDetail (oID,pID,odQTY) values
(1,1,3),
(1,3,7),
(1,4,2),
(2,1,1),
(3,1,8),
(2,5,4),
(2,3,3);

select * from Orders order by oDate desc;

select pName,pPrice 
from Product 
where pPrice = (select max(pPrice) from Product);

select C.cName,P.pName 
from Customer C 
join Orders O
on C.cID = O.cID
join Orderdetail OD
on O.oID = OD.oID
join Product P
on OD.pID = P.pID
;

select C.cName
from Customer C 
left join Orders O
on O.cID = C.cID
where O.oID is null;


select O.oID,O.oDate,OD.odQTY,P.pName,P.pPrice
from Orders O
join Orderdetail OD
on O.oID = OD.oID
join Product P
on OD.pID = P.pID
;

select O.oID,O.oDate,sum(OD.odQTY*P.pPrice) AS Total
from Orders O
join Orderdetail OD
on O.oID = OD.oID
join Product P
on OD.pID = P.pID
group by OD.oID
;
