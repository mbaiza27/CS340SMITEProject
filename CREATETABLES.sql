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
