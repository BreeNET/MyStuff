# MyStuff

<h1>Preface: </h1>

Here is a repo of scripts I have made. 
As anyone looks through these scripts they will probably say "Why did you even need this script theres a million programs that do it already."
I was a level 1 help desk employee so I had no voice in what programs should be implemented or what processes should be changed. All I could do is work with what I had access to which was powershell. I also started writing most of these scripts with 0 experience in powershell/js/python. After ~2 years of making scripts, I see many things that could be changed within these scripts or lines that will make any reader with some development knowledge say "lmao what is this???" but I do not maintain them anymore.



<h2>Cdrivefull.ps1</h2>

Background: 

Retail locations each have their own independent CCTV system that is accessed by multiple employees daily. The employees that investigate CCTV footage would call in because they could not playback or burn video. 
This was due to the C drive being full on the local cctv system operating at that store. The drive would fill up because the program has a heavy cache, and employees would save footage to their desktop on a 200GB C drive rather than using their 4TB network share. Our process was to delete contents out of %appdata% for each user and delete user profiles that have not logged in for over 90 days. I took this a step further by creating a user folder for them on the network drive and copying video from user/videos or user/desktop to the network drive. 


<h2>CP3000_regen.ps1</h2>

Background: 

Stores would call in daily because the files that contains all of their sales data for the previous day did not sync from the cash registers to their store server so they cannot process their accounting for that day. We had to regenerate 2-3 sales files using an existing batch file, then run another batch file that transfers it from the store server that handles the sales data, to the store server that employees log into to process and verify the data. This was a daily call that every member on my desk would receive at least 10 times a day. Rather than log into the server and manually run the batch files this script just runs everything in one step.


<h2>Enable_vAccs.ps1</h2>

Background: 

As mentioned previously, each store has an independent CCTV system. When the hardware breaks or when new cameras need to be installed/replaced, a field vendor goes out and completes the work. They need access to the CCTV system in order to complete their work. Our process for these calls was to log into the cctv system, enable a local windows account and reset the password to the latest password it should be per our documents, then open the cctv software and enable a secondary vendor account there. This process could take upwards of 25 minutes as some stores ran on satellite internet so connections were very slow, and the program itself easily would take 5-6 minutes to fully load up the software for us to log into and enable the 2nd vendor account. At the time of making, some stores were going through an upgrade. Legacy stores had 1 workstation that ran the CCTV client and server. update stores had a workstation client that logged into a secondary server. the software license could either be on the workstation or the server. To require minimal intervention, the script checks which machine is licensed and runs the process there. It enables the local windows account, resets the password to the laest, then changes some sql column data from "deactivated"  to "activated" enabling the 2nd vendor account. Turning a 20 minute call into a 4 minute call. 3 minutes of that being verifying the password the vendor has and filling out our incident ticket. 


<h2>Disable_vAccs.ps1</h2>

Background: 

Same thing as enable_vAccs but disables it instead. 


<h2>MAR_CO_REGEN.ps1</h2>

Background:

There were 2 different accounting programs for the stores to process and validate sales. 
This script was made for the 2nd version of their accounting software, similar to cp3000_regen. 
It runs existing batch files to regenerate the sales files, then it copies the sales files from the data server to the process server, then it runs another existing batch file to parse the sales data into a database. 


<h2>MarkdownRefresh.ps1</h2>

Background: 

"Markdowns" is a process in which employees walk around the store with wireless barcode scanners scanning every item to see if the price has been lowered. Store ratings and bonuses are based on their markdown accuracy so this is an important event to the employees. Prior to starting their markdowns, stores will call us to "refresh markdowns" which consists of rebooting access points, deleting connection state files from the server the units communicate with, and rebooting the server itself. There was no accessible API for the access points so we still had to log in manually and do that but this script does the rest in one click. 



<h2>MarkdownReplacement.ps1</h2>

Background: 

My initial inspiration for learning powershell, and it is the first script I made. Store employees are careless with these barcode scanners so they either drop them or just handle them poorly resulting in damaged units that need to be sent back to warehouse to refurbish or replace. One of my helpdesks biggest problems was that when we would send these tickets to the warehouse saying "this unit needs to be replaced," many agents would either forget to notate something like a server IP address or a serial number, or they would just guess on the IP address rather than collect the actual ip address. This creates a cascading effect. Ticket has wrong info so shipment is delayed. Store is receiving a lower score on their markdown event because they are down a barcode scanner. if they receive units that had duplicate IP addresses they are also down an additional scanner resulting in slower scan performance. The units were locked down so store employees could not change it. If a unit had a wrong/duplicate IP address or if a ticket had missing info, it would not be corrected until a service desk agent rectified the problem. So this script just automates the collection process and ensures no information is missed. Store turns on all their barcode scanners then HD agent runs the script. It copies all of the necessary info to the agent sclipboard where all they have to do is paste it into their worknotes. The agent will still need to collect a serial number and tracking number as those arent scrapable through cmd but at least the agent will see a blank "Tracking: " line reminding them to not forget to collect this information. This vastly reduced the number of duplicate Ip or missing info tickets. 



<h2>NewDPPTest.ps1</h2>

Background: 

Store card readers / debit pin pads break a lot due to various software/hardware issues. 
Stores will call us and tell us the cash register is not accepting card payments. Our process for this was to reboot the register as the DPP was powered by the register so it reboots both. Then we have to ping the pinpad and make sure its online, we have to delete the pairing file off the register, have the caller run the pairing process and we have to ensure specific services are running on register and the server that the register talks to. This script will test if the pinpad is reachable, it will delete the pair file and it will reboot the register. 
It copies the info the agents clipboard so all they have to do is paste it to their ticket notes and see the results themselves and go from there. If its not pinging have caller check ethernet cable. If this service cant start then check it out and see why its failing to start. Most of the time rebooting and deleting the pairing file will suffice. This turns this long manuall process into one click. 



<h2>Registers.ps1 </h2>

Background: 

Cash registers can have multiple issues. They can have the wrong system time, they can be frozen mid transaction, the local windows account that is supposed to autologin (the employees arent even aware of this account) will sometiems lock itself out, the oracle DB that runs the cash register software can have a variety of different sql errors with different fixes for each, it deletes status files as sometimes they are left behind as artifacts, and sometimes they just need a reboot first thing in the morning. This script is just a control panel to run each of those functions on one or all registers depending on the callers request. 



<h2>Thin client info.ps1</h2>

Background: 

Store office computers are thin clients that just connect to their data processing server for things like email, accounting etc. We replace them if they are not fixable remotely for whatever reason. Sometimes SD agents will put the wrong IP address/hostname when replacing these devices. Rather than manually collecting the required info from the caller, the helpdesk agent just needs to ask which office the thin client is in, then the agent types in the store name and clicks which office needs to be replaced. Then they can copy all of the relevant info into their work notes ensuring accurace documentation and no delay of shipments or functionaly due to having incomplete information. 


<h2>HDD backup.ps1</h2>

Background: 

When a cash register has issues, we try to troubleshoot it for a day. If the issue takes longer than that to resolve, we just send a field vendor out to swap the hard drive with a fresh image so they wont be down a cash register for an extended time. When these replacements are about to take place, the field vendor will call us to let us know so we can back up the sales files for that register. Many of my co workers were either too lazy or uncaring to read each step on the KB document which leads to improper backups. This wasnt entirely critical as the data was alerady backed up to a corporate server, but when that happens it could take a month for corporate office to get accurate sales data for this store. So we had to back up 3 differnt files to another server and then move them once more, and rename them. This was a tedious process that many associates messed up so I scripted it to do it all in one motion. I took it a step further as well to create a secondary backup in case any files were corrupt or failed to transmit, and a scheduled task to delete this secondary backup to prevent clutter of multiple unneeded backups. 





<h1>Scripts I've made in my own time for personal reasons not related to work: </h1>



<h2>Music.ps1</h2>

Background: 

My friend is a live streamer on twitch.tv. 
Twitch.tv has a chat feature, and people set up bots to make chat interactive. My friend plays music during her stream and many times someone will say in chat "OOO I like this song whats it called?"
I could not figure out how to scrape spotify api directly but I found out spotify can be linked to last.fm. last.fm has an api that can be scraped so I scraped the api and just saved the data to a blank page on my web server. Now when someone typed in "!song" into my friends chatroom, the bot would read that blank page that contained nothing but title and artist name and then print the results in the chatroom. "Now playing Rap God by Eminem" 
I also made a command for !lastsong that would just say what the previous song playing was. 



<h2>sales.py</h2>

Background: 

My friend was trying to buy a ryzen 3 off reddit/hardwareswap but people kept beating him to offer for it. I made a reddit bot that looks for any titled post containg [H] RYZEN 3. The bot will comment on the post from an array of messages, and then it will DM the poster also with another array of messages asking for price and willing to ship. This helped me get the first offer in. 








<h2>tee.py</h2>

Background: 

I have seen a handful of posts on reddit that go like this: Someone posts a picture of a tshirt. They do not advertise that they are selling the shirt or that its for sale at all. Its just a post of an interesting shirt. However, these people know someone will comment saying "Where can I get one??" Then the person who posted the tshirt will paste a url that looks legitimate at first glance, where there will be a single t shirt with a buy now button/ But that button redirects to another url, teemsato. This is a drop ship / scam website where the tshirt is horrible quality compared to the post, some have reported not even receiving the tshirt, and the web domain has bad feedback from websites like ip-46.com. 
So this bot scans all URLs from r/popular and checks if they redirect to known websites or contain teesmato. If yes then it leaves a comment on the post calling out the scam and posts an archival record to its own subreddit. It is empty right now as it hasnt picked up a scam yet. 


<h2>Main.py</h2>

Background: 

I am hosting a call of duty mw2 server on pc. I set up this discord bot so it posts a random array of maps that users can react emoji to them to vote for the next map they want to play. I had intended on making it automatically update a configuration file on my desktop based on which map won the vote, but I never got around to it. 




<h2>Enlarger.py </h2>

Background: 

My friend likes seeing all kinds of different discord emojis and wants some of them for her own servers so I created this bot that will take the url of the emoji she wants and direcetly links to it so she can save it as an image and upload to her own server. 



<h2>Darts.js</h2>

Background: 

My friend is a live streamer on twitch. I created this darts game in js so viewers can type in !darts in his chat and then it will pop up with a randon number. "$user threw a dart and hit {randomNumber}" from 1/1000. If the rng generates <= 50, it has a chance of hitting a bullseye. If a user hits a bullseye, it grants them a roll on an array of items that they can win. "User hit a bullseye and they received a ZGS." Now the streamer has to meet them in game and give the winner the prize they won. This increases viwer engagement for the streamer resulting in more viewers and a more active chat room. 


<h2>Slots.js</h2>

Background: 

Similar to darts.js, this will "spin" a slot machine. It chooses 3 random emojis and depending on the match it rewards them with a currency that is availble to collect within the chatroom where they can use it to gamble even more or redeem items with. 

 
<h2>Keys.yml</h2>

Background: Ansible book to re generate ssh keys and deploy them to my virtual machines.



<h2>ssh.yml</h2>

Background: Scrub default ssh configs on newly deployed VMs
