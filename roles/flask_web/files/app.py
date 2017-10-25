import os
from flask import Flask
from flaskext.mysql import MySQL
app = Flask(__name__)

mysql = MySQL()

mysql_database_host = 'MYSQL_DATABASE_HOST' in os.environ and os.environ['MYSQL_DATABASE_HOST'] or  'localhost'
mysql_database_user = 'MYSQL_DATABASE_USER' in os.environ and os.environ['MYSQL_DATABASE_USER'] or  'db_user'
mysql_database_password = 'MYSQL_DATABASE_PASSWORD' in os.environ and os.environ['MYSQL_DATABASE_PASSWORD'] or  'Passw0rd'
mysql_database_db = 'MYSQL_DATABASE_DB' in os.environ and os.environ['MYSQL_DATABASE_DB'] or  'employee_db'

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = mysql_database_user
app.config['MYSQL_DATABASE_PASSWORD'] = mysql_database_password
app.config['MYSQL_DATABASE_DB'] = mysql_database_db
app.config['MYSQL_DATABASE_HOST'] = mysql_database_host
mysql.init_app(app)

conn = mysql.connect()

cursor = conn.cursor()

@app.route("/")
def main():
    return "Welcome!"

@app.route('/how are you')
def hello():
    return 'I am good, how about you?'

@app.route('/read from database')
def read():
    cursor.execute("SELECT * FROM employees")
    row = cursor.fetchone()
    result = []
    while row is not None:
      result.append(row[0])
      row = cursor.fetchone()

    return ",".join(result)

if __name__ == "__main__":
    app.run(host='0.0.0.0')
