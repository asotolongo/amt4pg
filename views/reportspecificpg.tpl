<html>
<title>Reporte de amt4pg para:{{db}}</title>
<head>
 <link href="../bootstrap.css" rel="stylesheet" />
 <link href="../mod.css" rel="stylesheet" />
</head>


<body>
<h1 align="center" ><p> <b>amt4pg</b></p></h1>
<h2 align="center" ><p> <b>Reporte para  {{db}}</b></p></h2>


<p align="center"><b>Fecha y Hora en el servidor:</b> <div id="fechayhora" align="center">  {{datadate[0]}} , {{datatime[0]}} </div>  </p>
<center>
<div> <a href="/pg">Reporte General<a> </div>
<div> <a href="/pg/{{db}}/history" target="_blank">Historial<a> </div>
<br>
<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Bases de datos/Peso:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Nombre</b></td>
 <td><b>Peso</b></td>
</tr>
%for field in dataweight:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
</tr>
%end
</table>

</div>

<br>

<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Commits/Rollbacks:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Commit</b></td>
 <td><b>Rollback</b></td>
</tr>
%for field in data_commit_rollback:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
</tr>
%end
</table>

</div>

<br>






<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " > Tablas:</b></div>

<table border="1" class="table table-striped">
<tr>
  <td><b>Nombre</b></td>
 <td><b>Tuplas</b></td>
 <td><b>Peso</b></td>
 <td><b>Escaneo Seq.</b></td>
 <td><b>Tup. Obt. Seq.</b></td>
 <td><b>Escaneo Ind.</b></td>
 <td><b>Tup. Obt. Ind.</b></td>
 <td><b>Tup. Ins.</b></td>
 <td><b>Tup. Elm.</b></td>
 <td><b>Tup. Act.</b></td>
</tr>
%for field in datatablestatics:
<tr class="contenido_tabla">
 <td>{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
 <td>{{field[3]}}</td>
 <td>{{field[4]}}</td>
 <td>{{field[5]}}</td>
 <td>{{field[6]}}</td>
 <td>{{field[7]}}</td>
 <td>{{field[8]}}</td>
 <td>{{field[9]}}</td>
</tr>
%end
</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " > Mantenimiento:</b></div>

<table border="1" class="table table-striped">
<tr>
  <td><b>Nombre</b></td>
 <td><b>Tup. Muertas</b></td>
 <td><b>Cant. AutoVaccum</b></td>
 <td><b>Ult. AutoVaccum</b></td>
 <td><b>Cant. Vaccum</b></td>
 <td><b>Ult. Vaccum</b></td>
 <td><b>Cant. Analyze</b></td>
 <td><b>Ult. Analyze</b></td>
 <td><b>Cant. AutoAnalyze</b></td>
 <td><b>Ult. AutoAnalyze</b></td>
</tr>
%for field in datatablesmant:
<tr class="contenido_tabla">
 <td>{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
 <td>{{field[3]}}</td>
 <td>{{field[4]}}</td>
 <td>{{field[5]}}</td>
 <td>{{field[6]}}</td>
 <td>{{field[7]}}</td>
 <td>{{field[8]}}</td>
 <td>{{field[9]}}</td>
</tr>
%end
</table>
</div>
<br>

<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff "  > Índices:</b></div>

<table border="1"  class="table table-striped">
<tr>
 <td><b>Esquema</b></td>
 <td><b>Tabla</b></td>
 <td><b>Nombre</b></td>
 <td><b>Veces Usado</b></td>
 <td><b>Tup. Obtenidas</b></td>
 <td><b>Peso Índice</b></td>
</tr>
%for field in dataindexs:

<tr class="contenido_tabla">
 <td>{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
 <td>{{field[3]}}</td>
 <td>{{field[4]}}</td>
 <td>{{field[5]}}</td>
</tr>
%end
</table>
</div>
<br>

<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " > Actividad:</b></div>

<table border="1"  class="table table-striped">
<tr>
 <td><b>Usuario</b></td>
 <td><b>Estado</b></td>
 <td><b>Consulta</b></td>
 </tr>
%for field in dataactivity:

<tr class="contenido_tabla">
 <td>{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>


</tr>
%end
</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff "  > Vistas:</b></div>

<table border="1" class="table table-striped">
<tr>
 <td><b>Esquema<b></td>
 <td><b>Nombre<b></td>
</tr>
%for field in dataviews:
<tr class="contenido_tabla">
 <td>{{field[0]}}</td>
 <td>{{field[1]}}</td>
</tr>
%end
</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff "  > Triggers:</b></div>

<table border="1" class="table table-striped">
<tr>
 <td><b>Esquema</b></td>
 <td><b>Nombre</b></td>
 <td><b>Evento</b></td>
 <td><b>Momento</b></td>
 <td><b>Esq. Tabla</b></td>
 <td><b>Tabla</b></td>
</tr>
%for field in datatriggers:

<tr class="contenido_tabla">
 <td>{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
 <td>{{field[3]}}</td>
 <td>{{field[4]}}</td>
 <td>{{field[5]}}</td>
</tr>
%end
</table>
</div>
<br>

Autor: Anthony R. Sotolongo Leon (asotolongo@gmail.com)
</center>


</body>
</html>
