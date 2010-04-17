Los Ojos de la Ciudad
======================

Proyecto para AbreDatos.es

BD
=====================

    mysql> create database ojosciudad_test;
    Query OK, 1 row affected (0.06 sec)

    mysql> grant all privileges on ojosciudad.* to ojosciudad@localhost identified by 'ojosciudad';
    Query OK, 0 rows affected (0.61 sec)

    mysql> create database ojosciudad_development;
    Query OK, 1 row affected (0.00 sec)

    mysql> grant all privileges on ojosciudad_development.* to ojosciudad@localhost identified by 'ojosciudad';
    Query OK, 0 rows affected (0.00 sec)

    mysql> create database ojosciudad;
    Query OK, 1 row affected (0.06 sec)

    mysql> grant all privileges on ojosciudad_test.* to ojosciudad@localhost identified by 'ojosciudad';
    Query OK, 0 rows affected (0.00 sec)
