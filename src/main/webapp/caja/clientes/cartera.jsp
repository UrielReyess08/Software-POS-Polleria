<%--
  Created by IntelliJ IDEA.
  User: RefinedCandle49
  Date: 1/05/2024
  Time: 21:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="model.Usuario, dao.UsuarioDao, model.Cliente, dao.ClienteDao,java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="<%=request.getContextPath()%>/styles/styles.css" />
        <link rel="icon" type="image/jpg" href="<%=request.getContextPath()%>/img/logo.ico"/>
        <title>Clientes | Pollos Locos</title>
    </head>
    <body class="container-fluid p-0">
        <%
                HttpSession sesion = request.getSession(false);
            
                if (sesion == null || sesion.getAttribute("usuario") == null) {
                    response.sendRedirect(request.getContextPath() + "/index.jsp");
                    return;
                }
            
                String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
            
                if(!"Cajero".equals(nombreRol)){    
        %>
        <script>
            alert("Acceso Denegado");
            <%
            switch(nombreRol){
                case "Administrador":
            %>window.location.href = "<%= request.getContextPath() %>/admin/usuarios.jsp?page=1";<%
                    break;
                    
                case "Almacenero":
            %>window.location.href = "<%= request.getContextPath() %>/almacen/productos.jsp?page=1";<%
                    break;
                    
                    default:
            %>window.location.href = "<%= request.getContextPath() %>/index.jsp";<%
            }
            %>
        </script>
        <%
            
            return;
        }
            
            String spageid=request.getParameter("page");
            int pageid=Integer.parseInt(spageid);
            int total=12;
            if(pageid==1){}
            else{
                pageid=pageid-1;
                pageid=pageid*total+1;
            }
            List<Cliente> cliente = ClienteDao.listarClientesPagina(pageid,total);
            request.setAttribute("list", cliente);
            
            int totalClientes = ClienteDao.contarClientes();
            int totalPages = (int) Math.ceil((double) totalClientes / total); // Calcula el número total de páginas
        %>

        <header>
            <nav class="navbar navbar-expand-sm bg-dark navbar-dark">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">POLLOS LOCOS</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="collapsibleNavbar">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link link-inactive" href="<%=request.getContextPath()%>/caja/menu.jsp">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-tools-kitchen-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M19 3v12h-5c-.023 -3.681 .184 -7.406 5 -12zm0 12v6h-1v-3m-10 -14v17m-3 -17v3a3 3 0 1 0 6 0v-3" /></svg>
                                    <span>Menú de Productos</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link link-active" href="<%=request.getContextPath()%>/caja/clientes/cartera.jsp?page=1">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-users"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M9 7m-4 0a4 4 0 1 0 8 0a4 4 0 1 0 -8 0" /><path d="M3 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2" /><path d="M16 3.13a4 4 0 0 1 0 7.75" /><path d="M21 21v-2a4 4 0 0 0 -3 -3.85" /></svg>
                                    <span>Gestionar Clientes</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link link-inactive" href="<%=request.getContextPath()%>/controlCarrito?accion=Carrito">
                                    <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-shopping-cart"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M6 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M17 19m-2 0a2 2 0 1 0 4 0a2 2 0 1 0 -4 0" /><path d="M17 17h-11v-14h-2" /><path d="M6 5l14 1l-1 7h-13" /></svg>
                                    <span>Ir a Carrito</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="collapse navbar-collapse" id="collapsibleNavbar">
                        <a href="${pageContext.request.contextPath}/logout.jsp" class="d-flex link-active align-items-center justify-content-end w-100">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="24"  height="24"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-logout-2"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 8v-2a2 2 0 0 1 2 -2h7a2 2 0 0 1 2 2v12a2 2 0 0 1 -2 2h-7a2 2 0 0 1 -2 -2v-2" /><path d="M15 12h-12l3 -3" /><path d="M6 15l-3 -3" /></svg>
                            <span class="mx-1">Cerrar Sesión</span>
                        </a>
                    </div>
                </div>
            </nav>    
        </header>

        <main>
            <div class="row d-flex align-items-center justify-content-center m-0">
                <div class="col-md-2"></div>
                <div class="col-md-8">
                    <h1 class="fw-bold">PANEL DE CLIENTES</h1>
                    
                    <div class="d-flex justify-content-end">
                    <div class="d-flex align-items-center">
                        <a href="${pageContext.request.contextPath}/caja/clientes/registrar.jsp" class="btn btn-primary">
                            <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-user-plus"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0" /><path d="M16 19h6" /><path d="M19 16v6" /><path d="M6 21v-2a4 4 0 0 1 4 -4h4" /></svg>
                            <span class="ms-1">Ir a registrar cliente</span>
                        </a>
                    </div>
                    <div class="d-flex align-items-center ms-3">
                        
                        <a href="${pageContext.request.contextPath}/caja/clientes/anulados.jsp?page=1" class="btn btn-secondary">
                            
                            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                                 fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                 stroke-linejoin="round"
                                 class="icon icon-tabler icons-tabler-outline icon-tabler-user-x">
                                <path stroke="none" d="M0 0h24v24H0z" fill="none"/>
                                <path d="M8 7a4 4 0 1 0 8 0a4 4 0 0 0 -8 0"/>
                                <path d="M6 21v-2a4 4 0 0 1 4 -4h3.5"/>
                                <path d="M22 22l-5 -5"/>
                                <path d="M17 22l5 -5"/>
                            </svg>
                            <span class="ms-1">Ir a clientes eliminados</span>
                        </a>
                    </div>
                            </div>


                    <c:if test="${ empty list}">
                        <span>¡Hola! Parece que esta tabla está vacía en este momento. ¡Ingresa datos para llenarla!</span>
                    </c:if>

                    <c:if test="${not empty param.registroExitoso}">
                        <div id="registroExitoso" class="alert alert-success d-flex align-items-center justify-content-between my-2">
                            ${param.registroExitoso}
                            <button type="button" class="button-mensaje text-success" onclick="cerrarMensaje()"><svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-x m-0"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 6l-12 12" /><path d="M6 6l12 12" /></svg></button>
                        </div> 
                    </c:if>

                    <c:if test="${not empty param.actualizarExitoso}">
                        <div id="actualizarExitoso" class="alert alert-success d-flex align-items-center justify-content-between my-2">
                            ${param.actualizarExitoso}
                            <button type="button" class="button-mensaje text-success" onclick="cerrarMensajeActualizar()"><svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-x m-0"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M18 6l-12 12" /><path d="M6 6l12 12" /></svg></button>
                        </div>
                    </c:if>


                    <c:if test="${not empty list}">
                        <div class="table-responsive bg-light color-tabla callout my-2 pb-0">
                            <table class="table mb-0">
                                <thead class="table-dark">
                                    <tr>
                                        <th style="display: none">ID</th>
                                        <th>DNI/RUC</th>
                                        <th>NOMBRES</th>
                                        <th>APELLIDOS</th>
                                        <th>CORREO ELECTRÓNICO</th>
                                        <!-- th>ESTADO</th -->
                                        <th>ACCIONES</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="cli">
                                        <tr>
                                            <td style="display: none">${cli.getIdCliente()}</td>
                                            <td>${cli.getDocumento()}</td>
                                            <td>${cli.getNombre()}</td>
                                            <td>${cli.getApellido()}</td>
                                            <td>${cli.getEmail()}</td>
                                            <%-- td>
                                                <c:choose>
                                                    <c:when test="${cli.getEmail() != null}">${cli.getEmail()}</c:when>
                                                    <c:when test="${cli.getEmail() == null}">-</c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose> 
                                            </td --%>
                                            <%-- td>
                                                <c:choose>
                                                    <c:when test="${cli.getEstado() == 0}">Inactivo</c:when>
                                                    <c:when test="${cli.getEstado() == 1}">Activo</c:when>
                                                    <c:otherwise>Estado Desconocido</c:otherwise>
                                                </c:choose>
                                            </td --%>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${cli.getIdCliente() == 1}"></c:when>

                                                    <c:otherwise>
                                                        <div class="d-flex align-items-center">
                                                            <a class="btn btn-warning"
                                                               href="${pageContext.request.contextPath}/controlCliente?action=editar&id=${cli.getIdCliente()}">
                                                                <svg xmlns="http://www.w3.org/2000/svg"
                                                                     width="20" height="20"
                                                                     viewBox="0 0 24 24" fill="none"
                                                                     stroke="currentColor"
                                                                     stroke-width="2"
                                                                     stroke-linecap="round"
                                                                     stroke-linejoin="round"
                                                                     class="icon icon-tabler icons-tabler-outline icon-tabler-edit">
                                                                    <path stroke="none"
                                                                          d="M0 0h24v24H0z" fill="none" />
                                                                    <path
                                                                        d="M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1" />
                                                                    <path
                                                                        d="M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z" />
                                                                    <path d="M16 5l3 3" />
                                                                </svg> Editar
                                                            </a>

                                                            <button id="btnAnular${cli.getIdCliente()}" data-form-id="formAnular${cli.getIdCliente()}" class="btn btn-danger d-flex align-items-center ms-2">
                                                                <svg  xmlns="http://www.w3.org/2000/svg"  width="20"  height="20"  viewBox="0 0 24 24"  fill="none"  stroke="currentColor"  stroke-width="2"  stroke-linecap="round"  stroke-linejoin="round"  class="icon icon-tabler icons-tabler-outline icon-tabler-trash"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M4 7l16 0" /><path d="M10 11l0 6" /><path d="M14 11l0 6" /><path d="M5 7l1 12a2 2 0 0 0 2 2h8a2 2 0 0 0 2 -2l1 -12" /><path d="M9 7v-3a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v3" /></svg>
                                                                <span class="ms-1">Eliminar</span>
                                                            </button>

                                                            <form id="formAnular${cli.getIdCliente()}" action="${pageContext.request.contextPath}/controlCliente?action=anularCliente&idCliente=${cli.getIdCliente()}" method="post" class="m-0">
                                                                <input type="hidden" name="idCliente" value="${cli.getIdCliente()}" />
                                                                <input type="hidden" name="newEstado" value="0" />
                                                            </form>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>

                                            </td>

                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="d-flex justify-content-center">
                            <ul class="pagination">
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/caja/clientes/cartera.jsp?page=1" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <%
                                    for(int i = 1; i <= totalPages; i++) {
                                %>
                                <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/caja/clientes/cartera.jsp?page=<%=i%>"><%=i%></a></li>
                                    <% } %>
                                <li class="page-item">
                                    <a class="page-link" href="${pageContext.request.contextPath}/caja/clientes/cartera.jsp?page=<%=totalPages%>" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </c:if>
                </div>
                <div class="col-md-2"></div>
            </div>
        </main>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function cerrarMensaje() {
                                    let registroExitoso = document.getElementById("registroExitoso");
                                    registroExitoso.style.display = "none";
                                    window.location.href = "${pageContext.request.contextPath}/caja/clientes/cartera.jsp?page=1"

                                }

                                function cerrarMensajeActualizar() {
                                    let actualizarExitoso = document.getElementById("actualizarExitoso");
                                    actualizarExitoso.style.display = "none";
                                    window.location.href = "${pageContext.request.contextPath}/caja/clientes/cartera.jsp?page=1";
                                }

        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {

                let btnAnular = document.querySelectorAll('[id^="btnAnular"]');

                btnAnular.forEach(function (btn) {
                    btn.addEventListener('click', function () {

                        let formId = this.getAttribute('data-form-id');

                        Swal.fire({
                            title: "¿Está seguro?",
                            html: "Esta acción eliminará al cliente.",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#0d6efd", //#3085d6
                            cancelButtonColor: "#dc3545", //#d33
                            cancelButtonText: "Cancelar",
                            confirmButtonText: "Confirmar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                document.getElementById(formId).submit();
                            }
                        });
                    });
                });

                const urlParams = new URLSearchParams(window.location.search);
                const anularCliente = urlParams.get('anularCliente');

                if (anularCliente === 'true') {
                    Swal.fire({
                        title: 'Cliente eliminado correctamente',
                        icon: 'success',
                        confirmButtonColor: "#0d6efd",
                        confirmButtonText: 'Aceptar'
                    }).then(() => {
                        window.location.href = "<%= request.getContextPath() %>/caja/clientes/cartera.jsp?page=1"
                    });
                }
            });
        </script>
    </body>
</html>
