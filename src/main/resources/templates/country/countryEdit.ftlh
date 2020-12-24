<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item"><a href="/countries"><@spring.message "lang.breadcrumb.country"/></a></li>
    <li class="breadcrumb-item"><a href="/countries/${country.cnt_code}">${country.name}</a></li>
    <li class="breadcrumb-item active" aria-current="page">${country.name} <@spring.message "lang.button.edit"/></li>
  </ol>
</nav>
	<form method="post" enctype="multipart/form-data" action="" class="mb-5" >
	<input type="hidden" name="_csrf" value="${_csrf.token}" />
	<div class="form-row">
	<div class="col-7">
    		<label for="inputText"><@spring.message "lang.label.country.name"/></label>
        	<input type="text" name="name"  id="inputText" placeholder="<@spring.message "lang.input.country.name.placeholder"/>" value="<#if countryUpdate??>${countryUpdate.name}<#else>${country.name}</#if>"
    			class="form-control ${(nameError??)?string('is-invalid', '') }"/>
    			<#if nameError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.country.name.error.empty"/>
                </div>
            </#if>
    	</div>
    	<div class="col">
    		<label for="inputText"><@spring.message "lang.label.cnt_code"/></label>
        	<input type="text" name="cnt_code"  id="inputText" placeholder="<@spring.message "lang.input.country.cnt_code.placeholder"/>" value="<#if countryUpdate??>${countryUpdate.cnt_code}<#else>${country.cnt_code}</#if>"
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
            <textarea name="description"  id="exampleFormControlTextarea1" rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/> "
    		class="form-control ${(descriptionError??)?string('is-invalid', '') }"><#if countryUpdate??>${countryUpdate.description}<#else>${country.description}</#if></textarea>
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
        <button type="submit" class="btn btn-primary mt-5"><@spring.message "lang.button.update"/></button>
    </form>

    	<div >
    		<img style="height:200px; weight:200px" src="/img/<#if !country.main_photo??>deffault/countries.jpg<#else>${country.cnt_code}/${country.main_photo}</#if>">
    	</div>


</@c.common>