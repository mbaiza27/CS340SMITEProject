from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)

@webapp.route('/gods')

def browse_gods():
    db_connection = connect_to_database()
    query = "SELECT ch.characterName, ro.roleName, cl.className, ty.typeName FROM Characters ch JOIN Roles ro ON ch.primaryRoleID = ro.roleID  JOIN Classes cl ON ch.primaryClassID = cl.classID  JOIN Types ty ON ch.primaryTypeID = ty.typeID;"
    result = execute_query(db_connection, query).fetchall()
    return render_template('gods.html', rows=result)

#@webapp.route('/items')

@webapp.route('/adminGods')

def add_gods():
    db_connection = connect_to_database()
    query = "SELECT characterID, characterName, primaryRoleID, primaryClassID, primaryTypeID FROM Characters"
    godResult = execute_query(db_connection, query).fetchall()
    query2 = ""
    return render_template('adminGods.html', godRows=godResult)

def browse_admin_gods():
    print("Fetching and rendering admin level Gods web page")
    #Connect to database
    db_connection = connect_to_database()
    #execute query
    query = "SELECT ;"
    result = execute_query(db_connection, query).fetchall()
    print(result)
    return render_template('adminGods.html', rows = result)