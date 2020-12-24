<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item"><a href="/cities"><@spring.message "lang.breadcrumb.cities"/></a></li>
     <li class="breadcrumb-item"><a href="/cities/${city.id}">${city.name}</a></li>
    <li class="breadcrumb-item active" aria-current="page">${city.name} edit</li>
  </ol>
</nav>
	<form method="post" enctype="multipart/form-data" class="mb-5" >
	<input type="hidden" name="_csrf" value="${_csrf.token}" />
	<div class="form-row">
    		<label for="inputText"><@spring.message "lang.label.city.name"/></label>
        	<input type="text" name="name" class="form-control ${(nameError??)?string('is-invalid', '') }" id="inputText" placeholder="<@spring.message "lang.input.city.name.placeholder"/>" value="${city.name}"/>
    		<#if nameError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.city.name.error.empty"/>
                </div>
            </#if>
    </div>
    <div class="form-row">
            <label for="exampleFormControlTextarea1"><@spring.message "lang.label.description"/></label>
            <textarea name="description" class="form-control ${(descriptionError??)?string('is-invalid', '') }" id="exampleFormControlTextarea1" rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/>" >${city.description}</textarea>
   			<#if descriptionError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.city.description.error.empty"/>
                </div>
            </#if>
   	</div>
   
    <div class="custom-file mb-3">
        <input type="file" name="file" class="custom-file-input ${(fileError??)?string('is-invalid', '') }" id="validatedCustomFile"/>
        <label class="custom-file-label" for="validatedCustomFile"><@spring.message "lang.label.file"/></label>
        <#if fileError??>
    		<div class="invalid-feedback">
    			<@spring.message "lang.city.file.error.overSize"/>
    		</div>
    	</#if>
    </div>
    
        <button type="submit" class="btn btn-primary"><@spring.message "lang.button.update"/></button>
    </form>
   
    	<div >
    		<img style="height:200px; weight:200px" src="/img/<#if !city.main_photo??>deffault/city.jpg<#else>${city.country.cnt_code}/${city.name}/${city.main_photo}</#if>">
    	</div>
  	

</@c.common>