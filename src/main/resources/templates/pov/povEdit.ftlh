<#import "../parts/common.ftlh" as c>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li> 
    <li class="breadcrumb-item"><a href="/cities"><@spring.message "lang.breadcrumb.cities"/></a></li>
    <li class="breadcrumb-item"><a href="/cities/${pov.city.id}">${pov.city.name}</a></li>
    <li class="breadcrumb-item"><a href="/cities/${pov.city.id}/povs"><@spring.message "lang.breadcrumb.pov"/></a></li>
    <li class="breadcrumb-item"><a href="/cities/${pov.city.id}/povs/${pov.id}">${pov.name}</a></li>
    <li class="breadcrumb-item active" aria-current="page">${pov.name} <@spring.message "lang.button.edit"/></li>
  </ol>
</nav>

	<form method="post" enctype="multipart/form-data"  class="mb-5" >
				<input type="hidden" name="_csrf" value="${_csrf.token}" />
				<div class="form-row">
    				<label for="inputText"><@spring.message "lang.label.pov.name"/>*</label>
        			<input type="text" name="name" class="form-control" 
        			id="inputText" placeholder="<@spring.message "lang.input.pov.name.placeholder"/>" value="${pov.name}"/>
    			</div>
    			<div class="form-row">
            		<label for="exampleFormControlTextarea1"><@spring.message "lang.label.description"/>*</label>
            		<textarea name="description" class="form-control" 
            		id="exampleFormControlTextarea1" rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/>" >${pov.description}</textarea>
   				</div>
   				
   				<div class="form-row">
    				<label for="inputText"><@spring.message "lang.phoneNumber"/></label>
        			<input type="tel" name="phone_number" class="form-control" 
        			id="inputText" placeholder="<@spring.message "lang.placeholder.example.phoneNumber"/>" value="<#if pov.phone_number??>${pov.phone_number}</#if>"/>
    			</div>
   				
   				<div class="form-row">
    				<label for="inputText"><@spring.message "lang.webSite"/></label>
        			<input type="text" name="web_site" class="form-control" 
        			id="inputText" placeholder="<@spring.message "lang.placeholder.example.webSite"/>" value="<#if pov.web_site??>${pov.web_site}</#if>"/>
    			</div>
   				
   				<div class="form-row">
    				<label for="inputDate"><@spring.message "lang.label.pov.vacationStartDate"/>*</label>
        			<input type="date" name="start" class="form-control" id="inputDate" value="${pov.start_date}"/>
    			</div>
   				
   				<div class="form-row">
    				<label for="inputDate"><@spring.message "lang.label.pov.vacationEndDate"/>*</label>
        			<input type="date" name="end" class="form-control" id="inputDate" value="${pov.end_date}"/>
    			</div>
   				
   	
    			<div class="form-row">
    				<div class="input-group my-3">
    					<div class="input-group-prepend">
    						<label class="input-group-text" for="inputGroupSelect01"><@spring.message "lang.label.types"/></label>
  						</div>
  						<select class="custom-select" id="inputGroupSelect01" name="type">
  							<#list categories as category>
  								<option <#if pov.category.type==category.type>selected</#if> value="${category.type}">${category.type}</option>
  							</#list>
  						</select>
					</div>
    			</div>
    
    			<div class="custom-file mb-3">
        			<input type="file" name="file" class="custom-file-input" id="validatedCustomFile"/>
       				<label class="custom-file-label" for="validatedCustomFile"><@spring.message "lang.label.file"/></label>
    			</div>
    			
        		<button type="submit" class="btn btn-primary"><@spring.message "lang.button.update"/></button>
    		</form>
    		
    		
    		<div>
    			<img style="height:200px; weight:200px" src="/img/<#if !pov.main_photo??>deffault/pov.jpg<#else>${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>">
    		</div>
  
</@c.common>