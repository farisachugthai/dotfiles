#!/usr/bin/env python3
# Maintainer: Faris Chugthai

# this script should be called with
# ipython termux-urls.ipy $@

# TODO:
# 1. Assume that the youtubedl scriptb functions. Then double chsck we werent given a file
# ytdl knows how to handle. if not, then scrape with bs4. possibly extend to
# writing prettified json (as in json.dumps("",tab=4)) to a file.

import requests
import youtube_dl
import sys
import urllib

link = sys.argv[1]
link_parser = urllib.parse.urlparse(link)


# possibly makes sense to make this a class. playlists are a subclass, objects with variable sizes are others etc...
def ytdl(link):
    ydl_opts = {
        'format': 'bestaudio/best',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'output': 'TODO:'
    }
    ydl = youtube_dl.YoutubeDL(ydl_opts)
    ydl.download(link)


# should also check that the beginning of the link is youtu.be
if link_parser[2] == "/playlist":
    print("This seems like a YouTube playlist. Downloading. Press Ctrl-C to stop")
elif link_parser[1] == "youtu.be":
    print(
    ytdl(link)
else:
    source = requests.get(link)
    source.raise_for_status()
    # might not need bs4 if all im doing is downloading.
    # could analyze at a later point
    # soup = BeautifulSoup(source, "html.parser")

    # should figure out how to parse the title of the page and save it
    # as the filename
    # should also choose a different file path then 'wherever we run this'
    file = "web_page.txt"  # fix hard coded nonsense
    with open(file, mode="ab") as f:
        for chunk in source.iter_content(100000):
            f.append(chunk)
        f.close

    print(f.closed)
