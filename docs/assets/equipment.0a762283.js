import{u as l,e as p,f,r as v,o as s,c as E,w as y,b as u,d as g,t as k,F as b,k as e}from"./index.369cc87c.js";function w(a){switch(a){case"../../data/goods/armor.js":return e(()=>import("./armor.40ff465b.js"),[]);case"../../data/goods/drug.js":return e(()=>import("./drug.57f8348e.js"),[]);case"../../data/goods/fist.js":return e(()=>import("./fist.4506ff56.js"),[]);case"../../data/goods/knife.js":return e(()=>import("./knife.dd31f48e.js"),[]);case"../../data/goods/mount.js":return e(()=>import("./mount.60edc5a1.js"),[]);case"../../data/goods/special.js":return e(()=>import("./special.b283df37.js"),[]);case"../../data/goods/sword.js":return e(()=>import("./sword.266bc594.js"),[]);default:return new Promise(function(n,o){(typeof queueMicrotask=="function"?queueMicrotask:setTimeout)(o.bind(null,new Error("Unknown variable dynamic import: "+a)))})}}const P={__name:"equipment",setup(a){const n=l(),o=[{key:"name",name:"\u540D\u79F0"},{key:"get",name:"\u83B7\u53D6\u65B9\u5F0F"},{key:"condition",name:"\u88C5\u5907\u9700\u6C42"},{key:"addition",name:"\u52A0\u6210"},{key:"effect",name:"\u7279\u6548"}],r=p([]);return f(async()=>{const{name:_,meta:{type:i}}=n;if(!!/goods/i.test(_))try{const t=await w(`../../data/goods/${i}.js`);r.value=t.default.list}catch{r.value=[]}}),(_,i)=>{const t=v("v-table");return s(),E(t,{class:"v-table-equipment",cols:o,data:r.value},{"td-effect":y(({row:c})=>[(s(!0),u(b,null,g(c.effect,(d,m)=>(s(),u("div",{class:"td-block",key:m},k(d),1))),128))]),_:1},8,["data"])}}};export{P as default};
