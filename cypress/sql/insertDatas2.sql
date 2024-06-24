SET QUOTED_IDENTIFIER ON

BEGIN TRANSACTION;

DECLARE @Max INT = 1000;
DECLARE @i INT = 1;
WHILE @i <= @Max
BEGIN
	INSERT INTO Production.Culture
	(CultureID, Name)
	VALUES
	(@i, CONCAT('Culture', @i));
	SET @i = @i + 1;
END;
COMMIT;

BEGIN TRANSACTION;
SET @i = 1;
WHILE @i <= @Max
BEGIN
	INSERT INTO Production.Location
	(Name)
	VALUES
	(CONCAT('Location', @i));
	SET @i = @i + 1;
END;
COMMIT;


BEGIN TRANSACTION;
SET @i = 1;
WHILE @i <= @Max
BEGIN
	INSERT INTO Person.PhoneNumberType
	(Name)
	VALUES
	(CONCAT('NumberType', @i));
  SET @i = @i + 1;
END;
COMMIT;
