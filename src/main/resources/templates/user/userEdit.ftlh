<#import "../parts/common.ftlh" as c>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item"><a href="/users"><@spring.message "lang.breadcrumb.users"/></a></li>
    <li class="breadcrumb-item active" aria-current="page">${user.username?cap_first} edit</li>
  </ol>
</nav>
    <form  method="post">
        <div class="form-group mb-3">
            <label for="exampleFormControlInput1"><@spring.message "lang.button.user.username"/></label>
            <input type="text" name="username" class="form-control col-sm-3" id="exampleFormControlInput1" value="${user.username}"/>
        </div>
        <#list roles as role>
            <div>
                <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")} />${role}</label>
            </div>
        </#list>
        <input type="hidden" value="${user.id}" name="userId"/>
        <input type="hidden" value="${_csrf.token}" name="_csrf"/>
        <button type="submit" class="btn btn-primary"><@spring.message "lang.button.save"/></button>
        <a href="/users"><@spring.message "lang.button.user.backto"/></a>
    </form>
</@c.common>