import{u as R,i as V,e as I,f as L,r as O,o as t,c as P,w as v,b as a,d,a as u,t as c,F as l,y as E,m as e}from"./index.6bd9c542.js";import{_ as T}from"./dynamic-import-helper.76d38ac2.js";const A=E(" [ "),b={class:"color-error"},h=E(" ]: "),k={class:"td-block"},B={__name:"book",setup(x){const f=R(),r=V("loading"),j=[{key:"name",name:"\u540D\u79F0"},{key:"talent",name:"\u5929\u8D4B"},{key:"fortune",name:"\u798F\u7F18\u9645\u9047"}],o=I([]);return L(async()=>{const{name:p,meta:{type:m}}=f;if(!!/person/i.test(p))try{o.value=[],r.value=!0;const _=await T(Object.assign({"../../data/person/bai.js":()=>e(()=>import("./bai.6e10e997.js"),[]),"../../data/person/bi.js":()=>e(()=>import("./bi.fdd39010.js"),[]),"../../data/person/fei.js":()=>e(()=>import("./fei.442692d4.js"),[]),"../../data/person/lian.js":()=>e(()=>import("./lian.c910342b.js"),[]),"../../data/person/lu.js":()=>e(()=>import("./lu.724abdf3.js"),[]),"../../data/person/she.js":()=>e(()=>import("./she.5a9f76be.js"),[]),"../../data/person/shen.js":()=>e(()=>import("./shen.af73c483.js"),[]),"../../data/person/shu.js":()=>e(()=>import("./shu.aa1fc237.js"),[]),"../../data/person/special.js":()=>e(()=>import("./special.a57006cd.js"),[]),"../../data/person/tian.js":()=>e(()=>import("./tian.c6fef06b.js"),[]),"../../data/person/xia.js":()=>e(()=>import("./xia.34b8b141.js"),[]),"../../data/person/xiao.js":()=>e(()=>import("./xiao.e1184564.js"),[]),"../../data/person/xue.js":()=>e(()=>import("./xue.0212cc91.js"),[]),"../../data/person/yi.js":()=>e(()=>import("./yi.18b32958.js"),[]),"../../data/person/yuan.js":()=>e(()=>import("./yuan.c19cd076.js"),[])}),`../../data/person/${m}.js`);o.value=_.default.list,r.value=!1}catch{o.value=[],r.value=!1}}),(p,m)=>{const _=O("v-table");return t(),P(_,{class:"v-table-person",cols:j,data:o.value},{"td-talent":v(({row:n})=>[(t(!0),a(l,null,d(n.talent,(s,i)=>(t(),a("div",{class:"td-block",key:i},[u("div",null,[A,u("span",b,c(s.name),1),h]),(t(!0),a(l,null,d(s.effect,(y,D)=>(t(),a("div",{class:"td-effect-item effect-icon-star",key:D},c(y),1))),128))]))),128))]),"td-fortune":v(({row:n})=>[u("div",k,[(t(!0),a(l,null,d(n.fortune,(s,i)=>(t(),a("div",{class:"td-effect-item effect-icon-heart",key:i},c(s),1))),128))])]),_:1},8,["data"])}}};export{B as default};
