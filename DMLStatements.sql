-- SELECT Statements

-- Gods Page, populates table with information about a god
SELECT ch.characterName, ro.roleName, cl.className, ty.typeName FROM Characters ch JOIN Roles ro ON ch.primaryRoleID = ro.roleID JOIN Classes cl ON ch.primaryClassID = cl.classID JOIN Types ty ON ch.primaryTypeID = ty.typeID;

-- After a god is selected (there's a link to Build in the UI), we get builds for the corresponding god, user input attributes denoted with :: symbols
SELECT it.itemName FROM Builds bu JOIN Characters ch ON bu.characterID = ch.characterID JOIN Items it ON bu.itemID = it.itemID WHERE ch.characterName = ::userCharNamePick;

-- Items Page, populates table with information about individual Items
SELECT itemName, effect from Items;

-- Items Page, details about types populated when user requests, user input attributes denoted with :: symbols
SELECT ty.typeName FROM Items it JOIN ItemTypes itt ON it.itemID  = itt.itemID JOIN Types ty ON itt.typeID = ty.typeID WHERE it.itemID = (SELECT itemID from Items WHERE itemName = ::userItemPick);


-- INSERT Statements

-- Adding a new Class, user input attributes denoted with :: symbols
INSERT INTO Classes (className, description) VALUES (::userClassName, ::userClassDescription);

-- Adding a new Type, user input attributes denoted with :: symbols
INSERT INTO Types (typeName) VALUES (::userTypeName);

-- Adding a new Role, user input attributes denoted with :: symbols
INSERT INTO Roles (roleName, description) VALUES (::userRoleName, ::userRoleDescription);

-- Adding a new Item, user input attributes denoted with :: symbols
INSERT INTO Items (itemName, effect) VALUES (::userItemName, ::userItemEffect);

-- Adding a new God (Character), user input attributes denoted with :: symbols
INSERT INTO Characters (characterName, primaryRoleID, primaryClassID, primaryTypeID) VALUES 
(::userCharName,
(SELECT roleID from Roles where roleName = ::userRoleChoice),
(SELECT classID from Classes where className = ::userClassChoice),
(SELECT typeID from Types where typeName = ::userTypeChoice));

-- Adding a new Item-Type relation, user input attributes denoted with :: symbols
INSERT INTO ItemTypes (itemID, typeID) VALUES
((SELECT itemID from Items WHERE itemName = ::userItemChoice),
(SELECT typeID from Types WHERE typeName = ::userTypeChoice));


-- UPDATE Statement, since this is run by admin, they can select item IDs (directly) to update

-- Updating the type that's linked to an item
UPDATE ItemTypes SET typeID = (SELECT typeID FROM Types WHERE typeName = ::adminNewTypeChoice) WHERE 
itemID = (SELECT itemID from Items WHERE itemName = ::adminItemIDPick) AND 
typeID = (SELECT typeID from Types WHERE typeName = ::adminTypePick);

-- DELETE Statement, since this is run by admin, they can select item IDs (directly) to delete

-- Deleting a type that's linked to an item
DELETE FROM ItemTypes WHERE itemID = (SELECT itemID from Items WHERE itemName = ::adminItemIDPick) AND 
typeID = (SELECT typeID from Types WHERE typeName = ::adminTypePick);