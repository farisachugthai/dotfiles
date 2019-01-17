#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""Create a logfile for the day and append to it if one already exists.

Collects both the input and output of every command run through the ipython
interpreter and prepends a timestamp to commands.

The timestamp is particularly convenient for concurrent instances of IPy.

TODO:

    - Consider using datetime instead of time. Not pertinent though.
    - Explore both the built-in logging module and IPython logging subclass.
    - Truncate output if it exceeds a certain threshold.
        - Run dir(np) or dir(pd) a couple of times and the logs become
        swamped.

.. note::

    For further reading, feel free to see the output of any of the
    following::

        >>> from IPython.core.interactiveshell import InteractiveShell
        >>> help(InteractiveShell)

    Which features descriptions of :funcs: relevant to startup such as
    ``register_magic_function()`` and literally every option available
    through
    the %config magic.

    For commands that are more related to the interactive aspect of the
    shell,
    see the following::

        >>> from IPython import get_ipython()
        >>> ip = get_ipython()
        >>> help(ip)
        >>> dir(ip)

    In addition, there's an abundance of documentation online in the form of
    rst docs and ipynb notebooks.
"""
from __future__ import print_function

from os import path
import time

from IPython import get_ipython


def session_logger(ip):
    """Log all input and output for an IPython session.

    Saves the commands as valid IPython code. Note that this is not necessarily
    valid python code.

    The commands are appended to a file in the directory of the profile in
    $IPYTHONDIR or fallback ~/.ipython. This file is named based on the date.

    Parameters
    -----------
    :param ip: Global instance of the IPython shell
    :type: InteractiveShell

    Returns
    --------
    None
    """
    ldir = ip.profile_dir.log_dir
    fname = 'log-' + ip.profile + '-' + time.strftime('%Y-%m-%d') + ".py"
    filename = path.join(ldir, fname)
    notnew = path.exists(filename)

    try:
        ip.magic('logstart -to %s append' % filename)
        # added -t to get timestamps
        if notnew:
            ip.logger.log_write(u"# =================================\n")
        else:
            ip.logger.log_write(u"#!/usr/bin/env python\n")
            ip.logger.log_write(u"# " + fname + "\n")
            ip.logger.log_write(u"# IPython automatic logging file\n")
            ip.logger.log_write(u"# " + time.strftime('%H:%M:%S') + "\n")
            ip.logger.log_write(u"# =================================\n")
            print(" Logging to "+filename)
    except RuntimeError:
        print(" Already logging to "+ip.logger.logfname)


if __name__ == "__main__":
    ip = get_ipython()
    session_logger(ip)
