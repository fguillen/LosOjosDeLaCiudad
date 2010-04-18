Los Ojos de la Ciudad
======================

Proyecto para AbreDatos.es

BD
=====================
    mysql>
    
    create database ojosciudad_test DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
    create database ojosciudad_development DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
    create database ojosciudad DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
    grant all privileges on ojosciudad_test.* to ojosciudad@localhost identified by 'ojosciudad';
    grant all privileges on ojosciudad_development.* to ojosciudad@localhost identified by 'ojosciudad';
    grant all privileges on ojosciudad.* to ojosciudad@localhost identified by 'ojosciudad';


Tasks
======================
    rake city_eyes:csv_generation
    rake city_eyes:csv_digest  
    rake city_eyes:dustpan
    
    
Grettings
==================
  Camera icon from: http://www.iconspedia.com/icon/camera-13-15.html

    

