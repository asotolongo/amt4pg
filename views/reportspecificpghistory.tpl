<html>
<title>Reporte de amt4pg:{{db}}</title>
<head>
 <link href="../../bootstrap.css" rel="stylesheet" />
 <link href="../../mod.css" rel="stylesheet" />



  <script src="../../jquery.flot.js" type="text/javascript">   </script>



</head>


<body>
<h1 align="center" ><p> <b>Historial obtenido por amt4pg de {{db}}</b></p></h1>


<p align="center"><b> Fecha y Hora en el servidor:</b> <div id="fechayhora" align="center">  {{datadate[0]}} , {{datatime[0]}} </div>  </p>
<center>

<div> <a href="/pg/{{db}}">  Reporte de {{db}} <a> </div>
<br>
<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Historial del peso:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Database Name</b></td>
 <td ><b>Date</b></td>
 <td><b>Weigth</b></td>
</tr>
%for field in dataweighthistory:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
</tr>
%end
</table>
</div>
<br>


<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Historial de Insertadas:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Database Name</b></td>
 <td ><b>Date</b></td>
 <td><b>Insert Count</b></td>
</tr>
%for field in datainserthistory:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
</tr>
%end
</table>

</div>

<br>

<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Historial de Actualizaciones:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Database Name</b></td>
 <td ><b>Date</b></td>
 <td><b>Update Count</b></td>
</tr>
%for field in dataupdatehistory:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
</tr>
%end
</table>

</div>


<br>

<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Historial de Eliminadas:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Database Name</b></td>
 <td ><b>Date</b></td>
 <td><b>Delete Count</b></td>
</tr>
%for field in datadeletehistory:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
</tr>
%end
</table>

</div>


<br>

<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Historial de Seleccionadas:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Database Name</b></td>
 <td ><b>Date</b></td>
 <td><b>Select Count</b></td>
</tr>
%for field in dataselecthistory:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
</tr>
%end
</table>

</div>



<br>

<div class="panel panel-default" align="center"  >
<div class="panel-heading" align="center"  ><b style="color:#ffffff " >Historial de Conecciones:</b></div>

<table border="1" class="table table-striped"   >
<tr >
 <td ><b>Database Name</b></td>
 <td ><b>Date</b></td>
 <td><b>Conection Count</b></td>
</tr>
%for field in dataconectionthistory:
<tr class="contenido_tabla">
 <td >{{field[0]}}</td>
 <td>{{field[1]}}</td>
 <td>{{field[2]}}</td>
</tr>
%end
</table>

</div>


Autor: Anthony R. Sotolongo Leon (asotolongo@gmail.com)
</center>


</body>
</html>
