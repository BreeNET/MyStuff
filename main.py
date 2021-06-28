import discord
from discord.ext import commands
from discord.ext.commands import has_permissions, MissingPermissions, has_role
import random
import asyncio
from datetime import datetime
from datetime import timedelta

maps = ["Oil Rig","Afghan","Derail","Highrise","Invasion","Karachi","Quarry","Rundown","Scrapyard",
"Skidrow","Sub Base","Terminal","Underpass","Bailout","Crash","Overgrown","Salvage","Storm","Rust",
"Wasteland","Nuketown","Favela","Carnival","Estate","Fuel","Strike","Trailer Park","Vacant",
"Crossfire","Bloc","Cargoship","Killhouse","Bog","Freighter","Firing Range","Chemical Plant","Village"]

modes = ["Free For All", "Team Deathmatch", "Search and Destroy", "Headquarters", "Sabotage", "Domination"]

emoji = ["1\u20E3", "2\u20E3", "3\u20E3", "4\u20E3"]
mapemp = []
modeemp = []
finals = []

bot = commands.Bot(command_prefix="!")

async def MapPolls():
    await bot.wait_until_ready()
    counter = 0
    Mapchannel = bot.get_channel(id=800086126173225010)
    while counter < 1:
        nextDay = (datetime.now()+timedelta(days=1))
        nextDay = nextDay.strftime("%D @ ") + nextDay.strftime("%H:%M")+" MST"
        await Mapchannel.purge()        
        await Mapchannel.send('**New poll! Vote below now for tomorrow\'s 24 hour map!**')
        await Mapchannel.send('**Next poll tomorrow '+nextDay+"**")
        choice = random.sample(maps,4)

        for x in range(0, 4):

            mapemp.append(emoji[x]+" - "+choice[x])

        msg = await Mapchannel.send('\n\n'.join(mapemp))

        for x in range(0,4):

            await msg.add_reaction(emoji[x])
        mapemp.clear()

        await asyncio.sleep(86400)

async def ModePolls():
    await bot.wait_until_ready()
    counter = 0
    Modechannel = bot.get_channel(id=800283123376062474)
    while counter < 1:
        nextDay = (datetime.now()+timedelta(days=1))
        nextDay = nextDay.strftime("%D @ ") + nextDay.strftime("%H:%M")+" MST"        
        await Modechannel.purge()        
        await Modechannel.send('**New poll! Vote below now for tomorrow\'s 24 hour mode!**')
        await Modechannel.send('**Next poll tomorrow '+nextDay+"**")
        choice = random.sample(modes,4)

        for x in range(0, 4):

            modeemp.append(emoji[x]+" - "+choice[x])

        msg = await Modechannel.send('\n\n'.join(modeemp))

        for x in range(0,4):

            await msg.add_reaction(emoji[x])
        modeemp.clear()

        await asyncio.sleep(86400)



    await bot.send_message(Modechannel, "{} is the winner".format(choices[winner]))

@bot.event
async def on_ready():
    print("Ready when you are")
    print("I am running on: " + bot.user.name)
    bot.loop.create_task(MapPolls())
    bot.loop.create_task(ModePolls())


@bot.command()
@has_permissions(administrator=True)
async def playing(ctx,arg,arg2):
    
    await bot.change_presence(activity=discord.Game(name=str(arg+" " + arg2)))
    await ctx.message.delete()

@bot.command()
@commands.has_role("Staff")
async def map(ctx):
    
    await ctx.message.delete()
    channel = bot.get_channel(800086126173225010)
    await channel.purge()        
    await channel.send('**New poll! Vote below now for tomorrow\'s 24 hour map!**')
    choice = random.sample(maps,4)

    for x in range(0, 4):

            mapemp.append(emoji[x]+" - "+choice[x])

    msg = await channel.send('\n\n'.join(mapemp))

    for x in range(0,4):
    
            await msg.add_reaction(emoji[x])
    mapemp.clear()


@bot.command()
@commands.has_role("Staff")
async def mode(ctx):
    
    channel = bot.get_channel(800283123376062474)
    await ctx.message.delete()
    await channel.purge()
    await channel.send('**New poll! Vote below now for tomorrow\'s 24 hour game mode!**')
    choice = random.sample(modes,4)
    for x in range(0, 4):

        modeemp.append(emoji[x]+" - "+choice[x])


    msg = await channel.send('\n\n'.join(modeemp))
    
    for x in range(0,4):

        await msg.add_reaction(emoji[x])
    
    modeemp.clear()

    await asyncio.sleep(60)
    msgid = str(msg.id)

    total_count = 0
    for r in msgid.reactions:
        total_count += r.count

    await channel.send(str(total_count))


bot.run('REDACTED')