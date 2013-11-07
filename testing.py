#!/usr/bin/python
# -*- coding: utf-8 -*-

import sqlite3 as lite
import sys


con = lite.connect('db/development.sqlite3')

with con:    
    
    cur = con.cursor()    
    cur.execute("SELECT users.id,orders.* FROM Users JOIN Orders where users.id=orders.user_id GROUP BY users.id")

    rows = cur.fetchall()

    for row in rows:
        print row

