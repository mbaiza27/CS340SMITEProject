INSERT INTO Items (item_name, item_effect)
Values
--This is where we will insert items from the game

INSERT INTO Roles (role_name, role_description)
Values
--The name of the role and what the roles purpose is
('ADC (ATTACK DAMAGE CARRY)', 'For this role you start in the DUO lane also known as the LONG lane. The goal when playing this role is to deal as much damage as possible. Typically the damage comes from auto attacks not abilities, but this does not always have to be the case.'),
('MID LANER', 'For this role you start in the MIDDLE lane. The goal when playing this role is also to do damage. Typically the damage from this role will come from abilities'),
('JUNGLER', 'For this role you will roam the JUNGLE. The goal when playing this role is to control the jungle to get experience and help your teamates in other lanes. This role has the potential to deal a lot of damage as well.'),
('SUPPORT', 'For this role you will start in the DUO lane also known as the LONG lane. The goal when playing this role is to protect your ADC until he is high enough level. Then you may roam the map and help other teamates. This is mostly a high defense/utility playstyle with low damage output.'),
('SOLO LANER', 'For this role you will start in the SOLO lane also known as the SHORT lane. The goal when playing this role is to stay in lane and beat the enemy solo laner. Once you are high enough level you may roam more to help your team. This class typically has very high defense, but more damage output than the SUPPORT class. Depending on the match up you could defeat any of the other classes by yourself.');

INSERT INTO Classes (class_name, class_description)
Values
--The name of the class and its purpose
('HUNTER', 'Hunters are normally always played in the ADC role. They are PHYSICAL damage gods and typically deal most of their damage with ranged auto attacks rather than abilities.'),
('MAGE', 'Mages are normally always played in the MID LANER role. They are MAGICAL damage gods and typically deal most of their damage with abilities.'),
('ASSASSIN', 'Assassins are normally always played in the JUNGLER role. They are PHYSICAl damage gods and can be built to deal damage with both their abilities and melee-range auto attacks.'),
('GUARDIAN', 'Guardians are normally always played in the SUPPORT role. They are MAGICAL damage gods and typically focus on defense and utility.'),
('WARRIOR', 'Warriors are normally played in the SOLO LANER role. They are PHYSICAL damage gods and are the most flexible of the classes. Typically they hold a healthy mix of defense and damage depending on how the gods are built.');

INSERT INTO Types (type_name)
Values
--Character types physical, magical, etc.
('PHYSICAL'),
('MAGICAL');

INSERT INTO ItemTypes (itemID, typeID)
Values
--Will store the items and their types. An item can have multiple types associated with it.

INSERT INTO Gods (god_name, primaryRoleID, primaryClassID, primaryTypeID)
Values
--Will store the gods its role, class, and type into the "Gods" table
('ACHILLES', (SELECT roleID FROM Roles WHERE role_name = 'SOLO LANER'), (SELECT classID FROM Classes WHERE class_name = 'WARRIOR'), (SELECT typeID FROM Types WHERE type_name = 'PHYSICAL')),
('AGNI', (SELECT roleID FROM Roles WHERE role_name = 'MID LANER'), (SELECT classID FROM Classes WHERE class_name = 'MAGE'), (SELECT typeID FROM Types WHERE type_name = 'MAGICAL')),
('AH MUZEN CAB', (SELECT roleID FROM Roles WHERE role_name = 'ADC (ATTACK DAMAGE CARRY)'), (SELECT classID FROM Classes WHERE class_name = 'HUNTER'), (SELECT typeID FROM Types WHERE type_name = 'PHYSICAL')),
('ARES', (SELECT roleID FROM Roles WHERE role_name = 'SUPPORT'), (SELECT classID FROM Classes WHERE class_name = 'GUARDIAN'), (SELECT typeID FROM Types WHERE type_name = 'MAGICAL')),
('ARACHNE', (SELECT roleID FROM Roles WHERE role_name = 'JUNGLER'), (SELECT classID FROM Classes WHERE class_name = 'ASSASSIN'), (SELECT typeID FROM Types WHERE type_name = 'PHYSICAL'));


--Will save for later
INSERT INTO Builds