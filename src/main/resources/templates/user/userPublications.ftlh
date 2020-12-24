<#import "../parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item active" aria-current="page">${user.username?cap_first}</li>
  </ol>
</nav>

<div class="dropdown mb-3">
	<button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    	 <#if filter == "Cities"><@spring.message "lang.breadcrumb.cities"/><#else><@spring.message "lang.breadcrumb.pov"/></#if>
  	</button>
	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
    	<a class="dropdown-item" href="/users/${user.id}?filter=Cities"><@spring.message "lang.cities"/></a>
    	<a class="dropdown-item" href="/users/${user.id}?filter=Point of viewes"><@spring.message "lang.breadcrumb.pov"/></a>
  	</div>
  	<#list publications as publication>
  		<div class="card mt-3" style="height:850px">
  			<#if filter=="Cities">
  			<a   href="/cities/${publication.id}" ><img style="height:600px" src="/img/<#if !publication.main_photo??>deffault/city.jpg<#else>${publication.country.cnt_code}/${publication.name}/${publication.main_photo}</#if>" class="card-img-top" alt="..."/></a>
  			<#else>
  				<a  href="/cities/${publication.city.id}/povs/${publication.id}" ><img style="height:600px"src="/img/<#if !publication.main_photo??>deffault/pov.jpg<#else>${publication.city.country.cnt_code}/${publication.city.name}/${publication.name}/${publication.main_photo}</#if>" class="card-img-top" alt="..."></a>
  			</#if>
  			<div class="card-body">
    			<h5 class="card-title">
    			<#if filter=="Cities">
    				<a   " href="/cities/${publication.id}" >${publication.country.name}, ${publication.name}</a>
    			<#else>
    				<a   href="/cities/${publication.city.id}/povs/${publication.id}" >${publication.city.country.name}, ${publication.city.name}, ${publication.name}</a>
    			</#if>
    			</h5>
    			<p class="card-text" id="overflowText">${publication.description}</p>

    			<p class="card-text"><small class="text-muted">${publication.publishdate}</small></p>
  			</div>
		</div>
  	<#else>
  		<div class="mt-4">
  			No ${filter}
  		</div>
  	</#list>
</div>
</@c.common>