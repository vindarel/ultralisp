===========
 ChangeLog
===========

0.14.0 (2020-01-16)
===================

Changes
-------

* Added a full text search among all symbols from all systems known to Ultralisp.org

0.13.0 (2019-09-15)
===================

Fixes
-----

* Upgraded to a Quickdist version 0.16.0 where releases.txt metadata was fixed.

0.12.0 (2019-09-14)
===================

Changes
-------

* Quicklisp upgraded from 2019-05-21 to 2019-08-13.

Fixes
-----

* Upgraded to a new ``quickdist`` library, where issue
  `number 51 <https://github.com/ultralisp/ultralisp/issues/51>`_ was fixed.

  Because of this bug, all systems like ``slynk``, which have their asd files
  in nested subdirectories, were broken.


0.11.0 (2019-07-13)
===================

Changes
-------

* Added a cron task to remove checks processed more than a week ago.
* Now if no asd files were found for the project, it is disabled.
* Start only one worker process in development mode, and don't kill
  it after each task execution. This simplify debugging.
* Added a ``ultralisp/debug`` package and function ``check-project``
  which can be used for checking how project is processed by the pipeline.
  

Fixes
-----

* Fixed a title on a "user's projects" page. This closes issue #54.
* Now asd files are seached in the nested directories too. This closes issue #55,
  but probably some other projects will be broken because their nested asd files
  can't be loaded.


0.10.1 (2019-07-07)
===================

* Moving to a new ``quickdist`` to fix issue with distignoring all asd files.

0.10.0 (2019-07-07)
===================

* Fixed a way how error page is rendered.
* Fixed error in Prometheus handle, caused restarts.

0.9.1 (2019-06-30)
==================

* Function ``get-preparend-version`` was fixed to work with latest Mito.

0.9.0 (2019-06-29)
==================

* Ignoring some system files was supported, but they are hardcoded
  in the ``docker/.distignore`` file. This should allow to add a
  `numcl <https://github.com/numcl/numcl>`_ library.

  Thanks to Nikolai Matiushev for the pull request.

0.8.1 (2019-05-21)
==================

* Fixed error prevented enabling a project after it was disabled.

0.8.0 (2019-05-05)
==================

* Using gearman instead of lfarm, for remote task execution.

0.7.1 (2019-05-05)
==================

* Removed ``(break)`` causing server restarts from time to time.

0.7.0 (2019-05-03)
==================

* Added support for prometheus /metrics handle with basic metrics about SBCL's
  state and Ultralisp's entities.

0.6.0 (2019-04-19)
==================

* Authentication was refactored and now it use GitHub instead of
  codes, sent by email. But this is temprorary and more identity
  providers will be supported in future. To add them, we need to
  extend a ``weblocks-auth`` library.

0.5.4 (2019-03-30)
==================

* Don't require access to private GitHub repositories.

0.5.3 (2019-03-24)
==================

* Added a /sponsors page and a link to a company at Patreon.
  Thanks to Jean-Philippe Paradis for suggestion!

0.5.2 (2019-03-22)
==================

* Added a button for donations.

0.5.1 (2019-03-20)
==================

* Fixed error with renamed ``render-projects-list``.

0.5.0 (2019-03-20)
==================

Changes
-------

* Now disabled project will be checked by cron too. Except those project
  which were disabled manually by user.
* "Leave feedback" url now leads to the
  https://github.com/ultralisp/ultralisp/issues instead of
  https://github.com/ultralisp/ultralisp/issues/new to not require user
  to login into the GitHub. This partially closes issue #33.

Improvements
------------

* Added a helper function ``find-projects-with-conflicting-systems``
  which can be called manually after the import from the Quicklisp to
  detect conflicts in system's names.

  We'll need to automate this in regular checks and disable projects
  which introduce conflicts.
* Added a link to GitHub page on each project's page. This closes issue
  #7.
* Added a red ribbon "Fork me on GitHub" to the front page. This finally
  closes issue #33.
* Added a page with all project of a single author and links like:
  https://ultralisp.org/projects/Hexstream/ should work.
  Also, a title on the project name was modified and now includes a link
  to all projects by the author.

0.4.2 (2019-03-19)
==================

* Show at most 3 changed projects for each version on the landing.
* Fixed a bug with clicking on a newly added project or opening the
  newly added project.

0.4.1 (2019-03-17)
==================

* Fixed deletion of the .git directories.

0.4.0 (2019-03-17)
==================

* Added a function ``ultralisp/import:main`` to import from Quicklisp
  all projects, hosted on the GitHub.
* Fixed the way how errors during project checks are processed. Now a
  project with error will be disabled and check will have a traceback in
  it's ``traceback`` slot.
* Fixed the issue with leaving checked out repositories in the
  ``/tmp/checking`` directory after the repository was checked for
  updates.
* If project was disabled because an error, now you can view a
  traceback.
* Project's page now shows a description.
* Now package-inferred systems are supported.

0.3.2 (2019-02-26)
==================

* Fixed error in a cron which caused enormous number of checks created
  every minute.

0.3.1 (2019-02-08)
==================

* Now GitHub integration requires less permissive permissions.
  Previosly it required read/write access to all repositories, now site
  will have access for writing webhooks and reading your organizations
  list. It will be used to show you public repositories from these organizations.
* Removed loading of spin.js, because it is unnecessary.
* Fixed auto refreshing for GitHub repositories list.

0.3.0 (2019-02-07)
==================

* Added ability to add GitHub project just by URL.

0.2.0 (2019-01-29)
==================

* Now tracked projects are stored in a postgresql database.
* They can be added in few clicks from the GitHub.
* Users can login using their emails only.
* And many other changes.

0.1.7
=====

* Dependencies were updated to switch off Ultralisp dist temporarily and
  use fixed quickdist. Because current Ultralisp distribution is broken.

0.1.6
=====

* Switching to use dist.ultralisp.org for building docker image.
  Previously, some systems were fetched from the GitHub.

0.1.5
=====

* Move to a new ``quickdist`` which writes ``distinfo-template-url``
  into the metadata.

0.1.4
=====

* Fixed a rendering of yandex metrika code.

0.1.3
=====

* Added google analytics and yandex metrika counters support.

0.1.2
=====

* Fixed updating of the /projects/ subdirectory when it does not exists.
* Function `read-metadata` was fixed to ignore absence of the project.txt file and return nil.
