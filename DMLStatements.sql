-- *** User input attributes are denoted with :: symbols ***


-- SELECT Statements

-- Gods Page, populates table with information about a god
SELECT ch.characterName, ro.roleName, cl.className, ty.typeName FROM Characters ch 
JOIN Roles ro ON ch.primaryRoleID = ro.roleID 
JOIN Classes cl ON ch.primaryClassID = cl.classID 
JOIN Types ty ON ch.primaryTypeID = ty.typeID;

-- After a god is selected (there's a link to Build in the UI), we get builds for the corresponding god 
SELECT it.itemName FROM Builds bu 
JOIN Characters ch ON bu.characterID = ch.characterID 
JOIN Items it ON bu.itemID = it.itemID 
WHERE ch.characterName = ::userCharNamePick;

-- Items Page, populates table with information about individual Items
SELECT itemName, effect from Items;

-- Items Page, details about types populated when user requests 
SELECT ty.typeName FROM Items it 
JOIN ItemTypes itt ON it.itemID  = itt.itemID 
JOIN Types ty ON itt.typeID = ty.typeID 
WHERE it.itemID = (SELECT itemID from Items WHERE itemName = ::userItemPick);


-- INSERT Statements

-- Adding a new Class 
INSERT INTO Classes (className, description) VALUES (::userClassName, ::userClassDescription);

-- Adding a new Type 
INSERT INTO Types (typeName) VALUES (::userTypeName);

-- Adding a new Role 
INSERT INTO Roles (roleName, description) VALUES (::userRoleName, ::userRoleDescription);

-- Adding a new Item 
INSERT INTO Items (itemName, effect) VALUES (::userItemName, ::userItemEffect);

-- Adding a new God (Character) 
INSERT INTO Characters (characterName, primaryRoleID, primaryClassID, primaryTypeID) 
VALUES 
(::userCharName,
(SELECT roleID from Roles where roleName = ::userRoleChoice),
(SELECT classID from Classes where className = ::userClassChoice),
(SELECT typeID from Types where typeName = ::userTypeChoice));

-- Adding a new Item-Type relation 
INSERT INTO ItemTypes (itemID, typeID) 
VALUES
((SELECT itemID from Items WHERE itemName = ::userItemChoice),
(SELECT typeID from Types WHERE typeName = ::userTypeChoice));


-- UPDATE Statement, this will by run by an admin

-- Updating the type that's linked to an item
UPDATE ItemTypes 
SET typeID = (SELECT typeID FROM Types WHERE typeName = ::adminNewTypeChoice) 
WHERE itemID = (SELECT itemID from Items WHERE itemName = ::adminItemIDPick) 
AND typeID = (SELECT typeID from Types WHERE typeName = ::adminTypePick);


-- DELETE Statement, this will be run by an admin

-- Deleting a type that's linked to an item
DELETE FROM ItemTypes 
WHERE itemID = (SELECT itemID from Items WHERE itemName = ::adminItemIDPick) 
AND typeID = (SELECT typeID from Types WHERE typeName = ::adminTypePick);