<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>
<#import "../parts/pager.ftlh" as p>
<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item"><a href="/cities"><@spring.message "lang.breadcrumb.cities"/></a></li>
    <li class="breadcrumb-item active" aria-current="page">${city.name}</li>
  </ol>
</nav>		
						
<div class="card my-3">
	<img style="height:600px;width:100%; "src="/img/<#if !city.main_photo??>deffault/city.jpg<#else>${city.country.cnt_code}/${city.name}/${city.main_photo}</#if>" class="card-img"  />
	<div class="card-body">
    	<h5 class="card-title">${city.name}</h5>
    	<p class="card-text">${city.description}</p>
    	<div class="row">
  			<div class="col">
  				<a  class="btn btn-primary" href="/cities" ><@spring.message "lang.button.city.backto"/></a>
  			</div>
  			<#if isAdmin || user==city.author>
  			<div class="col">
  				<a class="btn btn-info" href="/cities/${city.id}/edit" ><@spring.message "lang.button.edit"/></a>
  			</div>	
  			<form method="post" action="/cities/${city.id}/delete">
  				<input type="hidden" name="_csrf" value="${_csrf.token}" />
  				<div class="col">
  					<button type="submit" class="btn btn-danger"><@spring.message "lang.button.delete"/></button>
  				</div>		
			</form>
			</#if>
  		</div>

  	</div>
</div>				

<a class="btn btn-primary mb-3" href="/cities/${city.id}/povs/add">
   <@spring.message "lang.button.pov.add"/>
</a>

<div class="dropdown">
  <button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <@spring.message "lang.button.pov"/>
  </button>
  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
  	<#list categories as category>
    <a class="dropdown-item" href="/cities/${city.id}/povs?type=${category.type}" >${category.type?cap_first}</a>
    </#list>
  </div>
</div>

<#list page.content as pov>

<#if pov.visible || isAdmin || pov.author == user>
<div style="height:240px;" class="card mt-3"  id="publication-list">
	<div class="row no-gutters" data-id="${pov.id}">
    	<div class="col-md-4" >

         
         <#if pov.category.type!="hotel" ||  !pov.restApiHotelId??>
  			<a   href="/cities/${pov.city.id}/povs/${pov.id}" ><img s style="height:240px;" src="/img/<#if !pov.main_photo??>deffault/pov.jpg<#else>${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" class="card-img"  ></a>
  		 <#else>
  		 	<a   href="/cities/${pov.city.id}/povs/${pov.id}" ><img   style="height:240px;" src="<#if pov.main_photo??>/img/${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" id="photo" class="card-img"  ></a>
  		 </#if>
  		 <#if pov.restApiHotelId??>
  		 	<input type="hidden" id="restApiHotelId" value="${pov.restApiHotelId}" />
  			
  		 </#if>
  		 </div>
         <div class="col-md-8">
         	<div class="card-body">
            	<h5 class="card-title"><a   href="/cities/${pov.city.id}/povs/${pov.id}" >${pov.city.country.name}, ${city.name}, ${pov.name}</a></h5>
            	<p class="card-text"><small class="text-muted"><@spring.message "lang.publishby"/> ${pov.author.username?cap_first} <@spring.message "lang.at"/> ${pov.publishdate}</small></p>
            	<p class="card-text">${pov.author.username?cap_first} <@spring.message "lang.was_there"/> <@spring.message "lang.from"/> ${pov.start_date} <@spring.message "lang.to"/> ${pov.end_date}</p>
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
<div>
	No point of view
</div>
</#list>

<#if page.totalPages gt 0>
	<@p.pager url page/>
</#if>		
<script src="/static/js/restApiSearchPhotos.js" async defer ></script>
</@c.common>