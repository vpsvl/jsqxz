import{u as E,e as k,f as y,o as s,b as a,a as t,t as _,F as i,d as n,j as p,x as d,k as o}from"./index.e4edb047.js";function b(u){switch(u){case"../../data/sect/gaibang.js":return o(()=>import("./gaibang.53cc5727.js"),[]);case"../../data/sect/huashan.js":return o(()=>import("./huashan.d1325182.js"),[]);case"../../data/sect/mizong.js":return o(()=>import("./mizong.92110e19.js"),[]);case"../../data/sect/shaolin.js":return o(()=>import("./shaolin.c6e9128e.js"),[]);case"../../data/sect/tianji.js":return o(()=>import("./tianji.1b657bbf.js"),[]);case"../../data/sect/tianlong.js":return o(()=>import("./tianlong.81353b41.js"),[]);case"../../data/sect/wudang.js":return o(()=>import("./wudang.10f4b656.js"),[]);case"../../data/sect/xiaoyao.js":return o(()=>import("./xiaoyao.dfcf997d.js"),[]);case"../../data/sect/xingxiu.js":return o(()=>import("./xingxiu.cd2507a6.js"),[]);case"../../data/sect/xuedao.js":return o(()=>import("./xuedao.02fec400.js"),[]);default:return new Promise(function(m,c){(typeof queueMicrotask=="function"?queueMicrotask:setTimeout)(c.bind(null,new Error("Unknown variable dynamic import: "+u)))})}}const j={class:"v-table v-table-vertical"},P={class:"tr"},V=t("div",{class:"td"},"\u540D\u79F0",-1),D={class:"td"},R={class:"tr"},T=t("div",{class:"td"},"\u7279\u6280",-1),I={class:"td"},L={class:"td-block"},A={class:"tr"},O=t("div",{class:"td"},"\u5929\u8D4B",-1),g={class:"td"},x={key:0},w=d(" [ "),N={class:"color-error"},B=d(" ]: "),q={class:"color-success"},C={class:"tr"},F=t("div",{class:"td"},[t("div",{class:"td-block"},"\u6B66\u529F"),t("div",{class:"td-block"},"\uFF08NPC\u5904\u521D\u9636\u4E2D\u9636\u9AD8\u9636\u53EF\u4EE5\u4E00\u8109\u76F8\u627F\uFF0C\u7EDD\u5B66\u9664\u8F7B\u529F\u5916\u90FD\u4E0D\u80FD\u4E00\u8109\u76F8\u627F\uFF09")],-1),M={class:"td"},z={key:0},S=d(" [ "),U={class:"color-error"},$=d(" ]: "),H={__name:"sect",setup(u){const m=E(),c=k({});return y(async()=>{const{name:h,meta:{type:f}}=m;if(!!/sect/i.test(h))try{const e=await b(`../../data/sect/${f}.js`);c.value=e.default}catch{c.value={}}}),(h,f)=>(s(),a("div",j,[t("div",P,[V,t("div",D,_(c.value.name),1)]),t("div",R,[T,t("div",I,[t("div",L,[(s(!0),a(i,null,n(c.value.effect,(e,r)=>(s(),a("div",{class:"td-effect-item effect-icon-star",key:r},_(e),1))),128))])])]),t("div",A,[O,t("div",g,[(s(!0),a(i,null,n(c.value.talent,(e,r)=>(s(),a("div",{class:"td-block",key:r},[e.name?(s(),a("div",x,[w,t("span",N,_(e.name),1),B,t("span",q,_(e.condition),1)])):p("",!0),(s(!0),a(i,null,n(e.effect,(l,v)=>(s(),a("div",{class:"td-effect-item effect-icon-rhombus",key:v},_(l),1))),128))]))),128))])]),t("div",C,[F,t("div",M,[(s(!0),a(i,null,n(c.value.martial,(e,r)=>(s(),a("div",{class:"td-block",key:r},[e.name?(s(),a("div",z,[S,t("span",U,_(e.name),1),$])):p("",!0),(s(!0),a(i,null,n(e.list,(l,v)=>(s(),a("div",{class:"td-effect-item",key:v},_(l),1))),128))]))),128))])])]))}};export{H as default};
