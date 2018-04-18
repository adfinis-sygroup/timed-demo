Timed Demo
==========

This is a simplified installation of Timed, our time tracking software.

It is intended for simple demonstration cases, so you can easily get it up and
running to have a quick look. A production installation currently requires some
more work, so if you like it, you should talk to us :)

**NOTE: This is heavily WIP, and desipite it rendering properly, it doesn't work just yet.**

The backend (Django REST) can be found here: https://github.com/adfinis-sygroup/timed-backend

The frontend (Ember.JS) can be found here: https://github.com/adfinis-sygroup/timed-frontend

Entry points
------------

Run the container by executing this on the shell:

    docker run -p 8000 adfinissygroup/timed-demo

Upon startup, the app should be available under http://localhost:8000 which is
also the main application that end users (ie your employees) will use.

Administration is done via Django-Admin, which is located at http://localhost:8000/admin/ 

Users
-----

There currently is a single user defined, with the following credentials:

* Username: admin
* password: admin

When the image is fully up and running, I intend to add some demo content as well, together
with some demo users, projects, tasks, and a company structure.

