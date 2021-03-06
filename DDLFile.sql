-- Structure Setup

CREATE TABLE Items (
    itemID int(11) AUTO_INCREMENT,
    itemName varchar(255) NOT NULL,
    effect text,
    PRIMARY KEY (itemID),
    UNIQUE (itemName)
) ENGINE=InnoDB;

CREATE TABLE Roles (
    roleID int(11) AUTO_INCREMENT,
    roleName varchar(255) NOT NULL,
    description text,
    PRIMARY KEY (roleID),
    UNIQUE (roleName)
) ENGINE=InnoDB;

CREATE TABLE Classes (
    classID int(11) AUTO_INCREMENT,
    className varchar(255) NOT NULL,
    description text,
    PRIMARY KEY (classID),
    UNIQUE (className)
) ENGINE=InnoDB;

CREATE TABLE Types (
    typeID int(11) AUTO_INCREMENT,
    typeName varchar(255) NOT NULL,
    PRIMARY KEY (typeID),
    UNIQUE (typeName)
) ENGINE=InnoDB;

CREATE TABLE ItemTypes (
    itemTypeID int(11) AUTO_INCREMENT,
    itemID int(11),
    typeID int(11),
    PRIMARY KEY (itemTypeID),  
    FOREIGN KEY (itemID) REFERENCES Items(itemID),
    FOREIGN KEY (typeID) REFERENCES Types(typeID)
) ENGINE=InnoDB;

CREATE TABLE Characters (
    characterID int(11) AUTO_INCREMENT,
    characterName varchar(255) NOT NULL,
    primaryRoleID int(11),
    primaryClassID int (11),
    primaryTypeID int(11),
    PRIMARY KEY (characterID),
    UNIQUE (characterName),
    FOREIGN KEY (primaryRoleID) REFERENCES Roles(roleID),
    FOREIGN KEY (primaryClassID) REFERENCES Classes(classID),
    FOREIGN KEY (primaryTypeID) REFERENCES Types(typeID)
) ENGINE=InnoDB;

CREATE TABLE Builds (
    buildID int(11) AUTO_INCREMENT,
    characterID int(11),
    itemID int(11),
    PRIMARY KEY (buildID),
    FOREIGN KEY (characterID) REFERENCES Characters(characterID),
    FOREIGN KEY (itemID) REFERENCES Items(itemID)
) ENGINE=InnoDB;

-- Sample Data

-- Inserting of SMITE's items into our table, will be used to recommend items
INSERT INTO Items (itemName, effect)
Values
('The Executioner', "Basic Attacks against an enemy reduce your target's Physical Protection by 7% for 3 second"),
("Titan's Bane", "Your first ability cast gains 20% Physical Penetration. This can only occur once every 10 seconds."),
('Mystical Mail', "ALL enemies within 25 units are dealt 40 Magical Damage per second."),
("Genji's Guard", "When you take Magical Damage from Abilities your cooldowns are reduced by 3s. This can only occur once every 30s."),
("Spear of the Magus", "When you deal damage to an enemy god mark them to take 7.5% increased damage from all sources. This effect lasts for 10s and can only occur once every 10s."),
("Brawler's Beat Stick",'Enemies hit by your Abilities have 40% reduced healing and regeneration for 8 seconds.'),
('The Sledge','For each enemy within 55 Units, you gain 10 Magical and Physical Protections, stacking up to 3 times.');

-- The name of the role and what the role's purpose is
INSERT INTO Roles (roleName, description)
Values
('ADC (ATTACK DAMAGE CARRY)', 'For this role you start in the DUO lane also known as the LONG lane. The goal when playing this role is to deal as much damage as possible. Typically the damage comes from auto attacks not abilities, but this does not always have to be the case.'),
('MID LANER', 'For this role you start in the MIDDLE lane. The goal when playing this role is also to do damage. Typically the damage from this role will come from abilities'),
('JUNGLER', 'For this role you will roam the JUNGLE. The goal when playing this role is to control the jungle to get experience and help your teamates in other lanes. This role has the potential to deal a lot of damage as well.'),
('SUPPORT', 'For this role you will start in the DUO lane also known as the LONG lane. The goal when playing this role is to protect your ADC until he is high enough level. Then you may roam the map and help other teamates. This is mostly a high defense/utility playstyle with low damage output.'),
('SOLO LANER', 'For this role you will start in the SOLO lane also known as the SHORT lane. The goal when playing this role is to stay in lane and beat the enemy solo laner. Once you are high enough level you may roam more to help your team. This class typically has very high defense, but more damage output than the SUPPORT class. Depending on the match up you could defeat any of the other classes by yourself.');

-- The name of the class and a description
INSERT INTO Classes (className, description)
Values
('HUNTER', 'Hunters are normally always played in the ADC role. They are PHYSICAL damage gods and typically deal most of their damage with ranged auto attacks rather than abilities.'),
('MAGE', 'Mages are normally always played in the MID LANER role. They are MAGICAL damage gods and typically deal most of their damage with abilities.'),
('ASSASSIN', 'Assassins are normally always played in the JUNGLER role. They are PHYSICAl damage gods and can be built to deal damage with both their abilities and melee-range auto attacks.'),
('GUARDIAN', 'Guardians are normally always played in the SUPPORT role. They are MAGICAL damage gods and typically focus on defense and utility.'),
('WARRIOR', 'Warriors are normally played in the SOLO LANER role. They are PHYSICAL damage gods and are the most flexible of the classes. Typically they hold a healthy mix of defense and damage depending on how the gods are built.');

-- Character & Item types such as physical, magical, etc.
INSERT INTO Types (typeName)
Values
('PHYSICAL'),
('MAGICAL'),
('DEFENSIVE'),
('UTILITY');

-- Will store the items and their types. An item can have multiple types associated with it.
INSERT INTO ItemTypes (itemID, typeID)
Values
((SELECT itemID from Items WHERE itemName = 'The Executioner'), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL')),
((SELECT itemID from Items WHERE itemName = "Titan's Bane"), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL')),
((SELECT itemID from Items WHERE itemName = 'Mystical Mail'), (SELECT typeID FROM Types WHERE typeName = 'DEFENSIVE')),
((SELECT itemID from Items WHERE itemName = 'Mystical Mail'), (SELECT typeID FROM Types WHERE typeName = 'UTILITY')),
((SELECT itemID from Items WHERE itemName = "Genji's Guard"), (SELECT typeID FROM Types WHERE typeName = 'DEFENSIVE')),
((SELECT itemID from Items WHERE itemName = "Genji's Guard"), (SELECT typeID FROM Types WHERE typeName = 'UTILITY')),
((SELECT itemID from Items WHERE itemName = 'Spear of the Magus'), (SELECT typeID FROM Types WHERE typeName = 'MAGICAL')),
((SELECT itemID from Items WHERE itemName = "Brawler's Beat Stick"), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL')),
((SELECT itemID from Items WHERE itemName = 'The Sledge'), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL')),
((SELECT itemID from Items WHERE itemName = 'The Sledge'), (SELECT typeID FROM Types WHERE typeName = 'DEFENSIVE')),
((SELECT itemID from Items WHERE itemName = 'The Sledge'), (SELECT typeID FROM Types WHERE typeName = 'UTILITY'));

-- Will store information about SMITE characters, such as  role, class, and type
INSERT INTO Characters (characterName, primaryRoleID, primaryClassID, primaryTypeID)
Values
('ACHILLES', (SELECT roleID FROM Roles WHERE roleName = 'SOLO LANER'), (SELECT classID FROM Classes WHERE className = 'WARRIOR'), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL')),
('AGNI', (SELECT roleID FROM Roles WHERE roleName = 'MID LANER'), (SELECT classID FROM Classes WHERE className = 'MAGE'), (SELECT typeID FROM Types WHERE typeName = 'MAGICAL')),
('AH MUZEN CAB', (SELECT roleID FROM Roles WHERE roleName = 'ADC (ATTACK DAMAGE CARRY)'), (SELECT classID FROM Classes WHERE className = 'HUNTER'), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL')),
('ARES', (SELECT roleID FROM Roles WHERE roleName = 'SUPPORT'), (SELECT classID FROM Classes WHERE className = 'GUARDIAN'), (SELECT typeID FROM Types WHERE typeName = 'MAGICAL')),
('ARACHNE', (SELECT roleID FROM Roles WHERE roleName = 'JUNGLER'), (SELECT classID FROM Classes WHERE className = 'ASSASSIN'), (SELECT typeID FROM Types WHERE typeName = 'PHYSICAL'));


-- Items that characters should build
INSERT INTO Builds (characterID, itemID)
Values
((SELECT characterID FROM Characters WHERE characterName = 'ACHILLES'), (SELECT itemID from Items WHERE itemName = "Brawler's Beat Stick")),
((SELECT characterID FROM Characters WHERE characterName = 'ACHILLES'), (SELECT itemID from Items WHERE itemName = 'The Sledge')),
((SELECT characterID FROM Characters WHERE characterName = 'ACHILLES'), (SELECT itemID from Items WHERE itemName = "Genji's Guard"));