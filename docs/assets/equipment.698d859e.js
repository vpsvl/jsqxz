import{u as m,i as p,e as v,f,r as g,o as s,c as E,w as y,b as r,d as k,t as j,F as D,l as e}from"./index.1bbaf453.js";import{_ as R}from"./dynamic-import-helper.76d38ac2.js";const O={__name:"equipment",setup(b){const i=m(),o=p("loading"),d=[{key:"name",name:"\u540D\u79F0"},{key:"get",name:"\u83B7\u53D6\u65B9\u5F0F"},{key:"condition",name:"\u88C5\u5907\u9700\u6C42"},{key:"addition",name:"\u52A0\u6210"},{key:"effect",name:"\u7279\u6548"}],t=v([]);return f(async()=>{const{name:_,meta:{type:n}}=i;if(!!/goods/i.test(_))try{t.value=[],o.value=!0;const a=await R(Object.assign({"../../data/goods/armor.js":()=>e(()=>import("./armor.cf7cfd58.js"),[]),"../../data/goods/drug.js":()=>e(()=>import("./drug.0241705d.js"),[]),"../../data/goods/fist.js":()=>e(()=>import("./fist.44e7c524.js"),[]),"../../data/goods/knife.js":()=>e(()=>import("./knife.5e91cb8b.js"),[]),"../../data/goods/mount.js":()=>e(()=>import("./mount.573491a3.js"),[]),"../../data/goods/special.js":()=>e(()=>import("./special.229630c3.js"),[]),"../../data/goods/sword.js":()=>e(()=>import("./sword.97ec7fc6.js"),[])}),`../../data/goods/${n}.js`);t.value=a.default.list,o.value=!1}catch{t.value=[],o.value=!1}}),(_,n)=>{const a=g("v-table");return s(),E(a,{class:"v-table-equipment",cols:d,data:t.value},{"td-effect":y(({row:c})=>[(s(!0),r(D,null,k(c.effect,(l,u)=>(s(),r("div",{class:"td-block",key:u},j(l),1))),128))]),_:1},8,["data"])}}};export{O as default};
