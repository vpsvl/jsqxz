import{u as C,e as b,f as w,r as B,o as s,c as $,w as _,a as t,t as a,z as h,b as o,d as c,F as i,j as g,x as m}from"./index.369cc87c.js";import N from"./internal.e0b7a01e.js";import V from"./fly.5e9d8826.js";const z={class:"v-table v-table-vertical"},E={class:"td"},F={class:"td"},j={class:"tr"},D=t("div",{class:"td"},"\u4E3B\u8FD0\u6548\u679C",-1),L={class:"td"},R={class:"td-block"},S=["textContent"],T={class:"tr"},q=t("div",{class:"td"},"\u5176\u4ED6",-1),A={class:"td"},G={key:0},H=m(" [ "),I={class:"color-error"},J=m(" ]: "),K={class:"color-success"},M=["textContent"],W={__name:"internal",setup(O){const p=C(),v={internal:N,fly:V},f={get:"\u83B7\u53D6\u65B9\u5F0F",power:"\u5A01\u529B",condition:"\u4FEE\u70BC\u6761\u4EF6",addition:"\u4FEE\u70BC\u52A0\u6210"},r=b({});return w(()=>{const{type:d}=p.meta,u=v[d]?v[d]:{list:[]};r.value=u}),(d,u)=>{const x=B("v-tabs");return s(),$(x,{list:r.value.list,exclusive:r.value.exclusive},{tab:_(({tab:e})=>[t("span",{class:h({[`level-${e.level}`]:e.level,[`internal-${e.internal}`]:e.internal})},a(e.name),3)]),title:_(({info:e})=>[t("span",{class:h([`level-${e.level}`,{[`internal-${e.internal}`]:e.internal}])},a(e.name),3)]),default:_(({info:e})=>[t("div",z,[(s(),o(i,null,c(f,(n,l)=>t("div",{class:"tr",key:l},[t("div",E,a(n),1),t("div",F,a(e[l]),1)])),64)),t("div",j,[D,t("div",L,[t("div",R,[(s(!0),o(i,null,c(e.initiative,(n,l)=>(s(),o("div",{class:"td-effect-item",key:l,textContent:a(n)},null,8,S))),128))])])]),t("div",T,[q,t("div",A,[(s(!0),o(i,null,c(e.peculiar,(n,l)=>(s(),o("div",{class:"td-block",key:l},[n.name?(s(),o("div",G,[H,t("span",I,a(n.name),1),J,t("span",K,a(n.condition),1)])):g("",!0),(s(!0),o(i,null,c(n.effect,(k,y)=>(s(),o("div",{class:"td-effect-item",key:y,textContent:a(k)},null,8,M))),128))]))),128))])])])]),_:1},8,["list","exclusive"])}}};export{W as default};
