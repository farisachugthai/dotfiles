#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" Create a logfile for the day and append to it if one already exists.

2018-09-02

This file has been in this repo for so long I feel like I forgot about it.

This is so oddly written but from long enough ago that I'm not even surprised.

TODO:
    If you want, use datetime instead.
    Import join in a more sensible manner.
    Clean this namespace up you have notnew declared everytime you open a shelll!
        - So would i need to use those vars locally in some function?
"""

from os import path
import time

from IPython import get_ipython

ip = get_ipython()


def create_logging_file():
    """ Admittedly no reason this is a function except that I want to clean up
    the namespace I get when I start IPython.
    """
    ldir = ip.profile_dir.log_dir
    fname = 'log-' + ip.profile + '-' + time.strftime('%Y-%m-%d') + ".py"
    filename = path.join(ldir, fname)
    notnew = path.exists(filename)

    try:
        ip.magic('logstart -to %s append' % filename)
        #added -t to get timestamps
        if notnew:
            ip.logger.log_write(u"# =================================\n")
        else:
            ip.logger.log_write(u"#!/usr/bin/env python\n")
            ip.logger.log_write(u"# " + fname + "\n")
            ip.logger.log_write(u"# IPython automatic logging file\n" )
            ip.logger.log_write(u"# " + time.strftime('%H:%M:%S') + "\n" )
            ip.logger.log_write(u"# =================================\n" )
            print(" Logging to "+filename)
    except RuntimeError:
        print (" Already logging to "+ip.logger.logfname)


if __name__ == "__main__":
    create_logging_file()
