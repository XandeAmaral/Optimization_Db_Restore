-- select count(AddressID) from Person.Address

update Person.Address set AddressLine1="Meu valor" where AddressID = 1;

select AddressID, AddressLine1 from Person.Address where AddressID = 1


-- USE AdventureWorks2022;
-- GO
-- BACKUP DATABASE AdventureWorks2022
-- TO DISK = 'E:\AdventureWorks2022_Large.bak'
-- GO