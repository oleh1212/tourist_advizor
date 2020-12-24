<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>
<#import "../parts/pager.ftlh" as p>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li> 
    <li class="breadcrumb-item"><a href="/cities"><@spring.message "lang.breadcrumb.cities"/></a></li>
    <li class="breadcrumb-item"><a href="/cities/${city.id}">${city.name}</a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.pov"/></li>
  </ol>
</nav>

<div class="dropdown mb-3">
	<button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    	<@spring.message "lang.button.sortBy"/> ${category}
  	</button>
	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
  	<#list categories as category>
    	<a class="dropdown-item" href="/cities/${city.id}/povs?type=${category.type}" >${category.type?cap_first}</a>
    </#list>
    	<a class="dropdown-item" href="/cities/${city.id}/povs" >All</a>
  	</div>
</div>

	<#list page.content as pov>
	<#if pov.visible || isAdmin || pov.author == user>
		<div class="card mb-3" >
  			<div class="row no-gutters">
    			<div class="col-md-4 " >

      			<#if pov.category.type!="hotel" ||  !pov.restApiHotelId??>
  					<a   href="/cities/${pov.city.id}/povs/${pov.id}" ><img style="width: 330px; height:235px;" src="/img/<#if !pov.main_photo??>deffault/pov.jpg<#else>${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>"  ></a>
  				<#else>
  					<a   href="/cities/${pov.city.id}/povs/${pov.id}" ><img  style="width: 330px; height:235px;" src="<#if pov.main_photo??>/img/${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" id="photo"  ></a>
  			
  				</#if>
  				<#if pov.restApiHotelId??>
  					<input type="hidden" id="restApiHotelId" value="${pov.restApiHotelId}" />
  			
  				</#if>
    			</div>
    			<div class="col-md-8">
      				<div class="card-body">
        				<h5 class="card-title"><a   href="/cities/${pov.city.id}/povs/${pov.id}" >${pov.name}</a></h5>
        				<p class="card-text"><@spring.message "lang.vacationDate"/> : <@spring.message "lang.from"/> ${pov.start_date} <@spring.message "lang.to"/> ${pov.end_date}</p>
        				
        				<p class="card-text"><small class="text-muted"><${pov.city.country.name}, ${pov.city.name}</small></p>
        				
        				<p class="card-text"><small class="text-muted"><@spring.message "lang.publishby"/> ${pov.author.username} <@spring.message "lang.at"/> ${pov.publishdate}</small></p>
        				
        				<div class="row">

  						<#if isAdmin>
  							<div class="col">
  								<a class="btn btn-info" href="/cities/${pov.city.id}/povs/${pov.id}/edit" ><@spring.message "lang.button.edit"/></a>
  							</div>
  				
  							<form method="post" action="/cities/${pov.city.id}/povs/${pov.id}/delete">
  								<input type="hidden" name="_csrf" value="${_csrf.token}" />
  								<div class="col">
  										<button type="submit" class="btn btn-danger"><@spring.message "lang.button.delete"/></button>
  								</div>
  					
							</form>
						</#if>
  						</div>
      				</div>
      				
    			</div>
 		 	</div>
		</div>
	</#if>
	<#else>
		<@spring.message "lang.list.no.pov"/>
	</#list>
	
	<#if page.totalPages gt 0>
		<@p.pager url page/>
	</#if>
	<script src="/static/js/restApiSearchPhotos.js" async defer ></script>
</@c.common>