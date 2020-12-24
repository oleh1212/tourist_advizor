<#macro rating id name selected>
<div class="starrating risingstar d-flex justify-content-center flex-row-reverse">
	<#list 5..1 as x>
		<input type="radio" <#if selected==x>checked</#if> id="${id}${x}" name="${name}" value="${x}" /><label for="${id}${x}" title="${x} star">${x}</label>
	</#list>
</div>
</#macro>