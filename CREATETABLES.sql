CREATE TABLE Items (
    itemID int(11) AUTO_INCREMENT,
    item_name varchar(255) NOT NULL,
    item_effect text,
    PRIMARY KEY (itemID),
    UNIQUE (item_name)
);

CREATE TABLE Roles (
    roleID int(11) AUTO_INCREMENT,
    role_name varchar(255) NOT NULL,
    role_description text,
    PRIMARY KEY (roleID),
    UNIQUE (role_name)
);

CREATE TABLE Classes (
    classID int(11) AUTO_INCREMENT,
    class_name varchar(255) NOT NULL,
    class_description text,
    PRIMARY KEY (classID),
    UNIQUE (class_name)
);

CREATE TABLE Types (
    typeID int(11) AUTO_INCREMENT,
    type_name varchar(255) NOT NULL,
    PRIMARY KEY (typeID),
    UNIQUE (type_name)
);

CREATE TABLE ItemTypes (
    itemTypeID int(11) AUTO_INCREMENT,
    itemID int(11),
    typeID int(11),
    PRIMARY KEY (itemTypeID),  
    FOREIGN KEY (itemID) REFERENCES Items(itemID),
    FOREIGN KEY (typeID) REFERENCES Types(typeID)
);

CREATE TABLE Gods (
    godID int(11) AUTO_INCREMENT,
    god_name varchar(255) NOT NULL,
    primaryRoleID int(11),
    primaryClassID int (11),
    primaryTypeID int(11),
    PRIMARY KEY (godID),
    UNIQUE (god_name),
    FOREIGN KEY (primaryRoleID) REFERENCES Roles(roleID),
    FOREIGN KEY (primaryClassID) REFERENCES Classes(classID),
    FOREIGN KEY (primaryTypeID) REFERENCES Types(typeID)
    );

CREATE TABLE Builds (
    buildID int(11) AUTO_INCREMENT,
    godID int(11),
    itemID int(11),
    PRIMARY KEY (buildID),
    FOREIGN KEY (godID) REFERENCES Gods(godID),
    FOREIGN KEY (itemID) REFERENCES Items(itemID)
);
