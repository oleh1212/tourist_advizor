<#import "../parts/common.ftlh" as c>
<#import "../parts/pager.ftlh" as p>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>

<@c.common>

<#if isAdmin >
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.country"/></li>
  </ol>
</nav>
<p class="my-3">
  	<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
    	<@spring.message "lang.button.country.add"/>
  	</button>
</p>
<div class="collapse <#if country??>show</#if>" id="collapseExample">
	<form method="post" enctype="multipart/form-data" action="" class="mb-5" >
	<input type="hidden" name="_csrf" value="${_csrf.token}" />
	<div class="form-row">
	<div class="col-7">
    		<label for="inputText"><@spring.message "lang.label.country.name"/></label>
        	<input type="text" name="name"  id="inputText" placeholder="<@spring.message "lang.input.country.name.placeholder"/>" value="<#if country??>${country.name}</#if>"
    			class="form-control ${(nameError??)?string('is-invalid', '') }"/>
    			<#if nameError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.country.name.error.empty"/>
                </div>
            </#if>
    	</div>
    	<div class="col">
    		<label for="inputText"><@spring.message "lang.label.cnt_code"/></label>
        	<input type="text" name="cnt_code"  id="inputText" placeholder="<@spring.message "lang.input.country.cnt_code.placeholder"/>" value="<#if country??>${country.cnt_code}</#if>"
    			class="form-control ${(cnt_codeError??)?string('is-invalid', '') }"/>
    			<#if cnt_codeError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.country.cnt_code.error.empty"/>
                </div>
            </#if>
    	</div>
    </div>
    <div class="form-row">
            <label for="exampleFormControlTextarea1"><@spring.message "lang.label.description"/></label>
            <textarea name="description"  id="exampleFormControlTextarea1" rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/>" 
    		class="form-control ${(descriptionError??)?string('is-invalid', '') }"><#if country??>${country.description}</#if></textarea>
    		<#if descriptionError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.country.description.error.empty"/>
                </div>
            </#if>
   	</div>
   	<div class="custom-file mt-3">
    	<input type="file" name="file" class="custom-file-input ${(fileError??)?string('is-invalid', '') }" id="validatedCustomFile" >
    	<label class="custom-file-label" for="validatedCustomFile"><@spring.message "lang.label.file"/></label>
    	<#if fileError??>
    		<div class="invalid-feedback">
    			<@spring.message "lang.country.file.error.overSize"/>
    		</div>
    	</#if>
    </div>
        <button type="submit" class="btn btn-primary mt-5"><@spring.message "lang.button.add"/></button>
    </form>
   
    
</div>

	
</#if>
    <#list page.content as country>
    	<div class="card bg-dark text-white my-5">
  			<a  href="/countries/${country.cnt_code}" ><img class="countryImg" src="/img/<#if !country.main_photo??>deffault/countries.jpg<#else>${country.cnt_code}/${country.main_photo}</#if>"></a>
  			<div>
    			<a  href="/countries/${country.cnt_code}" ><h5 class="card-title">${country.name}</a></h5>
  			</div>
 
  			<div class="row">

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
		
	<#else>
		<@spring.message "lang.list.no.countries"/>
    </#list>
    
	<#if page.totalPages gt 0>
		<@p.pager url page/>
	</#if>
    
</@c.common>