(window.webpackJsonp=window.webpackJsonp||[]).push([[78],{1641:function(e,t,a){"use strict";a.r(t),function(e){a.d(t,"LoggedOutHomePage2019",(function(){return n}));var o=a(3),r=a(2500),i=a(1),n=function(t){function a(){return null!==t&&t.apply(this,arguments)||this}return Object(o.__extends)(a,t),a.prototype.render=function(){return e.createElement(i.ThemeProvider,{theme:i.defaultTheme},e.createElement(r.a,null))},a}(e.Component)}.call(this,a(0))},2500:function(e,t,a){"use strict";var o=a(1),r=a.n(o),i=a(1643),n=a(0);const l=r.a.div`
  position: relative;
  padding-bottom: 56.25%; /* 16:9 */
  height: 0;
`,s=r.a.iframe`
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
`,g=e=>{const{src:t,autoplay:a}=e;return n.createElement(l,null,n.createElement(s,{title:"video ",src:`${t}&autoplay=${a}`,allowFullScreen:!0}))};var m=a(1683),c=a(1684),p=a(1593);a(1592);const d=r()(p.a)`
  && {
    padding: ${e=>e.padding?e.padding:"0px"};
  }
`,h=e=>{const{align:t,children:a,className:o,fixedColumnWidth:r,padding:i}=e;return n.createElement(d,{align:t,className:o,fixedColumnWidth:r,padding:i},a)};a(1592);const u=r()(p.b)``,E=e=>{const{align:t,children:a,className:o,desktop:r,order:i,phone:l,span:s,tablet:g}=e;return n.createElement(u,{align:t,className:o,desktop:r,order:i,phone:l,span:s,tablet:g},a)};var f=a(1748),k=a(1600),b=a(422);a(565);const v=e=>{const{className:t,children:a,dense:o}=e;return n.createElement(b.b,{className:t,dense:o},a)},w=r.a.div`
  align-items: flex-start;
  border-right: ${e=>e.borderRight&&`1px solid ${e.theme.material.color.brand.grey[200]}`};
  cursor: pointer;
  display: flex;
  flex-direction: column;
  height: ${e=>e.theme.material.spacing(54)};
  padding-right: ${e=>e.theme.material.spacing(2)};
  text-decoration: none;
`,_=r.a.div`
  align-items: center;
  display: flex;
  margin-bottom: ${e=>e.theme.material.spacing(4)};
`,y=r()(f.t)`
  text-decoration: none;
`,$=r.a.img`
  border-radius: 100%;
  height: ${e=>e.theme.material.spacing(8)};
  margin-right: ${e=>e.theme.material.spacing(3)};
  width: ${e=>e.theme.material.spacing(8)};
`,x=r()(f.b)`
  margin-bottom: ${e=>e.theme.material.spacing(4)};
`,j=r()(k.a)`
  border: 3px solid ${e=>e.theme.material.color.white};
`,H=r.a.span`
  align-items: center;
  background-color: ${e=>e.theme.material.color.brand.blue[500]};
  border-radius: 100%;
  color: ${e=>e.theme.material.color.white};
  display: inline-flex;
  font-size: ${e=>e.theme.material.typography.fontSize[10]};
  height: ${e=>e.theme.material.spacing(6)};
  justify-content: center;
  padding-left: ${e=>e.theme.material.spacing(.5)};
  width: ${e=>e.theme.material.spacing(6)};
`,S=r.a.a`
  text-decoration: none;
`,C=e=>{const{id:t,href:a,title:o,iconSrc:r,borderRight:i,userImages:l,totalUsers:s,children:g}=e;return n.createElement(S,{id:t,href:a},n.createElement(w,{borderRight:i},n.createElement(_,null,n.createElement($,{src:r,alt:o}),n.createElement(y,null,o)),n.createElement(x,null,g,n.createElement("br",null)),n.createElement(v,{dense:!0},l.map((e,t)=>n.createElement(j,{src:e,name:o,key:`${o}-${t}`,size:"large"})),n.createElement(H,null,s))))},F=r.a.div`
  cursor: pointer;
  position: relative;
  text-decoration: none;
  width: 100%;
`,P=r.a.div`
  padding-left: ${e=>e.theme.material.spacing(2)};
`,L=r.a.img`
  border-radius: ${e=>e.theme.material.spacing(2)};
  margin-bottom: ${e=>e.theme.material.spacing(3)};
  min-height: ${e=>e.theme.material.spacing(32)};
  object-fit: cover;
  width: 100%;
`,T=r()(f.t)`
  display: block;
  text-decoration: none;
`,z=r()(T)`
  color: ${e=>e.theme.material.color.text[50]};
  margin-bottom: ${e=>e.theme.material.spacing(4)};
`,D=r.a.div`
  color: ${e=>e.theme.material.color.text[50]};
  display: flex;
  margin-bottom: ${e=>e.theme.material.spacing(3)};
`,I=r.a.a`
  display: flex;
  position: relative;
  text-decoration: none;
`,G=e=>{const{id:t,type:a,title:o,user:r,imagePath:i,votes:l,href:s}=e;return n.createElement(I,{id:t,href:s},n.createElement(F,null,n.createElement(L,{src:i}),n.createElement(P,null,n.createElement(T,null,o),n.createElement(z,null,r),n.createElement(D,null,n.createElement(f.b,null,a," | ",l," upvotes")))))},R=r.a.div`
  background-color: ${o.defaultTheme.material.color.brand.grey[50]};
  padding: ${o.defaultTheme.material.spacing(28)} 0;
`,N=r.a.img`
  margin-bottom: ${o.defaultTheme.material.spacing(6)};
  width: ${o.defaultTheme.material.spacing(32)};
`,M=r.a.div`
  display: flex;
  flex-direction: column;
`,U=r.a.ul`
  line-height: ${o.defaultTheme.material.spacing(12)};
`,W=r()(f.n)`
  margin-bottom: ${o.defaultTheme.material.spacing(5)};
`,A=r()(f.b.withComponent("a"))`
  color: ${o.defaultTheme.material.color.brand.blue[500]};
  display: inline;
  text-decoration: none;
`,K=r()(A)`
  color: ${o.defaultTheme.material.color.text[70]};
  display: block;
  margin-bottom: ${o.defaultTheme.material.spacing(5)};
`,J=r()(A)`
  color: ${o.defaultTheme.colors.misc.grayLighter};
`,B=r.a.a`
  display: inline;
  margin-right: ${o.defaultTheme.material.spacing(3)};
`,O=r.a.div`
  display: flex;
  align-items: center;
  justify-content: center;
`,Z=r()(A)`
  color: ${o.defaultTheme.material.color.text[70]};
`;function q(){return n.createElement(R,null,n.createElement(h,{fixedColumnWidth:!0},n.createElement(E,{desktop:6,phone:3},n.createElement(M,null,n.createElement(N,{src:"https://www.kaggle.com/static/images/site-logo.png",alt:"Kaggle Logo"}),n.createElement("div",null,n.createElement(J,null,"Have an account? "),n.createElement(A,{id:"Footer-signin",href:"/account/login"},"Sign in")))),n.createElement(E,{desktop:2,phone:2},n.createElement(U,null,n.createElement(W,null,"Product"),n.createElement(K,{id:"Footer__competitions",href:"/competitions"},"Competitions"),n.createElement(K,{id:"Footer__datasets",href:"/datasets"},"Datasets"),n.createElement(K,{id:"Footer__kernels",href:"/kernels"},"Notebooks"),n.createElement(K,{id:"Footer__learn",href:"/learn/overview"},"Learn"))),n.createElement(E,{desktop:2,phone:2},n.createElement(U,null,n.createElement(W,null,"Documentation"),n.createElement(K,{id:"Footer__competitonDocs",href:"/docs/competitions"},"Competitions"),n.createElement(K,{id:"Footer__datasetsDocs",href:"/docs/datasets"},"Datasets"),n.createElement(K,{id:"Footer__kernelsDocs",href:"/docs/notebooks"},"Notebooks"),n.createElement(K,{id:"Footer__apiDocs",href:"/docs/api"},"Public API"))),n.createElement(E,{desktop:2,phone:2},n.createElement(U,null,n.createElement(W,null,"Company"),n.createElement(K,{id:"Footer__team",href:"/about/team"},"Our Team"),n.createElement(K,{id:"Footer__blog",href:"http://blog.kaggle.com/"},"Blog"),n.createElement(K,{id:"Footer__contact",href:"/contact"},"Contact Us"),n.createElement(K,{id:"Footer__host",href:"/host"},"Host a Competition"),n.createElement(B,{id:"Footer__twitter",href:"https://twitter.com/kaggle"},n.createElement("img",{src:"https://www.kaggle.com/static/images/logo-button-twitter.svg",alt:"Twitter"})),n.createElement(B,{id:"Footer__facbook",href:"https://www.facebook.com/kaggle"},n.createElement("img",{src:"https://www.kaggle.com/static/images/logo-button-facebook.svg",alt:"Facebook"})),n.createElement(B,{id:"Footer__linkedin",href:"https://www.linkedin.com/company/kaggle/"},n.createElement("img",{src:"https://www.kaggle.com/static/images/logo-button-linkedin.svg",alt:"LinkedIn"})))),n.createElement(E,{span:12},n.createElement(O,null,n.createElement(f.b,null,"© 2019 Kaggle Inc."," | ",n.createElement(Z,{id:"Footer__terms",href:"/terms"},"Terms")," | ",n.createElement(Z,{id:"Footer__privacy",href:"/privacy"},"Privacy"))))))}const V=()=>n.createElement("svg",{width:"24px",height:"24px",viewBox:"0 0 24 24"},n.createElement("g",{id:"2019_0318",stroke:"none",strokeWidth:"1",fill:"none",fillRule:"evenodd"},n.createElement("g",{id:"8.Kaggle_Homepage",transform:"translate(-152.000000, -600.000000)"},n.createElement("rect",{fill:"#FFFFFF",x:"0",y:"0",width:"1440",height:"3677"}),n.createElement("g",{id:"Group-24",transform:"translate(136.000000, 237.000000)"},n.createElement("g",{id:"gFAB/Extended/Lowered/Enabled",transform:"translate(0.000000, 351.000000)"},n.createElement("g",{id:"Icon",transform:"translate(16.000000, 12.000000)"},n.createElement("g",{id:"Icons/Super-g"},n.createElement("path",{d:"M23.5227273,12.2727273 C23.5227273,11.4218182 23.4504545,10.6022727 23.3127273,9.81818182 L12,9.81818182 L12,14.4545455 L18.4595455,14.4545455 C18.1813636,15.9545455 17.34,17.2322727 16.065,18.0872727 L16.065,21.1036364 L19.9513636,21.1036364 C22.2190909,19.0145455 23.5227273,15.9245455 23.5227273,12.2727273 L23.5227273,12.2727273 Z",id:"Shape",fill:"#4285F4",fillRule:"nonzero"}),n.createElement("path",{d:"M16.0663636,18.0872727 C14.9931818,18.8072727 13.6131818,19.2272727 12,19.2272727 C8.87727273,19.2272727 6.22772727,17.1204545 5.28136364,14.2813636 L1.27636364,14.2813636 L1.27636364,17.3890909 C3.25090909,21.3109091 7.31045455,24 12,24 C15.2386364,24 17.9659091,22.9363636 19.9527273,21.1036364 L16.0663636,18.0872727 Z",id:"Shape",fill:"#34A853",fillRule:"nonzero"}),n.createElement("path",{d:"M4.90909091,12 C4.90909091,11.2063636 5.04136364,10.4386364 5.28136364,9.71863636 L5.28136364,6.60954545 L1.27636364,6.60954545 C0.460909091,8.23090909 0,10.0609091 0,12 C0,13.9390909 0.460909091,15.7690909 1.27636364,17.3904545 L5.28136364,14.2827273 C5.04136364,13.5613636 4.90909091,12.7936364 4.90909091,12 Z",id:"Shape",fill:"#FBBC05",fillRule:"nonzero"}),n.createElement("path",{d:"M12,4.77272727 C13.7631818,4.77272727 15.3436364,5.37954545 16.59,6.56727273 L20.0290909,3.12818182 C17.9495455,1.18909091 15.2372727,0 12,0 C7.31045455,0 3.25090909,2.68909091 1.27636364,6.60954545 L5.28136364,9.71727273 C6.22772727,6.87954545 8.87727273,4.77272727 12,4.77272727 Z",id:"Shape",fill:"#EA4335",fillRule:"nonzero"}),n.createElement("polygon",{id:"Shape",points:"0 0 24 0 24 24 0 24"})))))))),Y=r.a.div`
  display: grid;
  grid-template-columns: repeat(5, minmax(50px, 1fr));
  grid-template-rows: repeat(4, minmax(50px, 1fr));
  position: absolute;
  top: 0;
  width: 100%;
  z-index: 1;
`,Q=r.a.div`
  grid-column-start: ${e=>e.colStart};
  grid-row-start: ${e=>e.rowStart};
`,X=r.a.img`
  width: 100%;
`;function ee(){return n.createElement(Y,null,n.createElement(Q,{colStart:"3"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/organic-dots.svg",alt:"Geometric Grid pattern"})),n.createElement(Q,{colStart:"4"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/neural-network.svg",alt:"Geometric Grid pattern"})),n.createElement(Q,{colStart:"5"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/dot-lines.svg",alt:"Geometric Grid pattern"})),n.createElement(Q,{colStart:"4",rowStart:"2"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/grid.svg",alt:"Geometric Grid pattern"})),n.createElement(Q,{colStart:"5",rowStart:"2"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/circles.svg",alt:"Geometric Grid pattern"})),n.createElement(Q,{colStart:"5",rowStart:"3"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/grid-dots-missing.svg",alt:"Geometric Grid pattern"})),n.createElement(Q,{colStart:"1",rowStart:"4"},n.createElement(X,{src:"https://www.kaggle.com/static/images/design/HomePage/grid-pattern/grid-trending-down.svg",alt:"Geometric Grid pattern"})))}a.d(t,"a",(function(){return je})),a(1642);const te=r.a.div`
  background-color: white;
  position: relative;
`,ae=r.a.section`
  padding-top: ${e=>e.theme.material.spacing(12)};
  padding-bottom: ${e=>e.theme.material.spacing(32)};
  position: relative;
  z-index: 2;
`,oe=r()(f.j)`
  font-weight: ${e=>e.theme.material.typography.fontWeight.normal};
  margin-bottom: ${e=>e.theme.material.spacing(4)};
`,re=r()(i.a)`
  margin-bottom: ${({theme:e})=>e.material.spacing(6)};
  --mdc-theme-secondary: ${({theme:e})=>e.material.color.white};
  --mdc-theme-on-secondary: ${({theme:e})=>e.material.color.text[70]};
`,ie=r.a.a`
  box-shadow: inset 0 -${e=>e.theme.material.spacing(2)} 0 ${e=>e.theme.material.color.brand.blue[400]};
  color: ${e=>e.theme.material.color.text[70]};
  text-decoration: none;
`,ne=r()(f.b.withComponent("a"))`
  color: ${e=>e.theme.material.color.brand.blue[500]};
  text-decoration: none;
`,le=r()(E)`
  align-self: center;
  display: flex;
  flex-direction: column;
`,se=r.a.div`
  display: flex;
  flex-direction: column;
  align-items: center;
  position: relative;
`,ge=r()(m.a)`
  &&& {
    background-color: ${({theme:e})=>e.material.color.white};
    bottom: ${({theme:e})=>e.material.spacing(24)};
    color: ${({theme:e})=>e.material.color.brand.grey[800]};
  }
`,me=r.a.video`
  background-color: ${e=>e.theme.material.color.white};
  border-radius: ${e=>e.theme.material.spacing(3)}
    ${e=>e.theme.material.spacing(3)} 0 0;
  box-shadow: ${e=>e.theme.material.elevation[3]};
  height: 100%;
  width: 100%;
`,ce=r()(f.a)`
  color: ${e=>e.theme.material.color.text[50]};
  margin-bottom: ${e=>e.theme.material.spacing(8)};
`,pe=r.a.section`
  padding-bottom: ${e=>e.theme.material.spacing(32)};
  position: relative;
  z-index: 2;
`,de=r()(f.l)`
  font-weight: ${e=>e.theme.material.typography.fontWeight.normal};
  letter-spacing: -0.5px;
  line-height: ${e=>e.theme.material.spacing(12)};
  margin-bottom: ${e=>e.theme.material.spacing(12)};
`,he=r()(c.a)`
  && {
    background-color: ${({theme:e})=>e.material.color.white};
    border: 1px solid ${({theme:e})=>e.material.color.brand.grey[300]};
    color: ${({theme:e})=>e.material.color.text[70]};
    font-size: ${({theme:e})=>e.material.typography.subhead.fontSize};
    font-weight: ${({theme:e})=>e.material.typography.subhead.fontWeight};
    margin-bottom: ${({theme:e})=>e.material.spacing(4)};
    margin-right: ${({theme:e})=>e.material.spacing(2)};
  }
`,ue=r.a.section`
  padding-bottom: ${e=>e.theme.material.spacing(16)};
  padding-top: ${e=>e.theme.material.spacing(4)};
  position: relative;
  z-index: 2;
`,Ee=r.a.div`
  align-items: center;
  display: flex;
  margin-bottom: ${e=>e.theme.material.spacing(4)};
`,fe=r()(f.n)``,ke=r()(m.a)`
  margin-right: ${e=>e.theme.material.spacing(4)};
`,be=r.a.section`
  padding-bottom: ${e=>e.theme.material.spacing(40)};
  position: relative;
  z-index: 2;
`,ve=r.a.div`
  box-shadow: ${({theme:e})=>e.material.elevation[4]};
`,we=r.a.div`
  display: flex;
  justify-content: center;
  overflow: hidden;
  padding-bottom: ${e=>e.theme.material.spacing(40)};
`,_e=r.a.img`
  padding: ${({theme:e})=>e.material.spacing(6)} 0;
`,ye=r()(E)`
  align-items: center;
  display: flex;
  flex-direction: column;
`,$e=r.a.a`
  position: relative;
  text-decoration: none;
`,xe=r()($e)`
  justify-content: center;
`;function je(){return n.createElement(te,null,n.createElement(ee,null),n.createElement(ae,null,n.createElement(h,{fixedColumnWidth:!0},n.createElement(le,{desktop:4},n.createElement(oe,null,"Start with more than a blinking cursor"),n.createElement(ce,null,"Kaggle offers a no-setup, customizable, Jupyter Notebooks environment. Access free GPUs and a huge repository of community published data & code."),n.createElement($e,{id:"Homepage__hero_A-registergoogle",href:"/account/authenticate/google?isModal=true"},n.createElement(re,{ripple:{surface:!1},label:"Register with Google",icon:{strategy:"component",icon:n.createElement(V,null)}})),n.createElement(ne,{id:"Homepage__hero_A-registeremail",href:"/account/login?signup=true"},"Register with Email")),n.createElement(E,{desktop:8},n.createElement(se,null,n.createElement(xe,{id:"Homepage__hero_A-kernelDemo",href:"/notebooks/new",role:"button"},n.createElement(me,{src:"/static/video/homepage_landingvideo.mp4",autoPlay:!0,loop:!0,muted:!0})),n.createElement($e,{id:"Homepage__hero_A-tryNowCTA",href:"/notebooks/new"},n.createElement(ge,{variant:"unelevated"},"Try Now")))))),n.createElement(pe,null,n.createElement(h,{fixedColumnWidth:!0},n.createElement(E,{desktop:12},n.createElement(de,null,"Inside Kaggle you’ll find all the code & data you need to do your data science work. Use over 19,000 public"," ",n.createElement(ie,{id:"Homepage__learn--headlineDatasets",href:"/datasets"},"datasets")," ","and 200,000 public"," ",n.createElement(ie,{id:"Homepage__learn--headlineKernels",href:"/kernels"},"notebooks")," ","to conquer any analysis in no time.")),n.createElement(E,{desktop:12},n.createElement($e,{id:"Homepage__datasets-kernels-chip_maintained-by-kaggle",href:"/datasets?sort=hottest&tags=15006-socrata"},n.createElement(he,{leadingIcon:"list"},"Maintained by Kaggle")),n.createElement($e,{id:"Homepage__datasets-kernels-chip_starter-code",href:"/kernels?sort=hotness&search=starter"},n.createElement(he,{leadingIcon:"code"},"Starter Code")),n.createElement($e,{href:"/datasets?tags=11108-finance",id:"Homepage__datasets-kernels-chip_finance-datasets"},n.createElement(he,{leadingIcon:"attach_money"},"Finance Datasets")),n.createElement($e,{href:"/datasets?tags=11208-linguistics",id:"Homepage__datasets-kernels-chip_linguistics-datasets"},n.createElement(he,{leadingIcon:"vpn_lock"},"Linguistics Datasets")),n.createElement($e,{href:"/kernels?sortBy=relevance&group=everyone&search=data+visualization",id:"Homepage__datasets-kernels-chip_data-visualization-kernels"},n.createElement(he,{leadingIcon:"insert_chart"},"Data Visualization Kernels"))),n.createElement(E,{desktop:3,phone:2},n.createElement(G,{id:"Homepage__datasets-kernels-dataset_financial-datasets",type:"CSV Dataset",user:"David Wallach",imagePath:"https://storage.googleapis.com/kaggle-datasets-images/62920/121792/0b2d5fa44f4288eb760b7d83f9f1dfd2/dataset-cover.jpg?t=2018-10-10-16-28-48",votes:"50",title:"Financial Tweets",href:"/davidwallach/financial-tweets"})),n.createElement(E,{desktop:3,phone:2},n.createElement(G,{id:"Homepage__datasets-kernels-dataset_face-detection",type:"JSON Dataset",user:"DataTurks",imagePath:"https://storage.googleapis.com/kaggle-datasets-images/36341/54972/e92d46e8c6754c16c2dc19df1f08dd9d/dataset-cover.png?t=2018-07-12-09-44-49",votes:"68",title:"Face Detection in Images",href:"/dataturks/face-detection-in-images"})),n.createElement(E,{desktop:3,phone:2},n.createElement(G,{id:"Homepage__datasets-kernels-dataset_star-trek-scripts",type:"JSON Dataset",user:"Gary Broughton",imagePath:"https://storage.googleapis.com/kaggle-datasets-images/59981/116390/33f700110d8d2e206c59265084efea42/dataset-cover.jpg?t=2018-10-06-10-03-38",votes:"12",title:"Star Trek Scripts",href:"/gjbroughton/start-trek-scripts"})),n.createElement(E,{desktop:3,phone:2},n.createElement(G,{id:"Homepage__datasets-kernels-dataset_avacado-prices",type:"CSV Dataset",user:"Justin Kiggins",imagePath:"https://storage.googleapis.com/kaggle-datasets-images/30292/38613/ab6171de10588e40148aed91ff39e2e9/dataset-cover.jpg?t=2018-06-06-13-58-40",votes:"546",title:"Avocado Prices",href:"/neuromusic/avocado-prices"})))),n.createElement(ue,null,n.createElement(h,{fixedColumnWidth:!0},n.createElement(E,{desktop:12},n.createElement(Ee,null,n.createElement($e,{id:"Homepage__learn_learn-button",href:"/learn/overview"},n.createElement(ke,null,"Learn")),n.createElement(fe,null,"Take a micro-course and start applying your new skills immediately"))),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__learn-machine-learning",borderRight:!0,iconSrc:"/static/images/design/HomePage/ml.png",title:"Machine Learning",href:"/learn/intro-to-machine-learning",totalUsers:"65k",userImages:["https://storage.googleapis.com/kaggle-avatars/images/2997534-gr.jpg","https://storage.googleapis.com/kaggle-avatars/images/2877619-gr.jpg","https://storage.googleapis.com/kaggle-avatars/images/2784593-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2996666-fb.jpg","https://storage.googleapis.com/kaggle-avatars/images/2924931-gr.jpg"]},"Machine Learning is the hottest field in data science, and this track will get you started quickly")),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__learn-pandas",iconSrc:"/static/images/design/HomePage/pandas.png",title:"Pandas",href:"/learn/pandas",borderRight:!0,totalUsers:"87k",userImages:["https://storage.googleapis.com/kaggle-avatars/images/2332294-fb.jpg","https://storage.googleapis.com/kaggle-avatars/images/971933-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/1352718-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1358739-fb.jpg","https://storage.googleapis.com/kaggle-avatars/images/2987837-fb.jpg"]},"Short hands-on challenges to perfect your data manipulation skills",n.createElement("br",null))),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__learn-python",borderRight:!0,title:"Python",iconSrc:"/static/images/design/HomePage/python.png",href:"/learn/python",userImages:["https://storage.googleapis.com/kaggle-avatars/images/1643006-gr.jpg","https://storage.googleapis.com/kaggle-avatars/images/952796-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2914175-fb.jpg","https://storage.googleapis.com/kaggle-avatars/images/2983026-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/846108-gp.jpg"],totalUsers:"65k"},"Learn the most important language for Data Science",n.createElement("br",null))),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__learn-deep-learning",title:"Deep Learning",iconSrc:"/static/images/design/HomePage/deepLearning.png",href:"/learn/deep-learning",userImages:["https://storage.googleapis.com/kaggle-avatars/images/2758158-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2923113-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1282739-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/1060975-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2078465-fb.jpg"],totalUsers:"12k"},"Use TensorFlow to take Machine Learning to the next level. Your new skills will amaze you")),n.createElement(E,{desktop:12},n.createElement(Ee,null,n.createElement($e,{id:"Homepage__competitions-button",href:"/competitions"},n.createElement(ke,null,"Competitions")),n.createElement(fe,null,"Join a competition to solve real-world machine learning problems"))),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__competitions-titanic",borderRight:!0,title:"Titanic",iconSrc:"https://storage.googleapis.com/kaggle-competitions/kaggle/3136/logos/thumb76_76.png",href:"/c/titanic",userImages:["https://storage.googleapis.com/kaggle-avatars/images/112483-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/2419689-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1461289-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1308875-kg.png","https://storage.googleapis.com/kaggle-avatars/images/1351163-kg.jpg"],totalUsers:"10k"},"Start here! Predict survival on the Titanic and get familiar with Machine Learning basics")),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__competitions-house-prices",href:"/c/house-prices-advanced-regression-techniques",borderRight:!0,title:"House Prices",iconSrc:"https://storage.googleapis.com/kaggle-competitions/kaggle/5407/logos/thumb76_76.png",userImages:["https://storage.googleapis.com/kaggle-avatars/images/456330-gr.jpg","https://storage.googleapis.com/kaggle-avatars/images/701762-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/2586938-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2316141-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2920596-kg.jpg"],totalUsers:"4k"},"Predict sales prices and practice feature engineering, RFs, and gradient boosting")),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__competitions-predict-sales",href:"/c/competitive-data-science-predict-future-sales",borderRight:!0,title:"Predict Future Sales",iconSrc:"https://storage.googleapis.com/kaggle-competitions/kaggle/8587/logos/thumb76_76.png?t=2018-02-17-15-25-52",userImages:["https://storage.googleapis.com/kaggle-avatars/images/2405813-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1856194-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/418133-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1110719-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/1458293-kg.jpg"],totalUsers:"2k"},'Final project for "How to win a data science competition" Coursera course')),n.createElement(E,{desktop:3,phone:2},n.createElement(C,{id:"Homepage__competitions-digit-recognizer",href:"/c/digit-recognizer",title:"Digit Recognizer",iconSrc:"https://storage.googleapis.com/kaggle-competitions/kaggle/3004/logos/thumb76_76.png",userImages:["https://storage.googleapis.com/kaggle-avatars/images/2838137-fb.jpg","https://storage.googleapis.com/kaggle-avatars/images/2530579-kg.jpg","https://storage.googleapis.com/kaggle-avatars/images/684645-gp.jpg","https://storage.googleapis.com/kaggle-avatars/images/2618786-kg.JPG","https://storage.googleapis.com/kaggle-avatars/images/229237-gr.jpg"],totalUsers:"3k"},"Learn computer vision fundamentals with the famous MNIST data")))),n.createElement(be,null,n.createElement(h,{fixedColumnWidth:!0},n.createElement(E,{desktop:12},n.createElement(ve,null,n.createElement(g,{src:"https://www.youtube.com/embed/TNzDMOg_zsw?rel=0&modestbranding=1"}))))),n.createElement(we,null,n.createElement(h,{fixedColumnWidth:!0},n.createElement(ye,{desktop:12},n.createElement(f.n,null,"Join our community of over 3 million"),n.createElement(_e,{src:"/static/images/design/HomePage/communityAvatars.png",alt:"Kaggle community members"}),n.createElement($e,{id:"Homepage__join-registergoogle",href:"/account/authenticate/google?isModal=true"},n.createElement(re,{ripple:{surface:!1},label:"Register with Google",icon:{strategy:"component",icon:n.createElement(V,null)}})),n.createElement(ne,{id:"Homepage__join-registerEmail",href:"/account/login?signup=true"},"Register with Email")))),n.createElement(q,null))}}}]);