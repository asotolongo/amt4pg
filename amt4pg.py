__author__ = 'anthony'


try:
    from bottle import  route, run, template, static_file, error, Bottle
    from db.db import  specificdatabasepg
    from config.cargar import pg,contrasena,usuario,puerto,tiempo,servidor
    import psutil
except ImportError,e:
    print "Error al importar :", str(e)

amt4pg = Bottle()


### coneccion global a PG



#### veersion de amt4pg
@amt4pg.route('/version')
def version():
    return '<html> <h1> amt4pg Version 0.9  !!!</h1> </html>'


#### CSS
@amt4pg.route('/<nombrecss:re:.*.css>')
def serve_static(nombrecss):
    return static_file(nombrecss, root='css/')



#### JS
@amt4pg.route('/<nombrejs:re:.*.js>')
def serve_static(nombrejs):
    return static_file(nombrejs, root='js/')

#### gif
@amt4pg.route('/<nombregif:re:.*.gif>')
def serve_static(nombregif):
    return static_file(nombregif, root='images/')


#### gif
@amt4pg.route('/<nombreico:re:.*.ico>')
def serve_static(nombreico):
    return static_file(nombreico, root='images/')




####  general reports for PG

@amt4pg.route('/')
@amt4pg.route('/pg')
def generalreportpg():


    datadate = pg.get_date()
    datatime = pg.get_time()
    dataversion = pg.get_version()
    datatablespace = pg.get_tablespace()
    datagroup = pg.get_roles()
    datauser = pg.get_users()
    datadatabase = pg.get_databases()
    datacount = pg.get_databases_count()
    refreshtime = tiempo


    return template('reportpg.tpl', datadate=datadate[0], datatime=datatime[0], dataversion=dataversion[0],
                     datatablespace=datatablespace, datagroup=datagroup,
                    datauser=datauser,datadatabase=datadatabase,datacount=datacount[0],refreshtime=refreshtime)


####  reports for specific PG db

@amt4pg.route('/pg/<db>')
def specificreportpg(db):
    # if comming bootstrap.ccs like db
    if db == "bootstrap.css":
        return None

    databasespecificpg = specificdatabasepg(str(db),contrasena ,usuario,puerto,servidor)

    datadate = databasespecificpg.get_date()
    datatime = databasespecificpg.get_time()
    dataweight = databasespecificpg.get_database_weight()
    dataviews = databasespecificpg.get_database_view()
    datatriggers = databasespecificpg.get_database_triggers()
    dataindexs = databasespecificpg.get_database_indexs()
    datatablestatics = databasespecificpg.get_database_data_tables()
    datatablesmant = databasespecificpg.get_database_data_tables_mant()
    data_commit_rollback = databasespecificpg.get_database_data_commit_rollback()
    dataactivity = databasespecificpg.get_database_activity()

    databasespecificpg.disconect()

    return template('reportspecificpg.tpl', db=db, datadate=datadate[0], datatime=datatime[0], dataweight=dataweight,
                     dataviews=dataviews,  datatriggers=datatriggers, dataindexs=dataindexs,
                     datatablestatics=datatablestatics,datatablesmant=datatablesmant,data_commit_rollback=data_commit_rollback,dataactivity=dataactivity)


####  reports for history of specific PG db

@amt4pg.route('/pg/<db>/history')
def specificreportpg(db):
    # if comming bootstrap.ccs like db
    if db == "bootstrap.css":
        return None

    databasespecificpg = specificdatabasepg('_amt4pg',contrasena ,usuario,puerto,servidor)

    datadate = databasespecificpg.get_date()
    datatime = databasespecificpg.get_time()
    dataweighthistory = databasespecificpg.get_database_activity_history(db,'Weigth')
    datainserthistory = databasespecificpg.get_database_activity_history(db,'Insert')
    dataupdatehistory = databasespecificpg.get_database_activity_history(db,'Update')
    datadeletehistory = databasespecificpg.get_database_activity_history(db,'Delete')
    dataselecthistory = databasespecificpg.get_database_activity_history(db,'Select')
    dataconectionthistory = databasespecificpg.get_database_activity_history(db,'Conection')

    databasespecificpg.disconect()

    return template('reportspecificpghistory.tpl', db=db,datadate=datadate[0], datatime=datatime[0],dataweighthistory=dataweighthistory,
                    datainserthistory=datainserthistory,dataupdatehistory=dataupdatehistory,datadeletehistory=datadeletehistory,
                    dataselecthistory=dataselecthistory,dataconectionthistory=dataconectionthistory)



#### LLAMADAS AJAX

@amt4pg.route('/ajaxpeso', method='GET')
def llamadaajaxpeso():
    datosbd = pg.executequery(
        "SELECT distinct datname,round(((pg_database_size(datname)/1024)/1024::numeric),2)::real  from pg_database where datname not like 'template%'  ")
    for values in datosbd:
       query = "insert into log_values values (%s,'Weigth', now(),%d)" % ("'" + values[0] + "'", values[1])
       pg.executupdateequery(query)

    return  dict(datosbd)

@amt4pg.route('/ajaxdatosinsert', method='GET')
def llamadaajaxdatosinsert():
    datosbd = pg.executequery(
        "select datname, tup_inserted from pg_stat_database where datname not like 'template%' and tup_inserted<>0 ")
    for values in datosbd:
       query = "insert into log_values values (%s,'Insert', now(),%d)" % ("'" + values[0] + "'", values[1])
       pg.executupdateequery(query)

    return  dict(datosbd)

@amt4pg.route('/ajaxdatosupdate', method='GET')
def llamadaajaxdatosupdate():
    datosbd = pg.executequery(
        "select datname, tup_updated from pg_stat_database where datname not like 'template%' and tup_updated<>0 ")
    for values in datosbd:
        query = "insert into log_values values (%s,'Update', now(),%d)" % ("'" + values[0] + "'", values[1])
        pg.executupdateequery(query)

    return  dict(datosbd)


@amt4pg.route('/ajaxdatosdelete', method='GET')
def llamadaajaxdatosupdate():
    datosbd = pg.executequery(
        "select datname, tup_deleted from pg_stat_database where datname not like 'template%' and tup_deleted<>0")
    for values in datosbd:
        query = "insert into log_values values (%s,'Delete', now(),%d)" % ("'" + values[0] + "'", values[1])
        pg.executupdateequery(query)

    return  dict(datosbd)

@amt4pg.route('/ajaxdatosselect', method='GET')
def llamadaajaxdatosupdate():
    datosbd = pg.executequery(
        "select datname,tup_returned from pg_stat_database where datname not like 'template%' and tup_fetched<>0")
    for values in datosbd:
        query = "insert into log_values values (%s,'Select', now(),%d)" % ("'" + values[0] + "'", values[1])
        pg.executupdateequery(query)

    return  dict(datosbd)

@amt4pg.route('/ajaxdatosconeccion', method='GET')
def llamadaajaxdatosconeccion():
    datosbd = pg.executequery(
        "select datname,numbackends from pg_stat_database where datname not like 'template%' and numbackends<>0 ")
    for values in datosbd:
        query = "insert into log_values values (%s,'Conection', now(),%d)" % ("'" + values[0] + "'", values[1])
        pg.executupdateequery(query)

    var = dict(datosbd)
    var[""] = 0.0001

    return var



@amt4pg.route('/ajaxdatosfechahora', method='GET')
def llamadaajaxdatosfechahora():
    datosbd = pg.executequery(
        "select 'fecha y Hora',current_date::text||' , '||to_char(current_timestamp,'HH24:MI:SS')")

    return  dict(datosbd)


@amt4pg.route('/ajaxdatosusorecursos', method='GET')
def llamadaajaxdatosmemoria():
    datosbd = pg.executequery("select text,value from get_resource()")

    return  dict(datosbd)

@amt4pg.route('/ajaxdatosrecursos', method='GET')
def llamadaajaxdatoscpu():
    valores = psutil.virtual_memory()
    datosbd = {}
    datosbd['Total de CPU'] = 100
    datosbd['Uso de CPU'] = psutil.cpu_percent(interval=1)
    datosbd['Total de  Memoria'] = (valores.total/1024)/1024
    datosbd['Uso de Memoria'] = (valores.used/1024)/1024

    return  datosbd

#### errors
@amt4pg.error(500)
def error500(error):
    return '<html> <h1>Error 500 en el servidor, chequee el log de bootle !!!</h1> </html>'


@amt4pg.error(404)
def error404(error):
    return '<html> <h1> Upsss Error 404, pagina no encontrada !!!</h1> </html>'







run(app=amt4pg,host='localhost', port=8989)

