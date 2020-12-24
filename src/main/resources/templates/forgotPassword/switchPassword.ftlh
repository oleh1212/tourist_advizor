<#import "../parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/login"><@spring.message "lang.breadcrumb.signIn"/></a></li>
    <li class="breadcrumb-item"><a href="/login"><@spring.message "lang.breadcrumb.account.record"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.password.reset"/></li>
  </ol>
</nav>
	<form method="post" >
  		<div class="form-group">
    		<label for="exampleInputPassword1"><@spring.message "lang.button.user.password"/></label>
    		<input type="password" class="form-control<#if passwordError?? || passwordsError??> is-invalid</#if>" name="password" id="exampleInputPassword1">
  			<#if passwordError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.password.empty"/>
                </div>
            <#elseif passwordsError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.passwords.defferent"/>
                </div>
            </#if>
  		</div>
 		 <div class="form-group">
    		<label for="exampleInputPassword1"><@spring.message "lang.button.user.passwordConfirm"/></label>
    		<input type="password" class="form-control<#if password2Error?? || passwordsError??> is-invalid</#if>" name="password2" id="exampleInputPassword1">
  			<#if password2Error??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.passwordConfirm.empty"/>
                </div>
            <#elseif passwordsError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.passwords.defferent"/>
                </div>
            </#if>
  		</div>
  		<input type="hidden" name="_csrf" value="${_csrf.token}" />
  		<button type="submit" class="btn btn-primary"><@spring.message "lang.button.submit"/></button>
	</form>
</@c.common>