<#import "../parts/common.ftlh" as c>
<#import "/spring.ftl" as spring/>
<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumb.users"/></li>
  </ol>
</nav>
	<table class="table">
  		<thead class="thead-dark">
    		<tr>
      			<th scope="col"><a class="badge badge-<#if sort=='id'>light<#else>dark</#if>" href="/users?sort=id">Id</a></th>
      			<th scope="col"><a class="badge badge-<#if sort=='username'>light<#else>dark</#if>" href="/users?sort=username"><@spring.message "lang.button.user.username"/></a></th>
      			<th scope="col"><a class="badge badge-<#if sort=='email'>light<#else>dark</#if>" href="/users?sort=email"><@spring.message "lang.button.user.email"/></a></th>
      			<th scope="col" ><a class="badge badge-dark" href="#"><@spring.message "lang.button.user.role"/></a></th>
      			<th scope="col" ><a class="badge badge-dark" href="#"><@spring.message "lang.action"/></a></th>
    		</tr>
  		</thead>
 
  		<tbody>
  			<#list users as user>
    			<tr>
      				<th scope="row" >${user.id}</th>
      				<th scope="row" >${user.username}</th>
      				<th scope="row" >${user.email}</th>
      				<td scope="row"><#list user.roles as role> ${role}<#sep>, </#list></td>
      				<td scope="row">
      					<form action="users/profile/${user.id}" method="get">
      						<button type="submit" class="btn btn-info col mb-1" ><@spring.message "lang.button.update"/></button>
      					</form>
      					<form  action="users/delete" method="post">
      						<input type="hidden" name="_csrf" value="${_csrf.token}" />
      						<input type="hidden" name="id" value="${user.id}" />
      						<button type="submit" class="btn btn-danger col mt-1" onclick="if(!(confirm('Are you sure you want to delit this user?'))) return false"><@spring.message "lang.button.delete"/></button>
      					</form>

      				</td>
    			</tr>
    		<#else>
    			<@spring.message "lang.list.no.users"/>
    		</#list>
		</tbody>	
	</table>
</@c.common>
