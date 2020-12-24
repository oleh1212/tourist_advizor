<#import "../parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/login"><@spring.message "lang.breadcrumb.signIn"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.account.record"/></li>
  </ol>
</nav>
	<form method="post" action="/forgotPassword">
  		<div class="form-group">
    		<label for="exampleInputEmail1"><@spring.message "lang.button.user.email"/></label>
    		<input type="email" class="form-control <#if wrongEmail??>is-invalid<#elseif rightEmail??>is-valid</#if>" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="<@spring.message "lang.button.user.email"/>" name="email" >
    		<#if wrongEmail??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.email"/>
                </div>
            <#elseif rightEmail??>
            	<div class="valid-feedback">
                	<@spring.message "lang.user.right.email"/>
                </div>
            </#if>
  		</div>
  		<input type="hidden" name="_csrf" value="${_csrf.token}" />
 		<button type="submit" class="btn btn-primary"><@spring.message "lang.button.submit"/></button>
	</form>
</@c.common>