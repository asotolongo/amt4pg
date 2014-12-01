CREATE EXTENSION plpythonu;

CREATE TABLE log_values
(
  db character varying,
  metric character varying,
  date timestamp without time zone,
  value bigint
);

CREATE TYPE resource AS
   (text text,
    value double precision);



CREATE OR REPLACE FUNCTION get_resource()
  RETURNS SETOF resource AS
$BODY$
import psutil
values_memory = psutil.virtual_memory()
value_cpu = psutil.cpu_percent(interval=1)
mem_total = round((values_memory.total/1024)/1024)
mem_used =  round((values_memory.used/1024)/1024)
return(['Total de  Memoria',mem_total],['Uso de Memoria',mem_used],['Total de CPU',100],['Uso de CPU',value_cpu])
$BODY$
  LANGUAGE plpythonu VOLATILE;
