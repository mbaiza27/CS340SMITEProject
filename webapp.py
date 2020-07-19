from flask import Flask, render_template
from flask import request, redirect
from db_connector.db_connector import connect_to_database, execute_query
#create the web application
webapp = Flask(__name__)

@webapp.route('/adminGods')

def browse_admin_gods():
    print("Fetching and rendering admin level Gods web page")
    #Connect to database
    db_connection = connect_to_database()
    #execute query
    query = "SELECT ;"
    result = execute_query(db_connection, query).fetchall()
    print(result)
    return render_template('adminGods.html', rows = result)