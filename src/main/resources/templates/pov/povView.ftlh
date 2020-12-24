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
    <li class="breadcrumb-item active" aria-current="page">${pov.name}</li>
  </ol>
</nav>
<#if pov.visible || isAdmin || pov.author == user>
<#if pov.city.empty==true && pov.author==user>
<div class="alert alert-warning" role="alert">
  	<p><@spring.message "lang.alert.fillout.first"/></p>
  	<p><@spring.message "lang.alert.fillout.second"/></p>
  	<a href="/cities/${pov.city.id}/edit" class="badge badge-warning"><@spring.message "lang.alert.fillout"/></a>
</div>
</#if>
<#if !pov.visible>
<div class="alert alert-warning" role="alert">
  	<p><@spring.message "lang.alert.notPublish.first"/> </p>
  	<p><@spring.message "lang.alert.notPublish.second"/> </p>
</div>
</#if>
		<div class="card mb-3">
		<div class="card-header">
    		<ul class="nav nav-tabs card-header-tabs">
      			<li class="nav-item">
        			<a class="nav-link active" href="#"><@spring.message "lang.overview"/></a>
      			</li>
      			<#if pov.web_site??>
      			<li class="nav-item">
        			<a class="nav-link" href=" http://${pov.web_site}">${pov.web_site}</a>
      			</li>
      			</#if>
      			<#if pov.phone_number??>
      			<li class="nav-item">
        			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true"><@spring.message "lang.phoneNumber"/>: ${pov.phone_number}</a>
      			</li>
      			</#if>
      			<li class="nav-item">
        			<a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">${pov.author.username} <@spring.message "lang.was_there"/> <@spring.message "lang.from"/> ${pov.start_date} <@spring.message "lang.to"/> ${pov.end_date}</a>
      			</li>
    		</ul>
  		</div>
  		<#if pov.category.type!="hotel" ||  !pov.restApiHotelId??>
  			<img src="/img/<#if !pov.main_photo??>deffault/pov.jpg<#else>${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" class="card-img-top" >
  		<#else>
  			<img src="<#if pov.main_photo??>/img/${pov.city.country.cnt_code}/${pov.city.name}/${pov.name}/${pov.main_photo}</#if>" id="photo" class="card-img-top" >
  			
  		</#if>
  		<#if pov.restApiHotelId??>
  			<input type="hidden" id="restApiHotelId" value="${pov.restApiHotelId}" />
  			
  		</#if>
 		<div class="card-body">
 			<div id="carouselExampleIndicators" class="carousel slide" style="heght:400px;width:400px;" data-ride="carousel">
  				<ol class="carousel-indicators" >
  				<#assign
  					active = true
  				>
  				<#list pov.photos as photo>
    				<li data-target="#carouselExampleIndicators" data-slide-to="${photo.id}" <#if active>class="active"</#if></li>
    				<#assign
  						active = false
  					>
  				<#else>
  				<div id="carousel-ol">
  				
  				</div>	
    			</#list>
  				</ol>
  				<div class="carousel-inner" >
  				<#assign
  					active = true
  				>
  				<#list pov.photos as photo>
    				<div class="carousel-item <#if active>active</#if>">
      					<img  height="300" width="400"   src="/img/${photo.pov.city.country.cnt_code}/${photo.pov.city.name}/${photo.pov.name}/${photo.file_name}" class="d-block h-300  w-400" alt="...">
    				</div>
    				<#assign
  						active = false
  					>
  				<#else>
  				<div id="carousel-div">

  				</div>
   				</#list>
  				</div>
  				<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
    				<span class="sr-only">Previous</span>
  				</a>
  				<a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    				<span class="carousel-control-next-icon" aria-hidden="true"></span>
    				<span class="sr-only">Next</span>
  				</a>
			</div>
    		<h5 class="card-title">${pov.name}</h5>
    		<p class="card-text">${pov.description}</p>
    		<p class="card-text"><small class="text-muted">${pov.city.country.name}, ${pov.city.name}</small></p>
        				
        				<p class="card-text"><small class="text-muted"><@spring.message "lang.publishby"/> ${pov.author.username} at ${pov.publishdate}</small></p>
  		</div>
  		<div class="row">
  			<div class="col">
  				<a  class="btn btn-primary" href="/cities/${pov.city.id}/povs?type=${pov.category.type}" ><@spring.message "lang.button.pov.backto"/> ${pov.category.type}</a>
  			</div>
  			<#if isAdmin || user==pov.author >
  				<#if isAdmin >
  				<form method="post" action="/cities/${pov.city.id}/povs/${pov.id}/visible">
  					<input type="hidden" name="_csrf" value="${_csrf.token}" />
  					<div class="col">
  							<#assign visible>
  								<#if pov.visible>
  									<@spring.message "lang.hide"/>
  								<#else>
  									<@spring.message "lang.publish"/>
  								</#if>
  							</#assign>
  							<button type="submit" class="btn btn-primary">${pov.visible?then(visible,visible)}</button>
  					</div>
				</form>
  				</#if>
  				<div class="col">
  					<a class="btn btn-info" href="/cities/${pov.city.id}/povs/${pov.id}/edit" ><@spring.message "lang.button.edit"/></a>
  				</div>
  				
  				<form method="post" action="/cities/${pov.city.id}/povs/${pov.id}/delete">
  					<input type="hidden" name="_csrf" value="${_csrf.token}" />
  					<div class="col">
  							<button type="submit" class="btn btn-danger"><@spring.message "lang.button.delete"/></button>
  					</div>
  					
				</form>
			</#if>
  			</div>
	</div>
	<#if pov.lat?? && pov.lng?? >
	<p class="my-3">
  		<button class="btn btn-info" type="button" data-toggle="collapse" data-target="#collapseExample" onclick="initMapWithPosition(${pov.lat},${pov.lng},13)" aria-expanded="false" aria-controls="collapseExample">
    		<@spring.message "lang.label.map.show"/>
  		</button>
	</p>
	<div class="collapse" id="collapseExample">
		<div id="map"></div>
	</div>
	</#if>
	
	<p class="my-3">
  		<button class="btn btn-primary" type="button" data-toggle="collapse" data-target="#collapseExample1" aria-expanded="false" aria-controls="collapseExample">
    		<@spring.message "lang.button.pov.veaveComment"/>
  		</button>
	</p>
	<div class="collapse <#if comment??>show</#if>" id="collapseExample1">
		<form lass="mb-5" method="post" action="/cities/${pov.city.id}/povs/${pov.id}/addComment">
  			<input type="hidden" name="_csrf" value="${_csrf.token}" />
  			<div class="row">
  				<div class="col-10">
  					<textarea name="text" class="form-control ${(textError??)?string('is-invalid', '') }" id="exampleFormControlTextarea1" rows="2"  ></textarea>
  				<#if textError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.comment.error.empty"/>
                </div>
            	</#if>
  				</div>
  				<div class="col">
  					<button type="submit" class="btn btn-primary mb-2"><@spring.message "lang.button.pov.leave"/></button>
  				</div>
  			</div>
		</form>
	</div>
	
	<#list comments as comment>
	<#if !comment.prnt_comment??>
	<div class="media mt-5 mb-2">
		<a class="mr-3" href="#">
			<img src="/img/<#if !comment.author.picture??>deffault/user.jpg<#else>user/${comment.author.picture}</#if>"  style="height:64px;width:64px;" class="mr-3" alt="...">			
  		</a>
  		<div class="media-body">
  		<strong>${comment.author.username}</strong> <small>${comment.publishDate}</small>
  		<h5 class="mt-0">
    		${comment.text}
    	</h5>		
    				<p class="my-3">
    				<form method="post" action="/cities/${pov.city.id}/povs/${pov.id}/${comment.id}/delete">
  						<input type="hidden" name="_csrf" value="${_csrf.token}" />
  						<button class="badge badge-pill badge-primary" type="button" data-toggle="collapse" data-target="#collapseExample${comment.id}" aria-expanded="false" aria-controls="collapseExample${comment.id}">	
							<@spring.message "lang.button.pov.reply"/>
  						</button>
  						<#if isAdmin >
  						<a class="badge badge-pill badge-info" >
  							<@spring.message "lang.button.edit"/> 
  						</a>
  						<#if isAdmin || user==city.author>
  							<button class="badge badge-pill badge-danger" type="submit">
  								<@spring.message "lang.button.delete"/> 
  							</button>
  						</#if>
  						</#if>
  					</form>
  						
					</p>
					<div class="collapse " id="collapseExample${comment.id}">
						<form lass="mb-5" method="post" action="/cities/${pov.city.id}/povs/${pov.id}/addCommentReply">
  							<input type="hidden" name="_csrf" value="${_csrf.token}" />
  							<input type="hidden" name="comment_id" value="${comment.id}" />
  							<div class="row">
  								<div class="col-10">
  									<textarea name="text" class="form-control" id="exampleFormControlTextarea1" rows="2"  ></textarea>
  								</div>
  								<div class="col">
  									<button type="submit" class="badge badge-pill badge-primary mb-2"><@spring.message "lang.button.pov.leave"/></button>
  								</div>
  							</div>
						</form>
					</div>
			
			<#if  !comment.noReply()>
			<p class="my-3">
  						<button class="badge badge-pill badge-secondary" type="button" data-toggle="collapse" data-target="#collapseExample${comment.id}_" aria-expanded="false" aria-controls="collapseExample${comment.id}_">	
							<@spring.message "lang.button.pov.comment.show"/>
  						</button>
			</p>
			</#if>
			<div class="collapse " id="collapseExample${comment.id}_">
    		<#list comment.comments as ch_comment>
    		<div class="media mt-3">
      			<a class="mr-3" href="#">
        			<img src="/img/<#if !ch_comment.author.picture??>deffault/user.jpg<#else>user/${ch_comment.author.picture}</#if>"  style="height:64px;width:64px;" class="mr-3" alt="...">
        			
      			</a>
      			<div class="media-body">
      			<strong>${ch_comment.author.username}</strong> <small>${ch_comment.publishDate}</small>
       			<h5 class="mt-0">
    				${ch_comment.text}
    			</h5>
      			</div>
    		</div>
    		<form method="post" action="/cities/${pov.city.id}/povs/${pov.id}/${ch_comment.id}/delete">
  				<input type="hidden" name="_csrf" value="${_csrf.token}" />
  				
  				<#if isAdmin>
  				<a class="badge badge-pill badge-info" >
  					<@spring.message "lang.button.edit"/> 
  				</a>
  				<#if isAdmin || user==city.author>
  				<button class="badge badge-pill badge-danger" type="submit">
  					<@spring.message "lang.button.delete"/> 
  				</button>
  				</#if>
  				</#if>
  			</form>
    		</#list>
    		</div>
  		</div>
	</div>
	</#if>
	<#else>
		<@spring.message "lang.list.no.comments"/>
	</#list>
	<#else>
		<div class="text-center">
			<h1 class="mt-5" >Publication is not published</h1>
		</div>
	</#if>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDBJKqu2hNvTX8wm-PfhFK9Zn42TVxs_eo" async defer></script>
<script src="/static/js/restApiSearchPhotos.js" async defer ></script>

</@c.common>