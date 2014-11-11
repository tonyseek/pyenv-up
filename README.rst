pyenv-up
========

|License Badge| |Version Badge| |Build Status|

Startup pyenv_ and virtualenv_ through ``pyenv up``.


Screencast
----------

.. image:: http://tonyseek.github.io/media/pyenv-up-screencast.gif


Installation
------------

You can install it as a pyenv plugin.

1. Check out pyenv-up into the plugin directory::

   $ git clone https://github.com/tonyseek/pyenv-up.git $PYENV_ROOT/plugins/pyenv-up

2. Create a empty directory to contain the collection of virtualenvs::

   $ mkdir $PYENV_ROOT/virtualenvs


Usage
-----

1. Check the runtime description files into your VCS::

   $ cd path/to/project
   $ echo '2.7.8' > .python-version  # or pyenv local 2.7.8
   $ echo 'project-name' > .python-virtualenv
   $ git add .python-version .python-virtualenv
   $ git commit

2. Say "up" now::

   $ pyenv up

In first time you may be asked to create a virtualenv and install dependencies
in it if the ``requirements*.txt`` files exists. After that, a new shell will
be opened. You can work in that and exit with ``Ctrl - D`` simply in the end.


Principle
---------

The ``pyenv up`` will do following actions in the new opening shell:

- Checking the ``$PYENV_ROOT/virtualenvs`` directory and creating the
  project-specific virtualenv in first time. The virtualenv's name is from
  ``.python-virtualenv`` and the Python version is decided by
  ``pyenv version-name`` (the current version).
- Activating the project-specific virtualenv.
- Reading the foreman style ``.env`` file and import it.
- Asking user for installing dependencies from ``requirements*.txt`` if the
  virtualenv is empty.

There is not necessary to type ``. venv/bin/activate``, ``foreman run`` and
``deactivate`` anymore.


Issues
------

If you want to report bugs or request features, please create issues on
`GitHub Issues`_.


Contribution
------------

Welcome to contribute to this project with `GitHub Pull Requests`_.


.. _pyenv: https://github.com/yyuu/pyenv
.. _virtualenv: https://virtualenv.readthedocs.org
.. _GitHub Issues: https://github.com/tonyseek/pyenv-up/issues
.. _GitHub Pull Requests: https://github.com/tonyseek/pyenv-up/pulls

.. |License Badge| image:: https://img.shields.io/badge/license-MIT-orange.svg?style=flat
   :target: LICENSE
   :alt: License - MIT
.. |Version Badge| image:: https://img.shields.io/badge/version-0.1.0.beta-yellow.svg?style=flat
   :alt: Current Version is 0.1.0.beta
.. |Build Status| image:: https://img.shields.io/travis/tonyseek/pyenv-up.svg?style=flat
   :target: https://travis-ci.org/tonyseek/pyenv-up
   :alt: Travis CI
