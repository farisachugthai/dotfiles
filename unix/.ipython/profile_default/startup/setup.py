"""Setup IPython initialization files as it's own package.

Install gruvbox as a colorscheme in pygments, and we'll
also probably need to add the IPython doctest plugin somewhere.
"""
from setuptools import setup, find_packages

setup(name='gruvbox-pygments',
      description='Pygments style using the gruvbox color scheme.',
      packages=find_packages(),
      entry_points="""
                   [pygments.styles]
                   gruvbox = gruvbox.style:GruvboxStyle
                   """)
