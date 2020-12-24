<#import "../parts/common.ftlh" as c>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/">Home</a></li>
    <li class="breadcrumb-item active" aria-current="page">${user.username?cap_first}'s profile</li>
  </ol>
</nav>
    <h5>${user.username}</h5>
    	<div class="mb-3">
    		<img style="height:200px; weight:200px" src="/img/<#if !user.picture??>deffault/user.jpg<#else>user/${user.picture}</#if>">
    	</div>
    <form method="post" enctype="multipart/form-data" >
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "lang.button.user.password"/>:</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control ${(passwordsError??)?string('is-invalid', '') }" placeholder="<@spring.message "lang.button.user.password"/>" />
            </div>
            <#if passwordsError??>
            	<div class="invalid-feedback">
                	<@spring.message "lang.user.error.passwords.defferent"/>
                </div>
            </#if>
        </div>
  		<div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "lang.button.user.passwordConfirm"/>:</label>
            <div class="col-sm-6 ">
                <input type="password" name="password2" class="form-control <#if password2Error?? || passwordsError??>is-invalid</#if>" placeholder="<@spring.message "lang.button.user.passwordConfirm"/>" />
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
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "lang.button.user.email"/>:</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="<@spring.message "lang.placeholder.example.webSite"/>some@some.com" value="${user.email}" />
            </div>
        </div>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"><@spring.message "lang.picture"/>:</label>
            <div class="col-sm-6 ml-3">
                <input type="file" name="file" class="custom-file-input" id="validatedCustomFile"/>
       			<label class="custom-file-label" for="validatedCustomFile"><@spring.message "lang.label.file"/></label>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}" />
        <button class="btn btn-primary" type="submit"><@spring.message "lang.button.save"/></button>
    </form>
</@c.common>