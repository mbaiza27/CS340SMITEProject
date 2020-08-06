from flask import Flask, render_template
from flask import request, redirect, url_for
from .db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)

@webapp.route('/', methods=['GET'])
def default_page():
    return render_template('index.html')

@webapp.route('/gods')
#Page for browsing gods
def browse_gods():
    db_connection = connect_to_database()
    query = "SELECT ch.characterName, ro.roleName, cl.className, ty.typeName FROM Characters ch \
    JOIN Roles ro ON ch.primaryRoleID = ro.roleID  \
    JOIN Classes cl ON ch.primaryClassID = cl.classID  \
    JOIN Types ty ON ch.primaryTypeID = ty.typeID;"

    result = execute_query(db_connection, query).fetchall()
    return render_template('gods.html', rows=result)

@webapp.route('/items', methods=['GET'])
#Page for browsing items
def browse_items():
    db_connection = connect_to_database()
    query = "SELECT itemName, effect FROM Items"
    result = execute_query(db_connection, query).fetchall()
    return render_template('items.html', rows=result)

@webapp.route('/adminGods', methods=['GET'])
#Page for viewing gods table and adding gods
def add_gods():
    db_connection = connect_to_database()
    query = "SELECT ch.characterID, ch.characterName, ro.roleName, cl.className, ty.typeName FROM Characters ch \
    JOIN Roles ro ON ch.primaryRoleID = ro.roleID  \
    JOIN Classes cl ON ch.primaryClassID = cl.classID  \
    JOIN Types ty ON ch.primaryTypeID = ty.typeID;"

    query2 = "SELECT roleID, roleName FROM Roles"
    query3 = "SELECT classID, className FROM Classes"
    query4 = "SELECT typeID, typeName FROM Types"

    godResult = execute_query(db_connection, query).fetchall()
    roleResult = execute_query(db_connection, query2).fetchall()
    classResult = execute_query(db_connection, query3).fetchall()
    typeResult = execute_query(db_connection, query4).fetchall()

    return render_template('adminGods.html', godRows=godResult, classRows=classResult, roleRows=roleResult, typeRows=typeResult)


@webapp.route('/addGod', methods=['POST'])
def insert_god():
    print("ayy lmao")

    newGodName = request.form['userGodName']
    newGodRole = request.form['userRole']
    newGodClass = request.form['userClass']
    newGodType = request.form['userType']

    userInput = (newGodName, newGodRole, newGodClass, newGodType)

    db_connection = connect_to_database()

    insertQuery = 'INSERT into Characters (characterName, primaryRoleID, primaryClassID, primaryTypeID) \
    VALUES (%s, %s, %s, %s)'

    execute_query(db_connection, insertQuery, userInput)

    return redirect(url_for('add_gods'))

@webapp.route('/adminTypes', methods=['GET'])
#Page for viewing types table and adding types
def add_types():
    db_connection = connect_to_database()
    query = "SELECT typeID, typeName FROM Types"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminTypes.html', rows=result)

@webapp.route('/adminClasses', methods=['GET'])
#Page for viewing classes table and adding more classes
def add_classes():
    db_connection = connect_to_database()
    query = "SELECT classID, className, description FROM Classes"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminClasses.html', classRows=result)

@webapp.route('/adminItems', methods=['GET'])
#Page for viewing items table and adding more items
def add_items():
    db_connection = connect_to_database()
    query = "SELECT itemID, itemName, effect FROM Items"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminItems.html')

@webapp.route('/adminItemTypes', methods=['GET'])
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

@webapp.route('/adminRoles', methods=['GET'])
#Page for viewing roles and adding new roles
def add_roles():
    db_connection = connect_to_database()
    query = "SELECT roleID, roleName, description FROM Roles"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminRoles.html', rows=result)
