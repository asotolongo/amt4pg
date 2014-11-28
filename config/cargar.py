__author__ = 'anthony'

from xml.etree import ElementTree
from db.db import databasepg

archivo = open('config/amt4pg.conf.xml', 'rt')
arbol = ElementTree.parse(archivo)
servidor = arbol.find('./server').text
basedatos =  arbol.find('./db').text
puerto =  arbol.find('./port').text
usuario = arbol.find('./user').text
contrasena = arbol.find('./passwd').text
tiempo = arbol.find('./time').text

pg = databasepg(contrasena,servidor,basedatos,usuario,puerto)
