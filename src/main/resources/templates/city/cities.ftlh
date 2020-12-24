<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>
<#import "../parts/pager.ftlh" as p>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.cities"/></li>
  </ol>
</nav>
	<a class="btn btn-primary" href="cities/add">
    	<@spring.message "lang.button.city.add"/>
  	</a>

   <#list page.content as city>
			<div class="card mt-3"  id="publication-list">
            <div class="row no-gutters" data-id="${city.id}">
                    <div class="col-md-4" >
                      <a   href="/cities/${city.id}" ><img style="height:220px;" src="/img/<#if !city.main_photo??>deffault/city.jpg<#else>${city.country.cnt_code}/${city.name}/${city.main_photo}</#if>" class="card-img"  /></a>
                    </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title"><a   href="/cities/${city.id}" >${city.country.name}, ${city.name}</a></h5>
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
			<@spring.message "lang.list.no.cities"/>
		</#list>
		<#if page.totalPages gt 0>
			<@p.pager url page/>
		</#if>
</@c.common>