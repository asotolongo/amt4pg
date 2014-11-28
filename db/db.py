try:
    import psycopg2
    import  sys
except ImportError,e:
    print "Error al importar :", str(e)
import  sys
__author__ = 'anthony'


class database(object):
    """class general db"""

    def __init__(self):
        self.connecction
        self.cursor
        self.date
        self.time
        self.version

    def executequery(self, query):
        self.cursor.execute(query)
        self.data = self.cursor.fetchall()
        self.connecction.commit()
        return self.data


    def executupdateequery(self, query):
        self.cursor.execute(query)
        self.data = self.cursor.statusmessage
        self.connecction.commit()
        return self.data

    def disconect(self):
        self.closecursor()
        self.connecction.close()

    def closecursor(self):
        self.cursor.close()


class databasepg(database):
    """class conecction to general PG"""

    def __init__(self,passwd,server="localhost",db="postgres",usr="postgres",port="5432"):
        try:
            self.connecction = psycopg2.connect(host=server,database=db, user=usr, port=port, password=passwd)
            self.cursor = self.connecction.cursor()
        except Exception, e:
            print 'Error al conectarse al servidor: ', str(e)
            sys.exit(1)


    def get_date(self):
        query = "select current_date::text"
        self.date = self.executequery(query)
        return self.date

    def get_time(self):
        query = "select to_char(current_timestamp,'HH24:MI:SS')"
        self.time = self.executequery(query)
        return self.time


    def get_version(self):
        query = "select version()"
        self.version = self.executequery(query)
        return self.version

    def get_tablespace(self):
        query = 'SELECT spcname from  pg_tablespace'
        self.tablespace = self.executequery(query)
        return self.tablespace

    def get_roles(self):
        query = 'SELECT rolname from pg_roles where rolcanlogin=false'
        self.roles = self.executequery(query)
        return self.roles


    def get_users(self):
       query = 'SELECT rolname from pg_roles where rolcanlogin=true'
       self.users = self.executequery(query)
       return self.users

    def get_databases(self):
       query = "select datname from pg_database  where datname not like 'template%'"
       self.databases = self.executequery(query)
       return self.databases

    def get_databases_count(self):
       query = "select count(datname) as cantidad from pg_database  where datname not like 'template%'"
       self.databases_count = self.executequery(query)
       return self.databases_count





class specificdatabasepg(database):
    """class conecction to general especific PG db"""

    def __init__(self,db,passwd,usr="postgres",port="5432"):
        try:
            self.db = db
            self.connecction = psycopg2.connect(database=self.db, user=usr, port=port, password=passwd)
            self.cursor = self.connecction.cursor()
        except Exception, e:
            print 'Error al conectarse al servidor: ', str(e)
            sys.exit(1)


    def get_date(self):
        query = "select current_date::text"
        self.date = self.executequery(query)
        return self.date


    def get_time(self):
        query = "select to_char(current_timestamp,'HH24:MI:SS')"
        self.time = self.executequery(query)

        return self.time


    def get_database_weight(self):
       query = "SELECT distinct datname,round(((pg_database_size(datname)/1024)/1024::numeric),2) ::text||' MB' from pg_database where datname=" + "'" + self.db + "'"
       self.database_weight = self.executequery(query)

       return self.database_weight


    def get_database_view(self):
       query = "SELECT table_schema,table_name  from information_schema.tables  where  table_schema not like 'pg_%' and table_schema<>'information_schema' and table_type='VIEW' "
       self.database_view = self.executequery(query)

       return self.database_view


    def get_database_triggers(self):
       query = "SELECT trigger_schema,trigger_name,event_manipulation,action_timing,event_object_schema,event_object_table from information_schema.triggers "
       self.database_triggers = self.executequery(query)

       return self.database_triggers


    def get_database_indexs(self):
       query = "SELECT idstat.schemaname,idstat.relname AS table_name,indexrelname AS index_name,idstat.idx_scan AS times_used, " \
               " round((pg_relation_size(idstat.indexrelid::regclass)/1024)/1024::numeric,2)::text || ' MB' AS index_size " \
               " FROM pg_stat_user_indexes AS idstat  JOIN pg_stat_user_tables AS tabstat ON idstat.relname = tabstat.relname  ORDER BY 4 desc;"
       self.database_indexs = self.executequery(query)

       return self.database_indexs


    def get_database_data_tables(self):
       query = " SELECT ns.nspname||'.'|| pg.relname as name , reltuples::int ,round((pg_relation_size(psat.relid::regclass)/1024)/1024::numeric,2)::text || ' MB' as Weigth, " \
               " psat.seq_scan,n_dead_tup, autovacuum_count,COALESCE( to_char(last_autovacuum,'YYYY:MM:DD-HH24:MI:SS'),'-'),vacuum_count,COALESCE(to_char(last_vacuum,'YYYY:MM:DD-HH24:MI:SS'),'-' ) " \
               " FROM pg_class pg JOIN pg_stat_all_tables psat ON (pg.relname = psat.relname) " \
               " join pg_namespace a on ( pg.relnamespace = a.oid)  join pg_namespace ns  on (pg.relnamespace = ns.oid)  where a.nspname <> 'pg_catalog' " \
               " and a.nspname <> 'information_schema' and a.nspname <> 'pg_toast'  ORDER BY 2 DESC ;"
       self.database_data_tables = self.executequery(query)

       return self.database_data_tables


    def get_database_activity(self):
       query = "select usename, state, query from pg_stat_activity  where datname=current_database()"
       self.database_activity = self.executequery(query)

       return self.database_activity

    def get_database_weigth_history(self,db):
       query = "select db,date::date, max(value) from log_values  where metric = 'Weigth' and db = %s group by 1,2 order by 1,2" % ("'" + str(db) + "'")
       database_weigth_activity = self.executequery(query)

       return database_weigth_activity


    def get_database_activity_history(self,db,activity):
       query = "select db,date::date, max(value) from log_values  where metric = %s and db = %s group by 1,2 order by 1,2" % ("'" + str(activity) + "'" , "'" + str(db) + "'")
       database_activity_history = self.executequery(query)

       return database_activity_history



