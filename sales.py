#! usr/bin/env python3
import praw
import pandas as pd
import datetime as dt
import re
import time
import pyodbc 
import random


server = 'localhost' 
database = 'authors' 
username = 'SA' 
password = 'REDACTED' 
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()

msgSubject = "Ryzen 5"
msgBody = "Hello, do you still have the Ryzen? Will you ship to Arizona?"
bodyComment = ['PMed','DMed!','Sent PM.']


topics = { "title":[], \
                "url":[], \
                "comms_num": [], \
                "created": [], \
                "title": [], 
                "author": [],\
                "body":[]}

reddit = praw.Reddit(client_id='REDACTED', \
                     client_secret='REDACTED', \
                     user_agent='sales', \
                     username='REDACTED', \
                     password='REDACTED')

i = 0

count = 0

while i < 1:
    
    subreddit = reddit.subreddit('hardwareswap')
    content = subreddit.new(limit=40)
    
    for submission in content:
        if re.search('\[H\].* Ryzen 5.*\[W\]', submission.title):
            authy = str(submission.author)
            qry = 'SELECT * FROM names WHERE name = ?'
            cursor.execute(qry, authy)
            if not cursor.fetchone():
                topics["title"].append(submission.title)
                topics["url"].append(submission.url)
                topics["comms_num"].append(submission.num_comments)
                topics["body"].append(submission.selftext)
                topics["created"].append(submission.created)
                topics["author"].append(submission.author)
                reddit.redditor(authy).message(msgSubject, msgBody)
                bc = random.sample(bodyComment,1)
                submission.reply(bc[0])

                print("Messaged "+authy)

                q = 'INSERT INTO names(name) VALUES (?)'
                cursor.execute(q, authy)
                cnxn.commit()

    uglyfeed = pd.DataFrame(topics)

    def get_date(created):
        return dt.datetime.fromtimestamp(created)

    _timestamp = uglyfeed["created"].apply(get_date)

    uglyfeed = uglyfeed.assign(timestamp = _timestamp)
    uglyfeed.to_csv('CPUs.csv', index=False)

    f=pd.read_csv("CPUs.csv")
    keep_col = ['timestamp','title','url','comms_num','body']
    new_f = f[keep_col]
    new_f.to_csv("CPUs.csv", index=False)

    pd.read_csv('CPUs.csv').to_excel('CPUs.xlsx')
    time.sleep(120)