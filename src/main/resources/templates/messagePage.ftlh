<#import "parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/login"><@spring.message "lang.breadcrumb.signIn"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.messagePage"/></li>
  </ol>
</nav
<#if successfulRegistr??>
	<span class="align-text-center h2"><@spring.message "lang.user.message.activationCode"/></span>
<#elseif successfulReset??>
	<span class="align-text-center h2"><@spring.message "lang.user.error.passwordReset"/></span>
<#elseif unsuccessfulReset??>
	<span class="align-text-center h2"><@spring.message "lang.user.right.passwordReset"/></span>
</#if>

</@c.common>