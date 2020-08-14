
-- *** User input attributes are denoted with :: symbols ***


-- SELECT Statements

-- Gods and adminGods Pages, populates table with information about a god
SELECT ch.characterID, ro.roleName, cl.className, ty.typeName FROM Characters ch 
JOIN Roles ro ON ch.primaryRoleID = ro.roleID 
JOIN Classes cl ON ch.primaryClassID = cl.classID 
JOIN Types ty ON ch.primaryTypeID = ty.typeID;

-- After a god is selected (there's a link to Build in the UI), we get builds for the corresponding god 
SELECT it.itemName FROM Builds bu 
JOIN Characters ch ON bu.characterID = ch.characterID 
JOIN Items it ON bu.itemID = it.itemID 
WHERE ch.characterName = ::userCharNamePick;


-- Items and adminItems Pages, populates table with information about individual Items
SELECT itemID, itemName, effect FROM Items;

-- Items Page, details about types populated when user requests 
SELECT ty.typeName from ItemTypes it
JOIN Types ty on it.typeID = ty.typeID 
WHERE it.itemID = ::userItemChoice;

-- adminGods also needs selects to the connected tables for populating UI options
SELECT roleID, roleName FROM Roles;
SELECT classID, className FROM Classes;
SELECT typeID, typeName FROM Types;
SELECT typeID, typeName FROM Types ORDER BY typeID ASC;
-- adminClasses
SELECT classID, className, description FROM Classes

-- adminItemTypes
SELECT itemTypeID, itemID, typeID FROM ItemTypes

SELECT itt.itemTypeID, it.itemName, ty.typeName FROM ItemTypes itt 
JOIN Items it ON itt.itemID = it.itemID 
JOIN Types ty ON itt.typeID = ty.typeID 
ORDER BY itt.itemTypeID ASC

SELECT itt.itemTypeID, it.itemName, ty.typeName FROM ItemTypes itt 
JOIN Items it ON itt.itemID = it.itemID \
JOIN Types ty ON itt.typeID = ty.typeID \
WHERE itt.itemTypeID = ::userItemChoice

-- Needed by adminItemTypes for UI options
SELECT itemID, itemName FROM Items;
SELECT typeID, typeName FROM Types;

-- adminRoles
SELECT roleID, roleName, description FROM Roles;

-- adminBuilds, to populate UI items
SELECT characterID, characterName FROM Characters;
SELECT itemID, itemName From Items;

SELECT it.itemName, it.effect FROM Builds bu 
JOIN Characters ch ON bu.characterID = ch.characterID 
JOIN Items it ON bu.itemID = it.itemID 
WHERE ch.characterID = ::userGodChoice




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
(::userCharName, ::userRoleChoice, ::userClassChoice, ::userTypeChoice);


-- Adding a new Item-Type relation 
INSERT INTO ItemTypes (itemID, typeID) 
VALUES (:userItemChoice, ::userTypeChoice);

-- Adding a new item to a build
INSERT INTO Builds (characterID, itemID) VALUES (::userGod, ::userItem)



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

