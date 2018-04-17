FROM alpine:3.7

RUN apk add --no-cache \
	git \
	python3 python3-dev \
	libldap py3-pyldap

RUN mkdir /app

WORKDIR /app

RUN git clone https://github.com/adfinis-sygroup/timed-backend
RUN git clone https://github.com/adfinis-sygroup/timed-frontend

# PostgreSQL is not required in our setup
RUN sed -e 's/psycopg2.*//'         -i /app/timed-backend/requirements.txt
RUN sed -e 's/django-auth-ldap.*//' -i /app/timed-backend/requirements.txt

RUN pip3 install django-auth-ldap==1.2.11

RUN apk add --no-cache libxml2-dev libxml2-utils
RUN apk add --no-cache py3-lxml

RUN pip3 install -r /app/timed-backend/requirements.txt


RUN cp /app/timed-backend/timed/settings.py /app/timed-backend/timed/settings_base.py

# Set some "required" env vars, so we don't have to mess too much
# with the settings file
ENV DJANGO_DATABASE_PASSWORD='' 
ENV DJANGO_SECRET_KEY='muchsecret'
ENV DJANGO_ALLOWED_HOSTS='*'
ENV DJANGO_HOST_PROTOCOL=http
ENV DJANGO_HOST_DOMAIN='*'
ENV DJANGO_DEFAULT_FROM_EMAIL=timed@example.org
ENV DJANGO_SERVER_EMAIL=timed@example.org

COPY settings.py /app/timed-backend/timed/settings.py

RUN python3 /app/timed-backend/manage.py migrate

RUN python3 /app/timed-backend/manage.py shell -c 'from timed.employment.models import User; u = User(); u.username = "admin"; u.set_password("admin"); u.is_superuser=True; u.is_staff = True; u.save()'

EXPOSE 8000

ENTRYPOINT python3 /app/timed-backend/manage.py runserver  0.0.0.0:8000
