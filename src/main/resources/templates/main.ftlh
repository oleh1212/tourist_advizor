<#import "parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.home"/></li>
  </ol>
</nav>

<div class="row">
	<div class="col">
		<@spring.message "lang.whatsNew.city"/>
		<div class="row row-cols-1 row-cols-md-1 mt-3">
		<#assign counter=0>
		<#list cities as city >
		
  			<div class="col  mb-4" style="height:400px;">
    			<div class="card " >
     				<a href="/cities/${city.id}" ><img style="height:300px;" src="/img/<#if !city.main_photo??>deffault/city.jpg<#else>${city.country.cnt_code}/${city.name}/${city.main_photo}</#if>" class="card-img-top" alt="..."/></a>
      				<div class="card-body  row">
        				<h5 class="card-title" style="height:22px;overflow: hidden;"><a href="/cities/${city.id}" >${city.country.name}, ${city.name}</a></h5>
        			
      				</div>
    			</div>
  			</div>
  		<#assign counter++>
  		<#if counter==5>
  			<#break>
  		</#if>
  		<#else>
  			<@spring.message "lang.list.no.cities"/>
  		</#list>
  		
		</div>
	</div>
	<div class="col">
		<@spring.message "lang.whatsNew.pov"/>
		<div class="row row-cols-1 row-cols-md-1 mt-3" >
		<#assign counter=0>
		<#list povs as pov>
  			<div class="col  mb-4" style="height:400px;">
    			<div class="card " >
      				<#if pov.category.type!="hotel" ||  !pov.restApiHotelId??>
  						<a href="/cities/${pov.city.id}/povs/${pov.id}" ><img style="height:300px;" src="/img/<#if !pov.main_photo??>deffault/pov.jpg<#else>${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" class="card-img-top" ></a>
  					<#else>
  						<a href="/cities/${pov.city.id}/povs/${pov.id}" ><img style="height:300px;" src="<#if pov.main_photo??>/img/${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" id="photo" class="card-img-top" ></a>
  					</#if>
  					<#if pov.restApiHotelId??>
  						<input type="hidden" id="restApiHotelId" value="${pov.restApiHotelId}" />
  						
  					</#if>
      				<div class="card-body  row">
        				<h5 class="card-title" style="height:25px;overflow: hidden;" ><a href="/cities/${pov.city.id}/povs/${pov.id}" >${pov.city.country.name}, ${pov.city.name},${pov.name}</a></h5>
 
      				</div>
    			</div>
  			</div>
  		<#assign counter++>
  		<#if counter==5>
  			<#break>
  		</#if>
  		<#else>
  			<@spring.message "lang.list.no.pov"/>
  		</#list>
		</div>
	</div>
</div>
<script src="/static/js/restApiSearchPhotos.js" async  defer></script>
</@c.common>
