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

@webapp.route('/addType', methods=['POST'])
#Page for viewing types table and adding types
def insert_type():

    newTypeName = request.form['userTypeName']

    db_connection = connect_to_database()

    insertQuery = 'INSERT INTO Types (typeName) VALUES (%s)'

    # the comma - https://stackoverflow.com/questions/21740359/python-mysqldb-typeerror-not-all-arguments-converted-during-string-formatting

    userInput = (newTypeName,)
    execute_query(db_connection, insertQuery, userInput)

    return redirect(url_for('add_types'))

@webapp.route('/adminClasses', methods=['GET'])
#Page for viewing classes table and adding more classes
def add_classes():
    db_connection = connect_to_database()
    query = "SELECT classID, className, description FROM Classes"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminClasses.html', classRows=result)

@webapp.route('/addClass', methods=['POST'])
#Page for viewing classes table and adding more classes
def insert_class():

    newClassName = request.form['userClassName']
    newClassDescrip = request.form['userClassDescription']

    db_connection = connect_to_database()

    insertQuery = "INSERT INTO Classes (className, description) VALUES (%s, %s)"

    userInput = (newClassName, newClassDescrip)

    execute_query(db_connection, insertQuery, userInput)

    return redirect(url_for('add_classes'))


@webapp.route('/adminItems', methods=['GET'])
#Page for viewing items table and adding more items
def add_items():
    db_connection = connect_to_database()
    query = "SELECT itemID, itemName, effect FROM Items"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminItems.html', itemRows=result)

@webapp.route('/addItem', methods=['POST'])
#Page for viewing items table and adding more items
def insert_item():
    newItemName = request.form['userItemName']
    newItemEffect = request.form['userItemEffect']

    db_connection = connect_to_database()

    insertQuery = "INSERT INTO Items (itemName, effect) VALUES (%s, %s)"

    userInput = (newItemName,newItemEffect)

    execute_query(db_connection, insertQuery, userInput)

    return redirect(url_for('add_items'))


@webapp.route('/adminItemTypes', methods=['GET'])
#Page for viewing item types table and assigning items to types
def assign_item_types():
    db_connection = connect_to_database()
    query = "SELECT itemTypeID, itemID, typeID FROM ItemTypes"

    query = "SELECT itt.itemTypeID, it.itemName, ty.typeName FROM ItemTypes itt \
    JOIN Items it ON itt.itemID = it.itemID \
    JOIN Types ty ON itt.typeID = ty.typeID \
    ORDER BY itt.itemTypeID ASC"

    query2 = "SELECT itemID, itemName FROM Items"
    query3 = "SELECT typeID, typeName FROM Types"
    resultItemTypes = execute_query(db_connection, query).fetchall()
    resultItems = execute_query(db_connection, query2).fetchall()
    resultTypes = execute_query(db_connection, query3).fetchall()
    return render_template('adminItemTypes.html', rows=resultItemTypes, itemRows=resultItems, typeRows=resultTypes)

@webapp.route('/update_Item_Types/<string:itemName>/<string:typeName>', methods=['POST','GET'])
def update_Item_Types(itemName, typeName):
    print('In the function')
    db_connection = connect_to_database()
    #display existing data
    if request.method == 'GET':
        print('The GET request')
        item_types_query = "SELECT itt.itemTypeID, it.itemName, ty.typeName FROM ItemTypes itt \
        JOIN Items it ON itt.itemID = it.itemID \
        JOIN Types ty ON itt.typeID = ty.typeID \
        WHERE it.itemName = %s AND ty.typeName = %s"
        types_query = "SELECT typeID, typeName FROM Types"
        data = (itemName, typeName)
        item_types_result = execute_query(db_connection, item_types_query, data).fetchone()
        types_result = execute_query(db_connection, types_query).fetchall()

        if item_types_result == None:
            return "No such Item/Type combination found!"

        print('Returning')
        return render_template('updateItemTypes.html', typeRows=types_result, rows=item_types_result)
    elif request.method == 'POST':
        print('The POST request')
        newtypeName = request.form['userType']
        
        query = "UPDATE ItemTypes SET typeID = (SELECT typeID FROM Types WHERE typeName = %s) WHERE itemID = (SELECT itemID from Items WHERE itemName = %s) AND typeID = (SELECT typeID from Types WHERE typeName = %s);"
        data = (newtypeName, itemName, typeName)
        result = execute_query(db_connection, query, data)
        print(str(result.rowcount) + " row(s) updated")

        return redirect(url_for('assign_item_types'))

@webapp.route('/delete_Item_Types/<string:itemName>/<string:typeName>')
#Backend code for delete functionality
def delete_Item_Types(itemName, typeName):
    db_connection = connect_to_database()
    query = "DELETE FROM ItemTypes WHERE itemID = (SELECT itemID from Items WHERE itemName = %s) AND typeID = (SELECT typeID from Types WHERE typeName = %s);"
    data = (itemName,typeName)

    result = execute_query(db_connection, query, data)
    return redirect(url_for('assign_item_types'))

@webapp.route('/addItemType', methods=['POST'])
#Page for viewing item types table and assigning items to types
def insert_item_type():

    itemChoice= request.form['userItem']
    typeChoice = request.form['userType']

    db_connection = connect_to_database()

    insertQuery = "INSERT INTO ItemTypes (itemID, typeID) VALUES (%s, %s)"

    userInput = (itemChoice,typeChoice)

    execute_query(db_connection, insertQuery, userInput)
    
    return redirect(url_for('assign_item_types'))

@webapp.route('/adminRoles', methods=['GET'])
#Page for viewing roles and adding new roles
def add_roles():
    db_connection = connect_to_database()
    query = "SELECT roleID, roleName, description FROM Roles"
    result = execute_query(db_connection, query).fetchall()
    return render_template('adminRoles.html', rows=result)

@webapp.route('/addRole', methods=['POST'])
#Page for viewing roles and adding new roles
def insert_role():

    newRoleName = request.form['userRoleName']
    newItemDescrip = request.form['userRoleDescription']

    db_connection = connect_to_database()
    
    insertQuery = "INSERT INTO Roles (roleName, description) VALUES (%s, %s)"

    userInput = (newRoleName,newItemDescrip)

    execute_query(db_connection, insertQuery, userInput)

    return redirect(url_for('add_roles'))

