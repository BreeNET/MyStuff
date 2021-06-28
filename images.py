import discord
from discord.ext import commands
from discord.ext.commands import has_permissions, MissingPermissions, has_role, Greedy
from discord.utils import get
from typing import Union
import random
import asyncio
import re

from datetime import datetime
from datetime import timedelta
url = 'https://cdn.discordapp.com/emojis/'
bot = commands.Bot(command_prefix="$")
client = discord.Client()

@bot.event
async def on_ready():
    print("Ready when you are")
    print("I am running on: " + bot.user.name)
    await bot.change_presence(activity=discord.Game(name="(ﾉ◕ヮ◕)ﾉ*:･ﾟ✧"))

@bot.command()
async def bigger(ctx, emoji: Union[discord.Emoji, discord.PartialEmoji]):
    await ctx.send(emoji.url)

@bot.command()
async def playing(ctx,arg):
    
    await bot.change_presence(activity=discord.Game(name=arg))
    await ctx.message.delete()

bot.run('REDACTED')