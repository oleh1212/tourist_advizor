<#import "parts/common.ftlh" as c/>
<#import "/spring.ftl" as spring/>
<#import "parts/raiting.ftlh" as r>
<@c.common>

<@r.rating "sta" "sta" 0 />
<@r.rating "st" "st" 0 />
<@r.rating "s" "star" 0 />
<@r.rating "star" "stars" 0 />
<#list categories as category>
	${category.name}
</#list>
        


<script src="/static/js/test.js" async defer></script>	

</@c.common>