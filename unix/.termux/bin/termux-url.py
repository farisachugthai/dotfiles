#!/usr/bin/env python3
# Maintainer: Faris Chugthai
"""Download a video from YouTube using youtube_dl.

Dec 22, 2018:

    .. note::

        If you initialize with no args, then use :meth:`extract_info` with
        the URL as an arg, you get to see everything you'd need to know
        about the metadata in all the varying formats you'd want use.

..usage::

    This script should be called with:: shell

        python termux-urls.py $@

.. todo:

    1. Assume that the youtube_dl script functions.
    2. Then double chsck we weren't given a file ytdl knows how to handle.
    3. If we were, then scrape with bs4.
        - Possibly extend to writing prettified json
        (as in json.dumps("",tab=4)) to a file.


"""
import logging
import sys

try:
    import requests
except ImportError:
    logging.warning("This script xepends on the requests module. Falling back to urllib.")
    import urllib

import youtube_dl


def ytdl(link):
    """Execute downloading a YouTube video.

    Possibly makes sense to make this a class. Playlists are a subclass,
    objects with variable sizes are others etc.

    :param link: URL to a YouTube video
    :returns: Request object or :class:`urllib.Response` if
              :mod:`requests` isn't downloaded.
    """
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


if __name__ == "__main__":

    link = sys.argv[1]
    link_parser = urllib.parse.urlparse(link)

    if link_parser[2] == "/playlist":
        logging.debug("This seems like a YouTube playlist. Downloading. Press Ctrl-C to stop")

    elif link_parser[1] == "youtu.be":
        print(ytdl(link))

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
