<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!doctype html>
<html lang="it">
<head>
	<jsp:include page="../header.jsp" />
	<title>Modifica elemento</title>
	
	<!-- style per le pagine diverse dalla index -->
    <link href="${pageContext.request.contextPath }/assets/css/global.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath }/assets/css/jqueryUI/jquery-ui.min.css" />
    <style>
		.ui-autocomplete-loading {
			background: white url("../assets/img/jqueryUI/anim_16x16.gif") right center no-repeat;
		}
		.error_field {
	        color: red; 
	    }
	</style>
    
</head>
<body>
	<jsp:include page="../navbar.jsp" />
	
	<main role="main" class="container">

		<%-- se l'attributo in request ha errori --%>
		<spring:hasBindErrors  name="film_regista_attr">
			<%-- alert errori --%>
			<div class="alert alert-danger " role="alert">
				Attenzione!! Sono presenti errori di validazione
			</div>
		</spring:hasBindErrors>
	
		<div class="alert alert-danger alert-dismissible fade show ${errorMessage==null?'d-none': ''}" role="alert">
		  ${errorMessage}
		  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		    <span aria-hidden="true">&times;</span>
		  </button>
		</div>
	
	
		<div class='card'> 
		    <div class='card-header'>
		        Modifica Film
		    </div>
		<form:form action="modify" method="post" modelAttribute="update_film_attr" validate = "novalidate">

		<div class='card-body'>
		
		
		    <div class="form-row">
				<div class="form-group col-md-6">
					<label for="titolo">Titolo</label>
						<spring:bind path="titolo">
							<input type="text" name="titolo" id="titolo" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il titolo" value="${update_film_attr.titolo }">
						</spring:bind>
					<form:errors  path="titolo" cssClass="error_field" />
				</div>
							
				<div class="form-group col-md-6">
					<label for="genere">Genere</label>
						<spring:bind path="genere">
							<input type="text" name="genere" id="genere" class="form-control ${status.error ? 'is-invalid' : ''}" placeholder="Inserire il genere" value="${update_film_attr.genere }">
						</spring:bind>
					<form:errors  path="genere" cssClass="error_field" />
				</div>
			</div>
			<div class="form-row">	
				<fmt:formatDate pattern='yyyy-MM-dd' var="parsedDate" type='date' value='${update_film_attr.dataPubblicazione}' />
					<div class="form-group col-md-6">
						<label for="dataPubblicazione">Data di Pubblicazione</label>
                      		<spring:bind path="dataPubblicazione">
	                        		<input class="form-control ${status.error ? 'is-invalid' : ''}" id="dataPubblicazione" type="date" placeholder="dd/MM/yy"
	                            		title="formato : gg/mm/aaaa"  name="dataPubblicazione" value="${parsedDate}" >
	            	        </spring:bind>
            	           	<form:errors  path="dataPubblicazione" cssClass="error_field" />
					</div>
							
					<div class="form-group col-md-6">
						<label for="minutiDurata">Durata (minuti)</label>
							<spring:bind path="minutiDurata">
								<input type="number" class="form-control ${status.error ? 'is-invalid' : ''}" name="minutiDurata" id="minutiDurata" placeholder="Inserire la durata" value="${update_film_attr.minutiDurata }">
							</spring:bind>
								<form:errors  path="minutiDurata" cssClass="error_field" />
							</div>
					</div>
						
					<div class="form-row">
						<div class="form-group col-md-6">
							<label for="registaSearchInput">Regista:</label>
							<spring:bind path="regista.id">
								<input class="form-control ${status.error ? 'is-invalid' : ''}" type="text" id="registaSearchInput"
									name="registaInput" value="${update_film_attr.regista.nome}${empty update_film_attr.regista.nome?'':' '}${update_film_attr.regista.cognome}">
							</spring:bind>
							<input type="hidden" name="regista.id" id="registaId" value="${update_film_attr.regista.id }">
							<form:errors  path="regista.id" cssClass="error_field" />
						</div>
					</div>		 
					
			</div>

		    <div class='card-footer'>
		        <a href="${pageContext.request.contextPath }/film/" class='btn btn-outline-secondary' style='width:80px'>
		            <i class='fa fa-chevron-left'></i> Back
		        </a>
		        <input type = "hidden" name = "idFilm" value = "${update_film_attr.id }"/>
				<button type="submit" name="submit" value="submit" id="submit" class="btn btn-outline-primary">Modifica</button>		
		 	</div>
		 
		 </form:form>		
		    	<%-- FUNZIONE JQUERY UI PER AUTOCOMPLETE --%>
				<script>
 					$("#registaSearchInput").autocomplete({
 						 source: function(request, response) {
 						        $.ajax({
 						            url: "${pageContext.request.contextPath}/regista/searchRegistiAjax",
 						            datatype: "json",
 						            data: {
 						                term: request.term,   
 						            },
 						            success: function(data) {
 						                response($.map(data, function(item) {
 						                    return {
 							                    label: item.label,
 							                    value: item.value
 						                    }
 						                }))
 						            }
 						        })
 						    },
 						//quando seleziono la voce nel campo deve valorizzarsi la descrizione
 					    focus: function(event, ui) {
 					        $("#registaSearchInput").val(ui.item.label)
 					        return false
 					    },
 					    minLength: 2,
 					    //quando seleziono la voce nel campo hidden deve valorizzarsi l'id
 					    select: function( event, ui ) {
 					    	$('#registaId').val(ui.item.value);
 					    	//console.log($('#registaId').val())
 					        return false;
 					    }
 					});
				</script>

		</div>	
	
	<!-- end main container -->	
	</main>
	<jsp:include page="../footer.jsp" />
	
</body>
</html>