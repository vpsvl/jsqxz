import{o as s,b as o,d as k,F as p,a,t as f,u as T,e as E,f as A,g as I,r as L,h as P,w as O,i as R,v as j,j as i,c as D,k as r}from"./index.e55bfb45.js";const x={class:"tr tr-map"},w={class:"td"},$={class:"td"},B={class:"td"},U={class:"td"},C={class:"td"},V={__name:"tbody",props:{tbody:{type:Array,default(){return[]}}},setup(v){function g(e){if(typeof e!="number"||e>=100||e<1)return"";const _={0:"",1:"\u4E00",2:"\u4E8C",3:"\u4E09",4:"\u56DB",5:"\u4E94",6:"\u516D",7:"\u4E03",8:"\u516B",9:"\u4E5D"},t=e%10,u=_[t],n=parseInt(e/10);let c="";return n===1?c="\u5341":n>1&&(c=`${_[n]}\u5341`),c+u}return(e,_)=>(s(!0),o(p,null,k(v.tbody,(t,u)=>(s(),o(p,{key:u},[a("div",x,[a("div",w,f(g(u+1)),1),a("div",$,f(t.map),1)]),(s(!0),o(p,null,k(t.event,(n,c)=>(s(),o("div",{class:"tr",key:c},[a("div",B,f(c+1),1),a("div",U,[(s(!0),o(p,null,k(n.list,(l,d)=>(s(),o("p",{class:"td-block",key:d},f(l),1))),128))]),a("div",C,[(s(!0),o(p,null,k(n.reward,(l,d)=>(s(),o("p",{class:"td-block",key:d},f(l),1))),128))])]))),128))],64))),128))}};function M(v){switch(v){case"../../data/process/bai.js":return r(()=>import("./bai.4ba29e00.js"),[]);case"../../data/process/bi.js":return r(()=>import("./bi.48795e83.js"),[]);case"../../data/process/fei.js":return r(()=>import("./fei.9d7508ed.js"),[]);case"../../data/process/huashan.js":return r(()=>import("./huashan.a2ef4f6d.js"),[]);case"../../data/process/lian.js":return r(()=>import("./lian.559aa933.js"),[]);case"../../data/process/lu.js":return r(()=>import("./lu.11ac78bf.js"),[]);case"../../data/process/she.js":return r(()=>import("./she.322a5ec4.js"),[]);case"../../data/process/shen.js":return r(()=>import("./shen.94304ec1.js"),[]);case"../../data/process/shu.js":return r(()=>import("./shu.ca12fa7b.js"),[]);case"../../data/process/start.js":return r(()=>import("./start.667e9040.js"),[]);case"../../data/process/tian.js":return r(()=>import("./tian.709fb11c.js"),[]);case"../../data/process/wudao.js":return r(()=>import("./wudao.d5b3d8d8.js"),[]);case"../../data/process/xia.js":return r(()=>import("./xia.0b0981b6.js"),[]);case"../../data/process/xiao.js":return r(()=>import("./xiao.1d3c4188.js"),[]);case"../../data/process/xue.js":return r(()=>import("./xue.0b9801d5.js"),[]);case"../../data/process/yi.js":return r(()=>import("./yi.b8c95bd8.js"),[]);case"../../data/process/yuan.js":return r(()=>import("./yuan.47061d16.js"),[]);default:return new Promise(function(g,e){(typeof queueMicrotask=="function"?queueMicrotask:setTimeout)(e.bind(null,new Error("Unknown variable dynamic import: "+v)))})}}const N={class:"v-table v-table-process"},Z=a("div",{class:"thead"},[a("div",{class:"td"},"\u5E8F\u53F7"),a("div",{class:"td"},"\u6D41\u7A0B"),a("div",{class:"td"},"\u5956\u52B1")],-1),q={class:"tr-branch"},F={key:0,class:"tr-branch-td"},z=a("span",null,"\u6B63\u7EBF",-1),S={key:1,class:"tr-branch-td"},G=a("span",null,"\u90AA\u7EBF",-1),H={key:2,class:"tr-branch-td"},J=a("span",null,"\u652F\u7EBF",-1),Q={__name:"table",setup(v){const g=T(),e=E("good"),_=E(!1),t=E({}),u=E(!1);A(async()=>{var d,b,h;const{name:c,meta:{type:l}}=g;if(!!/process/i.test(c)){try{u.value=!0;const y=await M(`../../data/process/${l}.js`);t.value=y.default,u.value=!1}catch{t.value={normal:[]},u.value=!1}_.value=((d=t.value.good)==null?void 0:d.length)||((b=t.value.evil)==null?void 0:b.length)||((h=t.value.branch)==null?void 0:h.length),e.value="good"}});const n=E(0);return I(()=>{n.value=n.value===0?1:0}),(c,l)=>{const d=L("v-scroll");return s(),o("div",N,[Z,P(d,{y:n.value,class:"tbody"},{default:O(()=>{var b,h,y;return[P(V,{tbody:t.value.normal},null,8,["tbody"]),_.value?(s(),o(p,{key:0},[a("div",q,[(b=t.value.good)!=null&&b.length?(s(),o("label",F,[R(a("input",{type:"radio",value:"good","onUpdate:modelValue":l[0]||(l[0]=m=>e.value=m)},null,512),[[j,e.value]]),z])):i("",!0),(h=t.value.evil)!=null&&h.length?(s(),o("label",S,[R(a("input",{type:"radio",value:"evil","onUpdate:modelValue":l[1]||(l[1]=m=>e.value=m)},null,512),[[j,e.value]]),G])):i("",!0),(y=t.value.branch)!=null&&y.length?(s(),o("label",H,[R(a("input",{type:"radio",value:"branch","onUpdate:modelValue":l[2]||(l[2]=m=>e.value=m)},null,512),[[j,e.value]]),J])):i("",!0)]),e.value==="good"?(s(),D(V,{key:0,tbody:t.value.good},null,8,["tbody"])):i("",!0),e.value==="evil"?(s(),D(V,{key:1,tbody:t.value.evil},null,8,["tbody"])):i("",!0),e.value==="branch"?(s(),D(V,{key:2,tbody:t.value.branch},null,8,["tbody"])):i("",!0)],64)):i("",!0)]}),_:1},8,["y"])])}}};export{Q as default};
