
<#import "/spring.ftl" as spring/>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
  <a class="navbar-brand" href="#">Tourist Advisor</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
   	  <li class="nav-item">
        	<a class="nav-link" href="/"><@spring.message "lang.home"/></a>
      </li>
      <#if name!="unknown">
      <li class="nav-item">
        	<a class="nav-link" href="/countries"><@spring.message "lang.country"/></a>
      </li>
      <li class="nav-item dropdown">
      	<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        	<@spring.message "lang.city"/>
        </a>
        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        	<a class="dropdown-item" href="/cities"><@spring.message "lang.cities"/></a>
        	<a class="dropdown-item" href="/cities/add"><@spring.message "lang.button.city.add"/></a> 
        </div>
      </li>
      
      	<li class="nav-item">
        	<a class="nav-link" href="/cities/pov/add"><@spring.message "lang.button.pov.add"/></a>
      	</li>
      </#if>
      <#if isAdmin>
      	<li class="nav-item">
        	<a class="nav-link" href="/users"><@spring.message "lang.user"/></a>
      	</li>
      	<li class="nav-item">
        	<a class="nav-link" href="/categories"><@spring.message "lang.categories"/></a>
      	</li>
      </#if>
      
    </ul>


		<div class="nav-item btn-group mr-3 ">
  	
    		<img style="height:20px; weight:20px" src="<@spring.message "label.locale"/>"   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">

  		<div class="dropdown-menu  " >
  			<form mrthod="get">
  				<button class="dropdown-item w-30"   name="lang" value="en" type="submit"><img style="height:20px; weight:20px" src="<@spring.message "label.locale.eng"/>"/></button>
  				<button class="dropdown-item" name="lang" value="fr" type="submit"><img style="height:20px; weight:20px" src="<@spring.message "label.locale.fr"/>"/></button>
  				<button class="dropdown-item" name="lang" value="ua" type="submit"><img style="height:20px; weight:20px" src="<@spring.message "label.locale.ua"/>"/></button>
  				<button class="dropdown-item" name="lang" value="ru" type="submit"><img style="height:20px; weight:20px" src="<@spring.message "label.locale.ru"/>"/></button>
			</form>
		</div>
  		</div>
  		<#if name=="unknown">
    	<div class="mt-2 my-sm-0">
  				<a href="/login"  style="color:white;" class="alert-link" ><@spring.message "lang.button.signIn"/></a>
		</div>
    	<#else>
    	<div class="nav-item btn-group my-2 ">
    		<img class="round" src="/img/<#if !user.picture??>deffault/user.jpg<#else>user/${user.picture}</#if>"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" />
  			<div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu2">
        		<a class="dropdown-item " href="/users/profile"><@spring.message "lang.profile"/></a>
        		<a class="dropdown-item " href="/users/${currentUserId}"><@spring.message "lang.profile.publication"/></a>
  				<form action="/logout" method="post">
    				<input type="hidden" name="_csrf" value="${_csrf.token}" />
            		<input class="dropdown-item" type="submit" value="<@spring.message "lang.button.signOut"/>"/>
        		</form>
			</div>
  		</div>
    	</#if>

  </div>
</nav>
