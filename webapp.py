from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)

@webapp.route('/gods')
#Page for browsing gods
def browse_gods():
    db_connection = connect_to_database()
    query = "SELECT ch.characterName, ro.roleName, cl.className, ty.typeName FROM Characters ch JOIN Roles ro ON ch.primaryRoleID = ro.roleID  JOIN Classes cl ON ch.primaryClassID = cl.classID  JOIN Types ty ON ch.primaryTypeID = ty.typeID;"
    result = execute_query(db_connection, query).fetchall()
    return render_template('gods.html', rows=result)

@webapp.route('/items')
#Page for browsing items
def browse_items():
    db_connection = connect_to_database()
    query = "SELECT itemName, effect FROM Items"
    result = execute_query(db_connection, query).fetchall()
    return render_template('items.html', rows=result)

@webapp.route('/adminGods')
#Page for viewing gods table and adding gods
def add_gods():
    db_connection = connect_to_database()
    query = "SELECT characterID, characterName, primaryRoleID, primaryClassID, primaryTypeID FROM Characters"
    query2 = "SELECT roleName FROM Roles"
    query3 = "SELECT className FROM Classes"
    query4 = "SELECT typeName FROM Types"
    godResult = execute_query(db_connection, query).fetchall()
    roleResult = execute_query(db_connection, query2).fetchall()
    classResult = execute_query(db_connection, query3).fetchall()
    typeResult = execute_query(db_connection, query4).fetchall()
    return render_template('adminGods.html', godRows=godResult, classRows=classResult, roleRows=roleResult, typeRows=typeResult)

@webapp.route('/adminTypes')
#Page for viewing types table and adding types
def add_types():
    db_connection = connect_to_database()
    query = "SELECT typeID, typeName FROM Types"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminTypes.html', rows=result)

@web.route('/adminClasses')
#Page for viewing classes table and adding more classes
def add_classes():
    db_connection = connect_to_database()
    query = "SELECT classID, className, description FROM Classes"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminClasses.html', classRows=result)

@web.route('/adminItems')
#Page for viewing items table and adding more items
def add_items():
    db_connection = connect_to_database()
    query = "SELECT itemID, itemName, effect FROM Items"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminItems.html')

@web.route('/adminItemTypes')
#Page for viewing item types table and assigning items to types
def assign_item_types():
    db_connection = connect_to_database()
    query = "SELECT itemTypeID, itemID, typeID FROM ItemTypes"
    query2 = "SELECT itemName FROM Items"
    query3 = "SELECT typeName FROM Types"
    resultItemTypes = execute_query(db_connection, query).fetchall()
    resultItems = execute_query(db_connection, query2).fetchall()
    resultTypes = execute_query(db_connection, query3).fetchall()
    return render_template('adminItemTypes.html', rows=resultItemTypes, itemRows=resultItems, typeRows=resultTypes)

@web.route('/adminRoles')
#Page for viewing roles and adding new roles
def add_roles():
    db_connection = connect_to_database()
    query = "SELECT roleID, roleName, description FROM Roles"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminRoles.html', rows=result)

    