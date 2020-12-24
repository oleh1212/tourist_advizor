<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>
<#import "../parts/pager.ftlh" as p>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item"><a href="/countries"><@spring.message "lang.breadcrumb.country"/></a></li>
    <li class="breadcrumb-item active" aria-current="page">${country.name}</li>
  </ol>
</nav>

<div class="card mb-3">

  <img style="width:100%;height:400px;" src="/img/<#if !country.main_photo??>deffault/countries.jpg<#else>${country.cnt_code}/${country.main_photo}</#if>" class="card-img-top" alt="...">

  <div class="card-body">
    <h5 class="card-title">${country.name}</h5>
    <p class="card-text">${country.description}</p>
    <div class="row">
  		<div class="col">
  			<a  class="btn btn-primary" href="/countries" ><@spring.message "lang.button.country.backto"/></a>
  		</div>
  		<#if isAdmin>
  		<div class="col">
  			<a class="btn btn-info" href="/countries/${country.cnt_code}/edit" ><@spring.message "lang.button.edit"/></a>
  		</div>	
  		<form method="post" action="/countries/${country.cnt_code}/delete">
  			<input type="hidden" name="_csrf" value="${_csrf.token}" />
  			<div class="col">
  				<button type="submit" class="btn btn-danger"><@spring.message "lang.button.delete"/></button>
  			</div>		
		</form>
		</#if>
  	</div>
  </div>
</div>

		

<a class="btn btn-primary" href="/cities/add?country_id=${country.cnt_code}">
    <@spring.message "lang.button.city.add"/>
</a>
	
		<#list page.content as city>
			<div class="card mt-3"  id="publication-list">
            <div class="row no-gutters" data-id="${city.id}">
                    <div class="col-md-4" >
                      <a  href="/cities/${city.id}" ><img src="/img/<#if !city.main_photo??>deffault/city.jpg<#else>${city.country.cnt_code}/${city.name}/${city.main_photo}</#if>" class="card-img"  /></a>
                    </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><a  href="/cities/${city.id}" >${city.country.name}, ${city.name}</a></h5>
                        <div class="row">
  						<#if isAdmin>
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
            </div>
        </div>
		<#else>
		<div class="mt-3">
			<@spring.message "lang.list.no.cities"/>
		</div>		
		</#list>
		
		<#if page.totalPages gt 0>
			<@p.pager url page/>
		</#if>
</@c.common>