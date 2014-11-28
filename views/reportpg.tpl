<html>
<title>Reporte de amt4pg</title>
<head>
 <link href="bootstrap.css" rel="stylesheet" />
  <link href="mod.css" rel="stylesheet" />
<link rel="icon" href="favicon.ico">


  <script src="jquery-2.0.0.min.js" type="text/javascript">   </script>
  <script src="jquery.flot.js" type="text/javascript">   </script>
  <script src="jquery.flot.pie.js" type="text/javascript">   </script>

<script>
$(document).ready(function(){
   llamada_ajax();

});

</script>


<script>
        var tiempo = {{refreshtime}};
       //funcion de la llamada ajax para dibujar los graficos

        function llamada_ajax(){
        // mostrando el cartel de cargando datos
        $("#cargandobarra").css("display", "inline");
        $("#cargando").css("display", "inline");
        $("#cargando2").css("display", "inline");
        $("#cargando3").css("display", "inline");
        $("#cargando4").css("display", "inline");
        $("#cargando5").css("display", "inline");
        $("#cargando6").css("display", "inline");


         //variable local datos pie para que se actualice el pie en cada llamada
        var datosbar1=[];
        var datosbar2=[];
        var datospie1=[];
        var datospie2=[];
        var datospie3=[];
        var datospie4=[];
        var datospie5=[];
        var datospie6=[];

        //variable para guardar el html de los datos de las BD
        var tabla="<table  border='1' class='table table-striped'> <tr><td><b>Base de datos</b></td><td><b>Conecciones</b></td> <td><b>Tuplas obtenidas</b></td><td><b>Tuplas insertadas</b></td><td><b>Tuplas actualizadas</b></td><td><b>Tupla Eliminadas</b></td></tr>";


        //llamada ajax para uso de recursos
        $.ajax({
          url: "/ajaxdatosusorecursos",
          type: 'GET',
          datatype:"json",
          success: function(resultado) {
              $.each(resultado, function(index, value){

                                  if (index.indexOf('Memoria')!=-1){
                                  datosbar1.push({label:index ,data:[[1, value]]} );
                                  }
                                  else {
                                  datosbar2.push({label:index ,data:[[1, value]]} );
                                  }


                                });

              $("#cargandobarra").css("display", "none");
              //dibujar el grafico de barras del uso de recursos
               dibuja_grafico_barra(datosbar1,"#bar1") ;
               dibuja_grafico_barra(datosbar2,"#bar2") ;

          },
          error: function() {
            $("#bar1").html('Error al conectar con el servidor !!!');
            $("#bar2").html('Error al conectar con el servidor !!!');

          }
        });


        //llamada ajax para peso de las BD
        $.ajax({
          url: "/ajaxpeso",
          type: 'GET',
          datatype:"json",
          success: function(resultado) {
              $.each(resultado, function(index, value){

                                  datospie1.push({label:index ,data:value});
                                });

              $("#cargando").css("display", "none");
              dibuja_grafico_pie(datospie1,"#pie1","#valor1");
          },
          error: function() {
            $("#pie1").html('Error al conectar con el servidor !!!');
          }
        });



        //llamada a los datos de la BD pero para pie con los insert
        $.ajax({
                          url: "/ajaxdatosinsert",
                          type: 'GET',
                          datatype:"json",
                          success: function(resultado) {
                              $.each(resultado, function(index, value){

                              datospie2.push({label:index,data:value});
                                                });

                         //llamada a la funcion del pie2, el de los insert
                         $("#cargando2").css("display", "none");
                         dibuja_grafico_pie(datospie2,"#pie2","#valor2");



                          },
                          error: function() {
                            $("#pie2").html('Error al conectar con el servidor !!!');
                          }
                        });

        //llamada a los datos de la BD pero para pie con los update
        $.ajax({
                                  url: "/ajaxdatosupdate",
                                  type: 'GET',
                                  datatype:"json",
                                  success: function(resultado) {
                                      $.each(resultado, function(index, value){

                                      datospie3.push({label:index,data:value});
                                                        });

                                 //llamada a la funcion del pie3, el de los insert
                                  $("#cargando3").css("display", "none");
                                  dibuja_grafico_pie(datospie3,"#pie3","#valor3");



                                  },
                                  error: function() {
                                    $("#pie3").html('Error al conectar con el servidor !!!');
                                  }
                                });
        //llamada a los datos de la BD pero para pie con los delete
        $.ajax({
                                            url: "/ajaxdatosdelete",
                                            type: 'GET',
                                            datatype:"json",
                                            success: function(resultado) {
                                                $.each(resultado, function(index, value){

                                                datospie4.push({label:index,data:value});
                                                                  });

                                           //llamada a la funcion del pie2, el de los insert
                                            $("#cargando4").css("display", "none");
                                           dibuja_grafico_pie(datospie4,"#pie4","#valor4");



                                            },
                                            error: function() {
                                              $("#pie4").html('Error al conectar con el servidor !!!');
                                            }
                                          });
        //llamada a los datos de la BD pero para pie con los select
        $.ajax({
                                                      url: "/ajaxdatosselect",
                                                      type: 'GET',
                                                      datatype:"json",
                                                      success: function(resultado) {
                                                          $.each(resultado, function(index, value){

                                                          datospie5.push({label:index,data:value});
                                                                            });

                                                     //llamada a la funcion del pie2, el de los insert
                                                      $("#cargando5").css("display", "none");
                                                      dibuja_grafico_pie(datospie5,"#pie5","#valor5");



                                                      },
                                                      error: function() {
                                                        $("#pie5").html('Error al conectar con el servidor !!!');
                                                      }
                                                    });

        //llamada a los datos de la BD pero para pie con las conecciones
        $.ajax({
                                     url: "/ajaxdatosconeccion",
                                     type: 'GET',
                                     datatype:"json",
                                     success: function(resultado) {
                                         $.each(resultado, function(index, value){

                                        datospie6.push({label:index,data:value});

                                                           });


                                    //llamada a la funcion del pie6, el de los insert
                                    $("#cargando6").css("display", "none");
                                    dibuja_grafico_pie(datospie6,"#pie6","#valor6");




                                     },
                                     error: function() {
                                       $("#pie6").html('Error al conectar con el servidor !!!');
                                     }
                                   });
        //llamada a los datos de la fecha y hora del reporte
        $.ajax({
                                                       url: "/ajaxdatosfechahora",
                                                       type: 'GET',
                                                       datatype:"json",
                                                       success: function(resultado) {


                                                    $("#fechayhora").html( resultado['fecha y Hora']);



                                                       },
                                                       error: function() {
                                                         $("#fechayhora").html('Error al conectar con el servidor !!!');
                                                       }
                                                     });




        }


        setInterval(llamada_ajax, tiempo);

        </script>




<script>
        // grafica de pie
        function dibuja_grafico_pie(datos,etiqueta,texto) {

         //obteniendo los datos
         var data = datos;
         //obteniendo el div
         var varpie = $(etiqueta);
         //quitando todos los eventos posibles
         varpie.unbind();

         var options = {
         				series: {
         					pie: {
         					    innerRadius:0.25,
         						show: true
         					}
         				},
                          	grid: {
                                hoverable: true,
                                clickable: true
                            }
                       };


         $.plot(varpie, data, options);






       // funcion para mostrar datos del pie haciendo click

       varpie.bind("plotclick", function(event, pos, obj) {

       				if (!obj) {
       					return;
       				}

       				percent = parseFloat(obj.series.percent).toFixed(2);

       			$(texto).html(obj.series.label + "= "+ obj.series.data[0][1]+ "-> Representa el " + percent + "%");
       				//alert(texto  + obj.series.label + "= "+ obj.series.data[0][1]+ "-> Representa el " + percent + "%");


       			});

       }
        </script>


<script>
        // grafica de barra

       function dibuja_grafico_barra(datosbar,etiqueta) {

        var data = datosbar;
        var options = {
            series: {
                bars: {
                    show: true
                      }
                    },
                xaxis: {
                   show: false
                   }

        };
        var varbar = $(etiqueta);

        $.plot(varbar, data, options);

    }

        </script>



</head>


<body>
<h1 align="center" ><p> <b>amt4pg</b></p></h1>
<h2 align="center" ><p> <b>Reporte del servidor de PG</b></p></h2>
<p align="center"><b> Fecha y Hora en el servidor:</b> <div id="fechayhora" align="center">  {{datadate[0]}} , {{datatime[0]}} </div>  </p>
<p align="center" ><b> Versión:</b> <div id="version" align="center">{{dataversion[0]}}  </div></p>

<br>
<center>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Bases de datos:{{datacount[0]}}</b></div>

<table border="1" class="table table-striped">

<tr>
 <td align="center">
 %for field in datadatabase:
 <a href="/pg/{{field[0]}}"  target="_blank" > {{field[0]}}  </a>
 %end

  </td>

</tr>

</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center"  ><b style="color:#ffffff "  >Recurrsos:</b></div>

<table border="1" class="table table-striped">

<tr>

 <td><center>  Uso de Memoria (MB) </center> </td>
 <td><center>  %  de uso de CPU  </center> </td>

</tr>
<tr>
 <div id="cargandobarra"  > <img src="cargando.gif" height="20" width="20"> </div>
 <td><center>  <div id="bar1" style="width:450px;height:250px"> </div> </center> </td>
 <td><center>  <div id="bar2" style="width:450px;height:250px"> </div> </center> </td>

</tr>

</table>
</div>
<br>



<div class="panel panel-default">
<div class="panel-heading" align="center"  ><b style="color:#ffffff "  >Bases de datos/Peso(MB):</b></div>

<table border="1" class="table table-striped">

<tr>
 <div id="cargando"  > <img src="cargando.gif" height="20" width="20"> </div>
 <td><center>  <div id="pie1" style="width:800px;height:600px"> </div> </center> </td>
<div id="valor1" style="background-color:#B1B1B1;" > </div>
</tr>

</table>
</div>
<br>

<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Tuplas Insertadas :</b></div>

<table border="1" class="table table-striped">

<tr>
<div id="cargando2"> <img src="cargando.gif" height="20" width="20"></div>
 <td><center>  <div id="pie2" style="width:800px;height:600px"> </div> </center> </td>
<div id="valor2"  style="background-color:#B1B1B1;"  > </div>
</tr>

</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Tuplas Actualizadas:</b></div>

<table border="1" class="table table-striped">

<tr>
 <div id="cargando3"> <img src="cargando.gif" height="20" width="20"></div>
 <td><center>  <div id="pie3" style="width:800px;height:600px"> </div> </center> </td>
<div id="valor3"  style="background-color:#B1B1B1;"  > </div>
</tr>

</table>
</div>
<br>



<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Tuplas Elimindas:</b></div>

<table border="1" class="table table-striped">

<tr>
<div id="cargando4"> <img src="cargando.gif" height="20" width="20"></div>
 <td><center>  <div id="pie4" style="width:800px;height:600px"> </div> </center> </td>
<div id="valor4"  style="background-color:#B1B1B1;"  > </div>
</tr>

</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Tuplas Seleccionadas:</b></div>

<table border="1" class="table table-striped">

<tr>
<div id="cargando5"> <img src="cargando.gif" height="20" width="20"></div>
 <td><center>  <div id="pie5" style="width:800px;height:600px"> </div> </center> </td>
<div id="valor5"  style="background-color:#B1B1B1;"  > </div>
</tr>

</table>
</div>
<br>


<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Conecciones :</b></div>

<table border="1" class="table table-striped">

<tr>
<div id="cargando6"> <img src="cargando.gif" height="20" width="20"></div>
 <td><center>  <div id="pie6" style="width:800px;height:600px"> </div> </center> </td>
<div id="valor6"  style="background-color:#B1B1B1;" > </div>
</tr>

</table>
</div>
<br>





<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >TableSpaces:</b></div>

<table  border="1" class="table table-striped">
<tr>
<td align="center">
%for field in datatablespace:
  -{{field[0]}}
 %end
 </td>
</tr>

</table>
</div>
<br>




<div class="panel panel-default">
<div class="panel-heading" align="center" ><b style="color:#ffffff " >Usuarios:</b></div>

<table  border="1" class="table table-striped">

<tr>
 <td align="center">
 %for field in datauser:
 -{{field[0]}}
  %end
 </td>
</tr>
%end
</table>
</div>
<br>

Autor: Anthony R. Sotolongo Leon (asotolongo@gmail.com)
</center>

</body>
</html>
