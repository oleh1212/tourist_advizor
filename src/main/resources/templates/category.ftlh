<#import "parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>

<@c.common>
<nav aria-label="breadcrumb">
  <ol class="breadcrumb">
    <li class="breadcrumb-item"><a href="/"><@spring.message "lang.breadcrumb.home"/></a></li>
    <li class="breadcrumb-item active" aria-current="page"><@spring.message "lang.breadcrumbcategories"/></li>
  </ol>
</nav>
	<table class="table">
  		<thead class="thead-dark">
    		<tr>
      			<th scope="col"><a class="badge badge-light" href="">Id</a></th>
      			<th scope="col"><a class="badge badge-light" href=""><@spring.message "lang.categories"/></a></th>
      			<th scope="col" ><a class="badge badge-dark" href="#"><@spring.message "lang.action"/></a></th>
    		</tr>
  		</thead>
 
  		<tbody>
  			<#list categories as category>
    			<tr>
    				<form action="category/${category.id}" method="post">
    				<input type="hidden" name="_csrf" value="${_csrf.token}" />
      				<th scope="row" >${category.id}</th>
      				<th scope="row" ><input  class="form-control"  type="text" name="type" value="${category.type}"/></th>
      				<td scope="row">
      					
      						<button type="submit" class="btn btn-info col mb-1" ><@spring.message "lang.button.update"/></button>
      				</form>
      				</td>
    			</tr>
    		<#else>
    			No users
    		</#list>
		</tbody>	
	</table>
	<form method="post" action="/categories">
  		<div class="form-row align-items-center">
    		<div class="col-sm-3 my-1">
      			<input type="text" name="type" class="form-control " id="inlineFormInputName" placeholder="<@spring.message "lang.input.category"/>">
    		</div>
    		<input type="hidden" name="_csrf" value="${_csrf.token}" />
    		<div class="col-auto my-1">
      			<button type="submit" class="btn btn-primary"><@spring.message "lang.button.add"/></button>
    		</div>
  		</div>
	</form>
</@c.common>