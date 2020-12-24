<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item"><a href="/cities"><@spring.message "lang.breadcrumb.cities"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.cities.add"/></li>
  </ol>
</nav>
	<form method="post" enctype="multipart/form-data" action="" class="mb-5" >
		<input type="hidden" name="_csrf" value="${_csrf.token}" />
		<div class="form-row">
    		<label for="inputText"><@spring.message "lang.label.city.name"/></label>
        	<input type="text" name="name"  id="inputText" placeholder="<@spring.message "lang.input.city.name.placeholder"/>" value="<#if city??>${city.name}</#if>"
    			class="form-control <#if ErrorExists?? || nameError??>is-invalid</#if>"/>
    		<#if nameError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.city.name.error.empty"/>
                </div>
           	<#elseif ErrorExists??>
           		<div class="invalid-feedback">
                	<@spring.message "lang.city.name.error.exists"/>
                </div>
            </#if>
    	</div>
    	<div class="form-row mb-2 ">
            <label for="exampleFormControlTextarea1"><@spring.message "lang.label.description"/></label>
            <textarea name="description"  id="exampleFormControlTextarea1" rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/>" 
            class="form-control ${(descriptionError??)?string('is-invalid', '') }"><#if city??>${city.description}</#if></textarea>
   			<#if descriptionError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.city.description.error.empty"/>
                </div>
            </#if>
   		</div>
		
		<div class="input-group mb-3">
  			<select class="custom-select" id="inputGroupSelect02" " name="countryId">
    		<#list countries as cntr>
  				<option value="${cntr.cnt_code}" <#if country?? && country.name==cntr.name>selected</#if> >${cntr.name}</option>
  			</#list>
  			</select>
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
    	
        <button type="submit" class="btn btn-primary"><@spring.message "lang.button.add"/></button>
	</form>
	
</@c.common>