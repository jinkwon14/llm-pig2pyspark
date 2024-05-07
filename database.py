import sqlite3

class Database:
    def __init__(self, db_name='app.db'):
        self.conn = sqlite3.connect(db_name)
        self.cursor = self.conn.cursor()

        # Create tables if they don't exist
        self.cursor.execute('''
            CREATE TABLE IF NOT EXISTS pig_files (
                id INTEGER PRIMARY KEY,
                file_path TEXT
            )
        ''')
        # Create other necessary tables here

    # Methods for interacting with the database
