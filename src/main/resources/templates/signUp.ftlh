<#import "parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
	<nav aria-label="breadcrumb">
  		<ol class="breadcrumb">
    		<li class="breadcrumb-item"><a href="/login"><@spring.message "lang.breadcrumb.signIn"/></a></li>
    		<li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.signUp"/></li>
  		</ol>
	</nav>
	<form method="post"  action="/registration">
		<div class="form-group" >
    		<label for="exampleInputUsername1"><@spring.message "lang.button.user.username"/></label>
    		<input type="text"  id="exampleInputUsername1" name="username" value="<#if user??>${user.username}</#if>"
    			class="form-control <#if usernameError?? || usernameError??>is-invalid</#if>" placeholder="<@spring.message "lang.button.user.username"/>" />
    		<#if usernameError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.username.empty"/>
                </div>
            <#elseif usernameExistError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.username.exists"/>
                </div>
            </#if>
  		</div>
		<div class="form-group">
    		<label for="exampleInputPassword1"><@spring.message "lang.button.user.password"/></label>
    		<input type="password"  id="exampleInputPassword1" name="password" 
    		class="form-control <#if passwordError?? || passwordsError??>is-invalid</#if>" placeholder="<@spring.message "lang.button.user.password"/>" />
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
    		<input type="password"  id="exampleInputPassword1" name="password_conf" 
    		class="form-control <#if password2Error?? || passwordsError??>is-invalid</#if>" placeholder="<@spring.message "lang.button.user.passwordConfirm"/>"/>
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
  		<div class="form-group">
    		<label for="exampleInputEmail1"><@spring.message "lang.button.user.email"/></label>
    		<input type="email"  id="exampleInputEmail1" aria-describedby="emailHelp" name="email" value="<#if user??>${user.email}</#if>"
    		class="form-control ${(emailError??)?string('is-invalid', '') }" placeholder="<@spring.message "lang.button.user.email"/>" />
    		<#if emailError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.email.empty"/>
                </div>
            </#if>
  		</div>
  		<div class="form-group">
  			<div class="g-recaptcha" data-sitekey="6Lc8O9gUAAAAAJDLMzIIcWSSMR-ttnnbiNB4OB4n"></div>
  			<#if captchaError??>
            	<div class="alert alert-danger" role="alert">
                	<@spring.message "lang.user.error.captcha.empty"/>
                </div>
            </#if>
  		</div>
  		<input type="hidden" name="_csrf" value="${_csrf.token}" />
  <button type="submit" class="btn btn-primary"><@spring.message "lang.button.signUp"/></button>
</form>
</@c.common>
