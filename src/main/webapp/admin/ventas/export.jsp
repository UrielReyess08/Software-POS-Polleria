<%@ page import="model.Venta" %>
<%@ page import="java.util.List" %>
<%@ page import="dao.VentaDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"
          integrity="sha512-z3gLpd7yknf1YoNbCzqRKc4qyor8gaKU1qmn+CShxbuBusANI9QpRohGBreCFkKxLhei6S9CQXFEbbKuqLg0DA=="
          crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" href="https://kit-pro.fontawesome.com/releases/v6.5.1/css/pro.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.table2excel.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/js/jspdf.umd.js"></script>
    <script src="<%=request.getContextPath()%>/js/jspdf.plugin.autotable.js"></script>
    <title>Ventas por Fechas | Pollos Locos</title>
</head>
<body>
<%
    String desde = request.getParameter("desde");
    String hasta = request.getParameter("hasta");
    List<Venta> listaVentas = VentaDao.listarVentasPorFecha(desde, hasta);
    request.setAttribute("list", listaVentas);

%>
<main class="col-auto col-10 col-sm-8 col-md-9 col-xl-10">
    <section>
        <p id="desde" style="display: none">${desde}</p>
        <p id="hasta" style="display: none;">${hasta}</p>
        <h1 class="fw-bold">PANEL DE REPORTES</h1>
        <p>Fecha inicio: ${desde} - Hasta: ${hasta}</p>
        <div class="d-flex align-items-center justify-content-end">
            <button id="exportButton" class="btn btn-primary">Descargar EXCEL</button>
            <button class="btn btn-primary" onclick="generate()">Descargar PDF</button>
        </div>
        
        <c:if test="${empty list}">
            <span>¡Hola! Parece que esta tabla está vacía en este momento.</span>
        </c:if>
        
        <c:if test="${not empty list}">
            <div class="table-responsive">
                <table id="table2excel" class="table table-striped">
                    <tr>
                        <th style="display: none">Fecha inicio: ${desde} - Hasta: ${hasta}</th>
                    </tr>
                    <thead class="table-dark">
                    <tr>
                        <th>CÓDIGO</th>
                        <th>CLIENTE</th>
                        <th>FECHA Y HORA</th>
                        <th>TOTAL</th>
                    </tr>
                    </thead>
                    
                    <tbody>
                    <c:forEach items="${list}" var="venta">
                        <tr>
                            <td>${venta.getCodigo()}</td>
                            <td>${venta.getNombre()} ${venta.getApellido()}</td>
                            <td>${venta.getFechaHoraVenta()}</td>
                            <td>S/ <fmt:formatNumber type="number" pattern="#,###,##0.00" value="${venta.getTotal()}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
    </section>
</main>

<script>
    $(document).ready(function () {
        $("#exportButton").click(function () {
            var date = new Date();
            var formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0') + ' ' + date.getHours().toString().padStart(2, '0') + '-' + date.getMinutes().toString().padStart(2, '0') + '-' + date.getSeconds().toString().padStart(2, '0');
            var filename = "Ventas - " + formattedDate + ".xls";

            $("#table2excel").table2excel({
                exclude: ".excludeThisClass",
                name: "Ventas",
                filename: filename,
                preserveColors: true,
                // set to true if you want background colors and font colors preserved
            });
        });
    });
</script>
<script>
  function generate() {
      var desde = document.getElementById("desde").textContent;
      var hasta = document.getElementById("hasta").textContent;
      var date = new Date();
      var formattedDate = date.getFullYear() + '-' + (date.getMonth() + 1).toString().padStart(2, '0') + '-' + date.getDate().toString().padStart(2, '0') + ' ' + date.getHours().toString().padStart(2, '0') + '-' + date.getMinutes().toString().padStart(2, '0') + '-' + date.getSeconds().toString().padStart(2, '0');
      var filename = "Ventas - " + formattedDate + ".pdf";
    var doc = new jspdf.jsPDF()
    
    // Simple html example
    doc.autoTable({ html: '#table2excel' });
      doc.text("Fecha inicio: " + desde + " - " + "Hasta: " + hasta, 10, 10);
    doc.save(filename)
  }
</script>
</body>
</html>