<#import "parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.signIn"/></li>
  </ol>
</nav>
<#if successful??>
	<div class="alert alert-success" role="alert">
    	<@spring.message "lang.user.success.activationCode"/>
    </div>
<#elseif unsuccessful??>
	<div class="alert alert-warning" role="alert">
    	<@spring.message "lang.user.warning.activationCode"/>
    </div>
<#elseif Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
	<div class="alert alert-danger" role="alert">
    	<@spring.message "lang.user.error.signIn.wrong"/>
    </div>
</#if>
<form method="post" action="/login">
  <div class="form-group">
    <label for="exampleInputUsername1"><@spring.message "lang.button.user.username"/></label>
    <input type="text" class="form-control" id="exampleInputUsername1" aria-describedby="usernamelHelp" name="username">
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1"><@spring.message "lang.button.user.password"/></label>
    <input type="password" class="form-control" id="exampleInputPassword1" name="password">
  </div>
  <input type="hidden" name="_csrf" value="${_csrf.token}" />
  <button type="submit" class="btn btn-primary"><@spring.message "lang.button.signIn"/></button>
  <a class="btn btn-primary" href="/registration"><@spring.message "lang.button.signUp"/></a>
</form>
<div class="mt-2">
  <a href="/forgotPassword" class="card-link" ><@spring.message "lang.user.message.forgotPassword"/></a>
</div>
</@c.common>