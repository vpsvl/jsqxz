import{u as C,e as b,f as w,r as B,o as s,c as $,w as _,a as t,t as a,z as h,b as n,d as i,F as d,j as g,x as m}from"./index.fbdaa08c.js";import N from"./internal.d649e49d.js";import V from"./fly.c428b56a.js";const z={class:"v-table v-table-vertical"},E={class:"tr"},F=t("div",{class:"td"},"\u79D8\u7C4D",-1),j={class:"td"},D={class:"td"},L={class:"td"},R={class:"tr"},S=t("div",{class:"td"},"\u4E3B\u8FD0\u6548\u679C",-1),T={class:"td"},q={class:"td-block"},A=["textContent"],G={class:"tr"},H=t("div",{class:"td"},"\u5176\u4ED6",-1),I={class:"td"},J={key:0},K=m(" [ "),M={class:"color-error"},O=m(" ]: "),P={class:"color-success"},Q=["textContent"],Z={__name:"internal",setup(U){const p=C(),v={internal:N,fly:V},x={get:"\u83B7\u53D6\u65B9\u5F0F",power:"\u5A01\u529B",condition:"\u4FEE\u70BC\u6761\u4EF6",addition:"\u4FEE\u70BC\u52A0\u6210"},o=b({});return w(()=>{o.value={list:[]};const{type:r}=p.meta,u=v[r]?v[r]:{list:[]};o.value=u}),(r,u)=>{const k=B("v-tabs");return s(),$(k,{list:o.value.list,exclusive:o.value.exclusive},{tab:_(({tab:e})=>[t("span",{class:h({[`level-${e.level}`]:e.level,[`internal-${e.internal}`]:e.internal})},a(e.name),3)]),title:_(({info:e})=>[t("span",{class:h([`level-${e.level}`,{[`internal-${e.internal}`]:e.internal}])},a(e.name),3)]),default:_(({info:e})=>[t("div",z,[t("div",E,[F,t("div",j,[t("span",null,a(e.cheat?e.cheat:e.name),1)])]),(s(),n(d,null,i(x,(l,c)=>t("div",{class:"tr",key:c},[t("div",D,a(l),1),t("div",L,a(e[c]),1)])),64)),t("div",R,[S,t("div",T,[t("div",q,[(s(!0),n(d,null,i(e.initiative,(l,c)=>(s(),n("div",{class:"td-effect-item",key:c,textContent:a(l)},null,8,A))),128))])])]),t("div",G,[H,t("div",I,[(s(!0),n(d,null,i(e.peculiar,(l,c)=>(s(),n("div",{class:"td-block",key:c},[l.name?(s(),n("div",J,[K,t("span",M,a(l.name),1),O,t("span",P,a(l.condition),1)])):g("",!0),(s(!0),n(d,null,i(l.effect,(f,y)=>(s(),n("div",{class:"td-effect-item",key:y,textContent:a(f)},null,8,Q))),128))]))),128))])])])]),_:1},8,["list","exclusive"])}}};export{Z as default};
