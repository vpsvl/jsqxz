import{u as B,m as T,e as k,n as A,p as D,r as g,k as h,o as n,c as w,w as m,b as i,d as b,h as V,q as R,a as s,F as f,t as y,j as $,s as j,f as M,x as z,i as E,g as d,T as C,y as N,z as F}from"./index.d9c604a8.js";const H=["value","id"],L=["for"],q=s("em",{class:"icon-arrow"},null,-1),U={__name:"menu",props:{menu:{type:Array,default(){return[]}}},setup(x){const v=x,t=B(),l=T(()=>v.menu.filter(e=>!e.meta||!e.meta.hidden)),c=k([]),p=()=>{const{matched:e}=t;e.length>1&&(c.value=[e[1].name])};A(()=>{p()}),D(()=>l.value,e=>{p()});function r(e){if(e.children.length<1)return 0;let o=e.children.filter(u=>!u.meta||!u.meta.hidden);return`${50*o.length}px`}return(e,o)=>{const u=g("router-link"),S=g("v-scroll");return h(l).length?(n(),w(S,{key:0,class:"menu"},{default:m(()=>[(n(!0),i(f,null,b(h(l),a=>(n(),i("div",{class:"menu-nav",key:a.name},[V(s("input",{class:"nav-list-toggle",value:a.name,"onUpdate:modelValue":o[0]||(o[0]=_=>c.value=_),type:"checkbox",id:a.name},null,8,H),[[R,c.value]]),a.children&&a.children.length?(n(),i(f,{key:0},[s("label",{class:"nav-title nav-item",for:a.name},[s("p",null,y(a.meta.title),1),q],8,L),s("div",{class:"nav-list",style:j({maxHeight:r(a)})},[(n(!0),i(f,null,b(a.children,_=>(n(),i(f,{key:_.name},[!_.meta||!_.meta.hidden?(n(),w(u,{key:0,to:{name:_.name},class:"nav-item"},{default:m(()=>[s("p",null,y(_.meta.title),1)]),_:2},1032,["to"])):$("",!0)],64))),128))],4)],64)):(n(),w(u,{key:1,to:{name:a.name},class:"nav-item nav-title"},{default:m(()=>[s("p",null,y(a.meta.title),1)]),_:2},1032,["to"]))]))),128))]),_:1})):$("",!0)}}};const W={class:"bread-nav"},G=s("span",{class:"nav-icon"},"\u5F53\u524D\u4F4D\u7F6E:",-1),I={__name:"bread-nav",props:{nav:{type:Array,default(){return[]}}},setup(x){const v=x,t=k([]),l=k({});return M(()=>{if(v.nav.length<1){t.value=[],l.value={};return}t.value=[...v.nav],l.value=t.value.pop()}),(c,p)=>{const r=g("router-link");return n(),i("div",W,[G,(n(!0),i(f,null,b(t.value,e=>(n(),w(r,{to:e,key:e.name},{default:m(()=>[z(y(e.meta.title),1)]),_:2},1032,["to"]))),128)),s("span",null,y(l.value.meta.title),1)])}}};const J={class:"layout"},K={class:"main"},P={__name:"layout",setup(x){const v=B(),t=E("state"),l=k([]),c=k([]);M(()=>{const{matched:r}=v,e=c.value[0]?c.value[0].name:"";if(c.value=r,e===r[0].name)return;const o=F.find(u=>u.name===r[0].name);o&&(l.value=o.children?o.children:[])});function p(){t.menuVisible=!1}return(r,e)=>{const o=g("router-view"),u=g("v-scroll");return n(),i("div",J,[d(C,{name:"fade"},{default:m(()=>[V(s("div",{class:"menu-mask",onClick:p},null,512),[[N,h(t).lessWindow&&h(t).menuVisible]])]),_:1}),d(C,{name:"fade"},{default:m(()=>[V(d(U,{menu:l.value},null,8,["menu"]),[[N,h(t).menuVisible]])]),_:1}),s("div",K,[d(I,{nav:c.value},null,8,["nav"]),d(u,{class:"main-scroll","view-class":"main-scroll-view"},{default:m(()=>[d(o)]),_:1})])])}}};export{P as default};