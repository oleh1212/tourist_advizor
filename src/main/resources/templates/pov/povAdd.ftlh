<#import "../parts/common.ftlh" as c>
<#import "../parts/raiting.ftlh" as r>
<#include "../parts/security.ftlh"/>
<#import "/spring.ftl" as spring/>

<@c.common>

 
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li> 
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.pov.add"/></li>
  </ol>
</nav>
<form method="post" enctype="multipart/form-data"  class="mb-5 " name="myForm" id="myForm" >
<input type="hidden" name="_csrf" value="${_csrf.token}" />
	<div id="first">
   		<#if Error??>
		<div class="alert alert-danger" role="alert">
  			<@spring.message "lang.pov.error.fields"/>
		</div>            
		</#if>
			<div class="form-row " >
    			<label for="inputText" ><@spring.message "lang.label.pov.name"/> *</label>
        		<input type="text" name="name" class="form-control ${(nameError??)?string('is-invalid', '') }" 
        			id="povName" placeholder="<@spring.message "lang.input.pov.name.placeholder"/>" value="<#if pov??>${pov.name}</#if>"/>
       			 <#if nameError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.name.empty"/>
                </div>
            	</#if>
    		</div>
    		<div class="form-row">
        		<label for="exampleFormControlTextarea1"><@spring.message "lang.label.description"/>*</label>
    			<textarea name="description" class="form-control ${(descriptionError??)?string('is-invalid', '') }" id="description" 
    				rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/>" ><#if pov??>${pov.description}</#if></textarea>
    			<#if descriptionError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.description.empty"/>
                </div>
            	</#if>
   			</div>
			<#if countries??>
   			<div class="form-row ">
				<label for="inputGroupSelect02"><@spring.message "lang.label.country.name"/>*</label>
    			<select name="countryId" class="custom-select" id="countryId" >
        		<#list countries as country>
  					<option  value="${country.cnt_code}" >${country.name}</option>
  				</#list>
    			</select>
    		</div>
   			</#if>
   			<div class="form-row" id="getResultDiv">

   			<#if cities??>
				<label for="inputGroupSelect02"><@spring.message "lang.label.city.name"/>*</label>
    			<select name="cityId" class="custom-select ${(cityNameError??)?string('is-invalid', '') }" id="cityId" >
    			<#assign flag = true>
        		<#list cities as city>
        			<#if flag><#assign firstCity = city flag=false></#if>
  					<option  value="${city.id}" >${city.name}</option>
  				</#list>
    			</select>
   			</#if>
   				<#if cityNameError??>
           		<div class="invalid-feedback">
                	<@spring.message "lang.city.error.name.empty"/>
				</div>
        		</#if>
   			</div>
   	
   	
   			<div class="row" >
    			<div class="col-9">
    			</div>
    			<div class="col">
    				<input type="button" class="btn btn-primary my-3" id="nextButton1" value="<@spring.message "lang.button.step.next"/>" />
    			</div>
    		</div>
		</div>
		<div id="second" style="display:none;">
   			<div class="form-row">
    			<label for="inputText"><@spring.message "lang.phoneNumber"/></label>
        		<input type="text" name="phone_number" class="form-control" 
        			id="inputText" placeholder="<@spring.message "lang.placeholder.example.phoneNumber"/>" value="<#if pov??>${pov.phone_number}</#if>"/>
    		</div>
   				
   			<div class="form-row">
    			<label for="inputText"><@spring.message "lang.webSite"/></label>
        		<input type="text" name="web_site" class="form-control" 
        			id="inputText1" placeholder="<@spring.message "lang.placeholder.example.webSite"/>" value="<#if pov??>${pov.web_site}</#if>"/>
    		</div>
   			<div class="form-row">
    			<label for="inputDate"><@spring.message "lang.label.pov.vacationStartDate"/>*</label>
       			<input type="date" name="start_date" class="form-control ${(start_dateError??)?string('is-invalid', '') }" 
       				id="inputDate"  />
       			<#if start_dateError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.start_date.empty"/>
                </div>
            	</#if>
   			</div>
   			<div class="form-row">
    			<label for="inputDate"><@spring.message "lang.label.pov.vacationEndDate"/>*</label>
        		<input type="date" name="end_date" class="form-control <#if end_dateError?? || end_dateWrongError??>is-invalid</#if>" 
        			id="inputDate1"  s/>
        		<#if end_dateError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.end_date.empty"/>
           	 	</div>
        		<#elseif end_dateWrongError??>
        		<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.end_date.wrong"/>
            	</div>
        		</#if>
    		</div>
    		<div class="row">
    			<div class="col-9">
    				<input type="button" class="btn btn-primary my-3" id="previousButton1" value="<@spring.message "lang.button.step.previous"/>" />
    			</div>
    			<div class="col">
    				<input type="button" class="btn btn-primary my-3" id="nextButton2" value="<@spring.message "lang.button.step.next"/>" />
    			</div>
    		</div>

		</div>
		<div id="third" style="display:none;">
    		<div class="form-row">
    			<div class="input-group my-3">
    				<div class="input-group-prepend">
    					<label class="input-group-text" for="inputGroupSelect01"><@spring.message "lang.label.types"/></label>
  					</div>
  					<select class="custom-select" id="type" name="type" >
    				<#list categories as category>
  						<option  value="${category.type}">${category.type}</option>
  					</#list>
  					</select>
				</div>
    		</div>
    		<div class="custom-file mb-3">
        		<input type="file" name="file" class="custom-file-input ${(fileError??)?string('is-invalid', '') }" id="validatedCustomFile"/>
       			<label class="custom-file-label" for="validatedCustomFile"><@spring.message "lang.label.file"/></label>

       			<#if fileError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.file.empty"/>
                </div>
            	</#if>
    		</div>
    		<div class="custom-file mb-3">
        		<input type="file" name="files" class="custom-file-input ${(filesError??)?string('is-invalid', '') }" id="validatedCustomFile1" multiple/>
       			<label class="custom-file-label" for="validatedCustomFile"><@spring.message "lang.label.files"/></label>
       			<div class="mt-2">
					<div class="" role="alert" id="info">
  			
					</div>
					<div class="spinner-border text-white" role="status" id="loading">
  						<span class="sr-only">Loading...</span>
					</div>
				</div>
       			<#if filesError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.pov.error.files.empty"/>
                </div>
            	</#if>
    		</div>
			<label for="inputGroupSelect02"><@spring.message "lang.label.map"/></label>
			<div id="map"></div>
				<div id="firstCityDiv">
					<input type="hidden" value="<#if cities??>${firstCity.name}<#else>${city.name}</#if>"  id="firstCity"/>
				</div>
			<input type="hidden" name="restApiHotelId"  id="restApiHotelId"/>
    		<input type="hidden" name="lat"  id="lat"/>
			<input type="hidden" name="lng" id="lng"/>
			
    		<div class="row">
    			<div class="col-10">
    				<input type="button" class="btn btn-primary my-3" id="previousButton2" value="<@spring.message "lang.button.step.previous"/>" />
    			</div>
    			<div class="col">
    				<input type="button" class="btn btn-primary my-3" id="nextButton3" value="<@spring.message "lang.button.step.next"/>" />
    			</div>
    	</div>
    </div>
    <div id="forth" style="display:none;">
    	<div class="row row-cols-1 row-cols-md-1 mt-3">
    	<#list scoreCategories as scoreCategory>
  			<div class="col">
    			
    				<div class="text-center mb-1 h5">
    				${scoreCategory.name}
    				</div>
    				<textarea name="description" class="form-control" id="description" 
    					rows="5" placeholder="<@spring.message "lang.input.description.placeholder"/>" ></textarea>

    				<@r.rating scoreCategory.name scoreCategory.name 0 />
    		</div>	
  		</#list>	
    	</div>
    	
    	<div class="row">
    		<div class="col-10">
    			<input type="button" class="btn btn-primary my-3" id="previousButton3" value="<@spring.message "lang.button.step.previous"/>" />
    		</div>
    		<div class="col">
    			<input type="submit" class="btn btn-primary my-3" id="submitButton" value="<@spring.message "lang.button.add"/>"/>
    		</div>
    	</div>	
    </div>
</form>	


<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBJKqu2hNvTX8wm-PfhFK9Zn42TVxs_eo&callback=initMap&libraries=places" async defer></script>
<script src="/static/js/restApiSearchPlaces.js" async ></script>
<script src="/static/js/povAddSlicer.js" async ></script>
</@c.common>