import{u as V,i as y,e as I,f as L,r as O,o as e,c as P,w as v,b as a,d,a as c,t as l,F as u,x as E,l as t}from"./index.e7b3afaa.js";import{_ as T}from"./dynamic-import-helper.76d38ac2.js";const A=E(" [ "),b={class:"color-error"},h=E(" ]: "),k={class:"td-block"},B={__name:"book",setup(x){const f=V(),r=y("state"),j=[{key:"name",name:"\u540D\u79F0"},{key:"talent",name:"\u5929\u8D4B"},{key:"fortune",name:"\u798F\u7F18\u9645\u9047"}],o=I([]);return L(async()=>{const{name:p,meta:{type:m}}=f;if(!!/person/i.test(p))try{o.value=[],r.loading=!0;const _=await T(Object.assign({"../../data/person/bai.js":()=>t(()=>import("./bai.783f9571.js"),[]),"../../data/person/bi.js":()=>t(()=>import("./bi.dc2a5027.js"),[]),"../../data/person/fei.js":()=>t(()=>import("./fei.88afc655.js"),[]),"../../data/person/lian.js":()=>t(()=>import("./lian.7de1974d.js"),[]),"../../data/person/lu.js":()=>t(()=>import("./lu.44751d8b.js"),[]),"../../data/person/she.js":()=>t(()=>import("./she.0e293d27.js"),[]),"../../data/person/shen.js":()=>t(()=>import("./shen.8e0dfa58.js"),[]),"../../data/person/shu.js":()=>t(()=>import("./shu.c6175e60.js"),[]),"../../data/person/special.js":()=>t(()=>import("./special.29961f43.js"),[]),"../../data/person/tian.js":()=>t(()=>import("./tian.3060f921.js"),[]),"../../data/person/xia.js":()=>t(()=>import("./xia.a2362cc0.js"),[]),"../../data/person/xiao.js":()=>t(()=>import("./xiao.f97faed0.js"),[]),"../../data/person/xue.js":()=>t(()=>import("./xue.ddac5e45.js"),[]),"../../data/person/yi.js":()=>t(()=>import("./yi.d4b504a4.js"),[]),"../../data/person/yuan.js":()=>t(()=>import("./yuan.4abdb4dc.js"),[])}),`../../data/person/${m}.js`);o.value=_.default.list,r.loading=!1}catch{o.value=[],r.loading=!1}}),(p,m)=>{const _=O("v-table");return e(),P(_,{class:"v-table-person",cols:j,data:o.value},{talent:v(({row:n})=>[(e(!0),a(u,null,d(n.talent,(s,i)=>(e(),a("div",{class:"td-block",key:i},[c("div",null,[A,c("span",b,l(s.name),1),h]),(e(!0),a(u,null,d(s.effect,(D,R)=>(e(),a("div",{class:"td-effect-item effect-icon-star",key:R},l(D),1))),128))]))),128))]),fortune:v(({row:n})=>[c("div",k,[(e(!0),a(u,null,d(n.fortune,(s,i)=>(e(),a("div",{class:"td-effect-item effect-icon-heart",key:i},l(s),1))),128))])]),_:1},8,["data"])}}};export{B as default};
