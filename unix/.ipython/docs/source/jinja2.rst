Jinja2
======
I realized that taking notes in ``*.py`` files sounds like a good
idea superficially but it doesn't take long to get anoyed by the format.

Taking python notes in rst will be good practice!

Plus now I can ensure this works!
    *Your after the fact...I guess epilogue? Idk.*
    *It only works if your conf.py specifically loads up sphinx extensions it also added to it's path.*
    *That possibly means it's a good idea to create a global conf.py and make a script that sources that.*

.. ipython::

   In [3]: from jinja2 import Template
   In [4]: t = Template
   Out[4]: jinja2.environment.Template
   In [5]: t = Template("Hello {{something}}")
   Out[5]: <Template memory:7c981e95c0>
   In [7]: t.render(something="World!")
   Out[7]: 'Hello World!'

Come to think of it I don't know why I didn't start doing this earlier!

January 29, 2019:

.. ipython::

   In [15]: from jinja2 import Template
   In [16]: t = Template("My favorite numbers: {% for n in range(1,10) %}{{n}} " "{% endfor %}")
   Out[16]: <Template memory:7fc729f55c50>[ins]
   In [17]: t.render()
   Out[17]: 'My favorite numbers: 1 2 3 4 5 6 7 8 9 '

Feb 08, 2019:

The above code came from:

:URL: https://realpython.com/primer-on-jinja-templating/

Let's take notes on this guy.

.. no idea if the below is a real directive.

:

   For example, Jinja templates use {% ... %} for expressions or logic (like
   for loops), while {{ ... }} is used for outputting the results of an
   expression or a variable to the end user. The latter tag, when rendered, is
   replaced with a value or values, and is seen by the end user.


Sphinx on Jinja Templating
--------------------------
Here's some info I got from an rst file I just made into HTML.

http://localhost:8888/files/build/html/sphinx-templating.html#jinja-sphinx-templating-primer

The most important idea about Jinja from Sphinx?:

    The most important concept in Jinja is template inheritance, which means
    that you can overwrite only specific
    blocks within a template, customizing it while also keeping the changes at
    a minimum.


.. raw:: html

    <p>For example, to add a new link to the template area containing related links all
    you have to do is to add a new template called
    <code class=""docutils literal notranslate"><span class=""pre">layout.html</p>span></Template>code>
    with the following contents:
    </Template>p>""</p>


.. code-block:: html+jinja

    {%  extends "!layout.html" %}
    {% block rootrellink %}
        <li><a href="https://project.invalid/">Project Homepage</li>a> &raquo;</li>
        {{  super() }}
    {% endblock %} }}"</li> %}

Cool.
