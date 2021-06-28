#! usr/bin/env python3
import praw
import pandas as pd
import datetime as dt
import re
import time
import pyodbc 
import random
from datetime import datetime, timedelta
from urllib.request import Request, urlopen
from urllib.error import URLError, HTTPError

server = 'localhost' 
database = 'authors' 
username = 'SA' 
password = 'REDACTED' 
cnxn = pyodbc.connect('DRIVER={ODBC Driver 17 for SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
cursor = cnxn.cursor()
headers = {'User-Agent', 'Mozilla/5.0 (X11; Linux i686; G518Rco3Yp0uLV40Lcc9hAzC1BOROTJADjicLjOmlr4=) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/44.0.2403.157 Safari/537.36'}

reddit = praw.Reddit(client_id='REDACTED', \
                     client_secret='REDACTED', \
                     user_agent='REDACTED', \
                     username='REDACTED', \
                     password='REDACTED')
reddit.validate_on_submit=True   

i = 0
while i < 1:
        
    # topics = { "title":[], \
    #                 "url":[], \
    #                 "comms_num": [], \
    #                 "created": [], \
    #                 "author": [],\
    #                 "comments": [],\
    #                 "body":[]}
    
    subreddit = reddit.subreddit('popular')
    posts = subreddit.rising(limit=None)
    pattern = "(?P<url>https?://[^\s]+)"
    
    for submission in posts:
        now = datetime.now().strftime('%H:%M')
        comments = submission.comments.replace_more(limit=None)
        authy = str(submission.id) #need to change to submission ID rather than author in case author has multiple posts
        qry = 'SELECT * FROM names WHERE name = ?'
        cursor.execute(qry, authy)
        if not cursor.fetchone():
            # topics["title"].append(submission.title)
            # topics["url"].append(submission.url)
            # topics["comms_num"].append(submission.num_comments)
            # topics["body"].append(submission.selftext)
            # topics["created"].append(submission.created)
            # topics["author"].append(submission.author)
            # topics["comments"].append(submission.comments) 
            
            #scans child comments
            for comment in submission.comments:
                for commenttwo in comment.replies:
                
                    if re.search(pattern, commenttwo.body):

                        comment_body = commenttwo.body
                        url = re.search(pattern, comment_body)
                        url = url[0]
                        url = re.sub('\)\.|\<|\>|\,|\'|\"|\*|\|\)|\/\)','',url)
                        url = re.sub('\)','',url)
                        urlTrimmed = re.sub(r'^https?:\/\/', '', url)
                        
                        #web scraper
                        req = Request(str(url))
                        req.add_header(*headers)
                        url_list = ["reddit", "xkcd", "bbc", "etsy", "goo.gl" "twitch", "pastebin", "cnn", "fox", "netflix", "tiktok", "pornhub", "redtube", "hulu", "streamable", "amazon", "steamcommunity", "discord", "soundcloud", "youtube", "imgur", "google", "odysee", "youtu.be", "twitter", "wikipedia", "spotify", "redd.it", "github", "deviantart", "pixiv", "steampowered", "instagram", "facebook"]
                        urlpassed = any(link in url for link in url_list)

                        try:
                            response = urlopen(req)

                        except HTTPError as e:
                            continue
                            print('Error code: ', e.code)
                        except UnicodeEncodeError as e:
                            continue
                        except AttributeError as e:
                            continue
                        except URLError as e:
                            continue
                        except ValueError as e:
                            continue
                            

                        raw_html = response.read()
                        if not urlpassed:
                            
                            
                            if re.search('(teesmato.com)|(lookmaker.xyz)|(newfa.me.uk.*)|(edublogs.org)', str(raw_html)):
                                
                                #reddit acc collector

                                submission_title = submission.title
                                tcount = submission_title.split()
                                tcountnew = ""
                                for word in tcount:
                                    tcountnew += "^^" + str(word) + " "

                                comment_author = commenttwo.author
                                author_age = reddit.redditor(str(comment_author)).created_utc
                                author_age = datetime.utcfromtimestamp(author_age).strftime('%Y-%m-%d')
                                author_posts_karma = reddit.redditor(str(comment_author)).link_karma
                                author_comments_karma = reddit.redditor(str(comment_author)).comment_karma
                                submission_link = submission.permalink
                                submission_time = submission.created_utc
                                submission_time = datetime.utcfromtimestamp(submission_time).strftime('%Y-%m-%d ^^%H:%M')
                                masked_website = urlTrimmed
                                subreddit = submission.subreddit
                                ids = []

                                for posts in reddit.subreddit('all').search('author:' + str(comment_author), sort='new', limit=30):
                                    
                                    rid = posts.id
                                    rts = posts.created_utc
                                    ids.append(str(rid))

                                if len(ids) == 0:
                                    recent_post = "^^0."
                                    #need to set logic to filter for only posts in last 30 days
                                else:
                                    newestpost = ids[0] 
                                    recent_post_count = len(ids)#this does not work as intended right now just displays total # of posts
                                    recent_post = reddit.submission(newestpost).permalink

                                #reply to the post
                                submission.reply("**DO NOT BUY THIS T-SHIRT UNLESS YOU WANT TO GET SCAMMED AND LOSE YOUR CREDIT CARD!**\n\n" + "**/u/" + str(comment_author) + "** is using " + "**" + str(urlTrimmed) +"** which redirects to teesmato. These accounts are usually some months/year old purchased accounts where the scammer will make a handful of comments on random posts to make their account seem legitimate at first glance, then they will post a high quality t-shirt design in hopes that people will comment asking for the URL to buy said t-shirt. \n\nThey are also notorious for using alternate accounts to reply to the shop links saying something like \'Just bought one!\' in an attempt to make it look even more legitimate.\n\nNot only is the artwork infringed on, but these scammers will also use lower quality/cheaper print production options on your purchase to cut costs on their scam. Your t-shirt will hardly look like the one in OP, if they even send you the t-shirt at all. Who knows what they are doing with your credit card data as well. \n\nCheck out this [reddit comment](https://reddit.com/r/TheWho/comments/eqj99o/_/fewvn9q/?context=1) to read a bit more on the scam if you'd like.\n\n&nbsp;\n\n^Details ^that ^triggered ^this ^bot:\n\n* ^^Username: " + "^^" + str(comment_author) + "\n\n* ^^Account ^^creation ^^date: " + "^^" + str(author_age) + "\n\n* ^^Number ^^of ^^posts ^^in ^^the ^^last ^^30 ^^days: " + "^^" + str(recent_post_count) + "\n\n* ^^Overall ^^post ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Overall ^^comment ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Post ^^title: " + str(tcountnew) + "\n\n* ^^Post ^^link: " + "^^https://reddit.com" + str(submission_link) + "\n\n* ^^Post ^^date: " + "^^" + str(submission_time) + "\n\n* ^^Subreddit: " + "^^/r/" + str(subreddit) + "\n\n* ^^Masked ^^website: " + "^^" + str(urlTrimmed) + "\n\n___________________________________\n\n^^This ^^comment ^^was ^^made ^^by ^^a ^^bot ^^account.\n\n^^Check ^^out ^^my ^^subreddit, ^^r/TeesmatoNoMore, ^^for ^^more ^^information.\n\n")
                                

                                #submit archive post on my sub
                                archivepost = reddit.subreddit("TeesmatoNoMore").submit(title='Archive -- ' + str(comment_author),selftext=("\n\n^Details ^that ^triggered ^this ^bot:\n\n* ^^Username: " + "^^" + str(comment_author) + "\n\n* ^^Account ^^creation ^^date: " + "^^" + str(author_age) + "\n\n* ^^Number ^^of ^^posts ^^in ^^the ^^last ^^30 ^^days: " + "^^" + str(recent_post_count) + "\n\n* ^^Overall ^^post ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Overall ^^comment ^^karma: " + "^^" + str(author_comments_karma) + "\n\n* ^^Link ^^to ^^most ^^recent ^^post: " "^^" + str(recent_post) + "\n\n* ^^Post ^^title: " + str(tcountnew) + "\n\n* ^^Post ^^link: " + "^^https://reddit.com" + str(submission_link) + "\n\n* ^^Post ^^date: " + "^^" + str(submission_time) + "\n\n* ^^Subreddit: " + "^^/r/" + str(subreddit) + "\n\n* ^^Masked ^^website: " + "^^" + str(urlTrimmed)))
                                archiveid = archivepost.id
                                submission = reddit.submission(id=archiveid)
                                submission.mod.lock()
                                print("Scam reported.")

                                #Add ID to SQL showing that this post has already been replied to
                                q = 'INSERT INTO names(name) VALUES (?)'
                                cursor.execute(q, authy)
                                cnxn.commit()

                            else:
                                print(url)
                                print("No redirect found(child).\n" + " ---- " + str(now))
                        else:
                            print(url)
                            print("Skipped child URL.\n" + " ---- " + str(now))
        
        
            #Scans top level comments
                if re.search(pattern, comment.body):

                            comment_body = comment.body
                            url = re.search(pattern, comment_body)
                            url = url[0]
                            url = re.sub('\)\.|\<|\>|\,|\'|\"|\*|\|\)|\/\)','',url)
                            url = re.sub('\)','',url)
                            urlTrimmed = re.sub(r'^https?:\/\/', '', url)
                            
                            #web scraper
                            req = Request(str(url))
                            req.add_header(*headers)
                            url_list = ["reddit", "xkcd", "bbc", "etsy", "goo.gl" "twitch", "pastebin", "cnn", "fox", "netflix", "tiktok", "pornhub", "redtube", "hulu", "streamable", "amazon", "steamcommunity", "discord", "soundcloud", "youtube", "imgur", "google", "odysee", "youtu.be", "twitter", "wikipedia", "spotify", "redd.it", "github", "deviantart", "pixiv", "steampowered", "instagram", "facebook"]
                            urlpassed = any(link in url for link in url_list)
                            if not urlpassed:

                                #check if reddit top comment link is one of the main sites, not a redirect site.
                                if re.search('(teesmato.com)|(lookmaker.xyz)|(newfa.me.uk)|(edublogs.org)', url):
                                    #reddit acc collector

                                        submission_title = submission.title
                                        tcount = submission_title.split()
                                        tcountnew = ""
                                        for word in tcount:
                                            tcountnew += "^^" + str(word) + " "

                                        comment_author = comment.author
                                        author_age = reddit.redditor(str(comment_author)).created_utc
                                        author_age = datetime.utcfromtimestamp(author_age).strftime('%Y-%m-%d')
                                        author_posts_karma = reddit.redditor(str(comment_author)).link_karma
                                        author_comments_karma = reddit.redditor(str(comment_author)).comment_karma
                                        submission_link = submission.permalink
                                        submission_time = submission.created_utc
                                        submission_time = datetime.utcfromtimestamp(submission_time).strftime('%Y-%m-%d ^^%H:%M')
                                        masked_website = urlTrimmed
                                        subreddit = submission.subreddit
                                        ids = []

                                        for posts in reddit.subreddit('all').search('author:' + str(comment_author), sort='new', limit=30):
                                            
                                            rid = posts.id
                                            rts = posts.created_utc
                                            ids.append(str(rid))

                                        if len(ids) == 0:
                                            recent_post = "^^0."
                                            #need to set logic to filter for only posts in last 30 days
                                        else:
                                            newestpost = ids[0] 
                                            recent_post_count = len(ids)#this does not work as intended right now just displays total # of posts
                                            recent_post = reddit.submission(newestpost).permalink

                                        #reply to the post
                                        submission.reply("**DO NOT BUY THIS T-SHIRT UNLESS YOU WANT TO GET SCAMMED AND LOSE YOUR CREDIT CARD!**\n\n" + "**/u/" + str(comment_author) + "** is using " + "**" + str(urlTrimmed) +"** which redirects to teesmato. These accounts are usually some months/year old purchased accounts where the scammer will make a handful of comments on random posts to make their account seem legitimate at first glance, then they will post a high quality t-shirt design in hopes that people will comment asking for the URL to buy said t-shirt. \n\nThey are also notorious for using alternate accounts to reply to the shop links saying something like \'Just bought one!\' in an attempt to make it look even more legitimate.\n\nNot only is the artwork infringed on, but these scammers will also use lower quality/cheaper print production options on your purchase to cut costs on their scam. Your t-shirt will hardly look like the one in OP, if they even send you the t-shirt at all. Who knows what they are doing with your credit card data as well. \n\nCheck out this [reddit comment](https://reddit.com/r/TheWho/comments/eqj99o/_/fewvn9q/?context=1) to read a bit more on the scam if you'd like.\n\n&nbsp;\n\n^Details ^that ^triggered ^this ^bot:\n\n* ^^Username: " + "^^" + str(comment_author) + "\n\n* ^^Account ^^creation ^^date: " + "^^" + str(author_age) + "\n\n* ^^Number ^^of ^^posts ^^in ^^the ^^last ^^30 ^^days: " + "^^" + str(recent_post_count) + "\n\n* ^^Overall ^^post ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Overall ^^comment ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Post ^^title: " + str(tcountnew) + "\n\n* ^^Post ^^link: " + "^^https://reddit.com" + str(submission_link) + "\n\n* ^^Post ^^date: " + "^^" + str(submission_time) + "\n\n* ^^Subreddit: " + "^^/r/" + str(subreddit) + "\n\n* ^^Masked ^^website: " + "^^" + str(urlTrimmed) + "\n\n___________________________________\n\n^^This ^^comment ^^was ^^made ^^by ^^a ^^bot ^^account.\n\n^^Check ^^out ^^my ^^subreddit, ^^r/TeesmatoNoMore, ^^for ^^more ^^information.\n\n")
                                        

                                        #submit archive post on my sub
                                        archivepost = reddit.subreddit("TeesmatoNoMore").submit(title='Archive -- ' + str(comment_author),selftext=("\n\n^Details ^that ^triggered ^this ^bot:\n\n* ^^Username: " + "^^" + str(comment_author) + "\n\n* ^^Account ^^creation ^^date: " + "^^" + str(author_age) + "\n\n* ^^Number ^^of ^^posts ^^in ^^the ^^last ^^30 ^^days: " + "^^" + str(recent_post_count) + "\n\n* ^^Overall ^^post ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Overall ^^comment ^^karma: " + "^^" + str(author_comments_karma) + "\n\n* ^^Link ^^to ^^most ^^recent ^^post: " "^^" + str(recent_post) + "\n\n* ^^Post ^^title: " + str(tcountnew) + "\n\n* ^^Post ^^link: " + "^^https://reddit.com" + str(submission_link) + "\n\n* ^^Post ^^date: " + "^^" + str(submission_time) + "\n\n* ^^Subreddit: " + "^^/r/" + str(subreddit) + "\n\n* ^^Masked ^^website: " + "^^" + str(urlTrimmed)))
                                        archiveid = archivepost.id
                                        submission = reddit.submission(id=archiveid)
                                        submission.mod.lock()
                                        print("Scam reported.")

                                        #Add ID to SQL showing that this post has already been replied to
                                        q = 'INSERT INTO names(name) VALUES (?)'
                                        cursor.execute(q, authy)
                                        cnxn.commit()
                                else:
                                    print("Top comment - No redirect found.\n" + url + '\n' + " ---- " + str(now))
                            #if reddit top level comment isnt a main link, check the url for a redirect to main links.
                            else:

                                try:
                                    response = urlopen(req)

                                except HTTPError as e:
                                    continue
                                except UnicodeEncodeError as e:
                                    continue
                                except AttributeError as e:
                                    continue
                                except URLError as e:
                                    continue 
                                except ValueError as e:
                                    continue

                                raw_html = response.read()
                                if not urlpassed:
                                    #checking redirect link in top level comment
                                    if re.search('(teesmato.com)|(lookmaker.xyz)|(newfa.me.uk.*)|(edublogs.org)', str(raw_html)):
                                        
                                        #reddit acc collector

                                        submission_title = submission.title
                                        tcount = submission_title.split()
                                        tcountnew = ""
                                        for word in tcount:
                                            tcountnew += "^^" + str(word) + " "

                                        comment_author = comment.author
                                        author_age = reddit.redditor(str(comment_author)).created_utc
                                        author_age = datetime.utcfromtimestamp(author_age).strftime('%Y-%m-%d')
                                        author_posts_karma = reddit.redditor(str(comment_author)).link_karma
                                        author_comments_karma = reddit.redditor(str(comment_author)).comment_karma
                                        submission_link = submission.permalink
                                        submission_time = submission.created_utc
                                        submission_time = datetime.utcfromtimestamp(submission_time).strftime('%Y-%m-%d ^^%H:%M')
                                        masked_website = urlTrimmed
                                        subreddit = submission.subreddit
                                        ids = []

                                        for posts in reddit.subreddit('all').search('author:' + str(comment_author), sort='new', limit=30):
                                            
                                            rid = posts.id
                                            rts = posts.created_utc
                                            ids.append(str(rid))

                                        if len(ids) == 0:
                                            recent_post = "^^0."
                                            #need to set logic to filter for only posts in last 30 days
                                        else:
                                            newestpost = ids[0] 
                                            recent_post_count = len(ids)#this does not work as intended right now just displays total # of posts
                                            recent_post = reddit.submission(newestpost).permalink

                                        #reply to the post
                                        submission.reply("**DO NOT BUY THIS T-SHIRT UNLESS YOU WANT TO GET SCAMMED AND LOSE YOUR CREDIT CARD!**\n\n" + "**/u/" + str(comment_author) + "** is using " + "**" + str(urlTrimmed) +"** which redirects to teesmato. These accounts are usually some months/year old purchased accounts where the scammer will make a handful of comments on random posts to make their account seem legitimate at first glance, then they will post a high quality t-shirt design in hopes that people will comment asking for the URL to buy said t-shirt. \n\nThey are also notorious for using alternate accounts to reply to the shop links saying something like \'Just bought one!\' in an attempt to make it look even more legitimate.\n\nNot only is the artwork infringed on, but these scammers will also use lower quality/cheaper print production options on your purchase to cut costs on their scam. Your t-shirt will hardly look like the one in OP, if they even send you the t-shirt at all. Who knows what they are doing with your credit card data as well. \n\nCheck out this [reddit comment](https://reddit.com/r/TheWho/comments/eqj99o/_/fewvn9q/?context=1) to read a bit more on the scam if you'd like.\n\n&nbsp;\n\n^Details ^that ^triggered ^this ^bot:\n\n* ^^Username: " + "^^" + str(comment_author) + "\n\n* ^^Account ^^creation ^^date: " + "^^" + str(author_age) + "\n\n* ^^Number ^^of ^^posts ^^in ^^the ^^last ^^30 ^^days: " + "^^" + str(recent_post_count) + "\n\n* ^^Overall ^^post ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Overall ^^comment ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Post ^^title: " + str(tcountnew) + "\n\n* ^^Post ^^link: " + "^^https://reddit.com" + str(submission_link) + "\n\n* ^^Post ^^date: " + "^^" + str(submission_time) + "\n\n* ^^Subreddit: " + "^^/r/" + str(subreddit) + "\n\n* ^^Masked ^^website: " + "^^" + str(urlTrimmed) + "\n\n___________________________________\n\n^^This ^^comment ^^was ^^made ^^by ^^a ^^bot ^^account.\n\n^^Check ^^out ^^my ^^subreddit, ^^r/TeesmatoNoMore, ^^for ^^more ^^information.\n\n")
                                        

                                        #submit archive post on my sub
                                        archivepost = reddit.subreddit("TeesmatoNoMore").submit(title='Archive -- ' + str(comment_author),selftext=("\n\n^Details ^that ^triggered ^this ^bot:\n\n* ^^Username: " + "^^" + str(comment_author) + "\n\n* ^^Account ^^creation ^^date: " + "^^" + str(author_age) + "\n\n* ^^Number ^^of ^^posts ^^in ^^the ^^last ^^30 ^^days: " + "^^" + str(recent_post_count) + "\n\n* ^^Overall ^^post ^^karma: " + "^^" + str(author_posts_karma) + "\n\n* ^^Overall ^^comment ^^karma: " + "^^" + str(author_comments_karma) + "\n\n* ^^Link ^^to ^^most ^^recent ^^post: " "^^" + str(recent_post) + "\n\n* ^^Post ^^title: " + str(tcountnew) + "\n\n* ^^Post ^^link: " + "^^https://reddit.com" + str(submission_link) + "\n\n* ^^Post ^^date: " + "^^" + str(submission_time) + "\n\n* ^^Subreddit: " + "^^/r/" + str(subreddit) + "\n\n* ^^Masked ^^website: " + "^^" + str(urlTrimmed)))
                                        archiveid = archivepost.id
                                        submission = reddit.submission(id=archiveid)
                                        submission.mod.lock()
                                        print("Scam reported.")

                                        #Add ID to SQL showing that this post has already been replied to
                                        q = 'INSERT INTO names(name) VALUES (?)'
                                        cursor.execute(q, authy)
                                        cnxn.commit()

                                    else:
                                        print(url)
                                        print("No redirect found.\n" + " ---- " + str(now))
                                else:
                                    print(url)
                                    print("Top level comment URL skipped.\n" + " ---- " + str(now))

        
        else:
            print("ID already in database: " + authy)