if getgenv().mhapi~=nil then return end;local function a()if is_protosmasher_caller~=nil then return 0 end;if elysianexecute~=nil then return 1 end;if fullaccess~=nil then return 2 end;if Synapse~=nil then return 3 end;return 4 end;local function b()local c=a()if c==0 then return is_protosmasher_caller end;if c==1 or c==3 then return checkcaller end;if c==2 then return IsLevel7 end;return nil end;if a()==2 then error("[Metahook]: Exploit not supported")end;local d={}local e={}local f={}local g={}local h={}local i={}local j={}local k={}local l=debug and debug.getmetatable or getrawmetatable;local m=getnamecallmethod or get_namecall_method;local n=setreadonly or make_writeable and function(table,o)if o then make_readonly(table)else make_writeable(table)end end;local p=function()local q=a()local r=b()local s=l(game)if q==0 then make_writeable(s)elseif q==2 then fullaccess(s)else setreadonly(s,false)end;local t=s.__index;local u=s.__newindex;local v=s.__namecall;s.__index=newcclosure(function(w,x)if r()then return t(w,x)end;if d[w]and d[w][x]then local y=d[w][x]if y["IsCallback"]==true then return y["Value"](w)else return y["Value"]end end;if g[x]then local z=g[x]if z["IsCallback"]==true then return z["Value"](w)else return z["Value"]end end;if j[w]and j[w][x]then return k[w][x]end;return t(w,x)end)s.__newindex=newcclosure(function(A,B,C)if r()then return u(A,B,C)end;if e[A]and e[A][B]then local D=e[A][B]if D["Callback"]==nil then return else D["Callback"](A,C)return end end;if h[B]then local E=h[B]if E["Callback"]==nil then return else E["Callback"](A,C)return end end;if j[A]and j[A][B]then local F=j[A][B]if type(C)~=F["Type"]then error("bad argument #3 to '"..B.."' ("..F["Type"].." expected, got "..type(B)..")")end;k[A][B]=C;return end;return u(A,B,C)end)local G=isluau and isluau()or false;s.__namecall=newcclosure(function(H,...)local I={...}local J=G and m()or table.remove(I)if r()then if J=="AddGetHook"then if#I<1 then error("[Metahook]: Invalid argument count")end;local K=I[1]local L=I[2]local M=I[3]if type(K)~="string"then error("[Metahook]: Invalid hook type")end;if not d[H]then d[H]={}end;if M==true and type(L)~="function"then error("[Metahook]: Invalid callback function")end;d[H][K]={Value=L,IsCallback=M}local N=function()d[H][K]=nil end;return{remove=N,Remove=N}end;if J=="AddGlobalGetHook"then local O=I[1]local P=I[2]local Q=I[3]if type(O)~="string"then error("[Metahook]: Invalid hook type")end;if Q==true and type(P)~="function"then error("[Metahook]: Invalid callback function")end;g[O]={Value=P,IsCallback=Q}local R=function()g[O]=nil end;return{remove=R,Remove=R}end;if J=="AddSetHook"then if#I<1 then error("[Metahook]: Invalid argument count")end;local S=I[1]local T=I[2]if type(S)~="string"then error("[Metahook]: Invalid hook type")end;if not e[H]then e[H]={}end;if type(T)=="function"then e[H][S]={Callback=T}else e[H][S]={Callback=nil}end;local U=function()e[H][S]=nil end;return{remove=U,Remove=U}end;if J=="AddGlobalSetHook"then if#I<1 then error("[Metahook]: Invalid argument count")end;local V=I[1]local W=I[2]if type(V)~="string"then error("[Metahook]: Invalid hook type")end;if type(W)=="function"then h[V]={Callback=W}else h[V]={Callback=nil}end;local X=function()h[V]=nil end;return{remove=X,Remove=X}end;if J=="AddCallHook"then if#I<2 then error("[Metahook]: Invalid argument count")end;local Y=I[1]local Z=I[2]if type(Y)~="string"then error("[Metahook]: Invalid hook type")end;if type(Z)~="function"then error("[Metahook]: Invalid argument #2 (not function)")end;if not f[H]then f[H]={}end;f[H][Y]={Callback=Z}local _=function()f[H][Y]=nil end;return{remove=_,Remove=_}end;if J=="AddGlobalCallHook"then if#I<2 then error("[Metahook]: Invalid argument count")end;local a0=I[1]local a1=I[2]if type(a0)~="string"then error("mt-api: Invalid hook type")end;if type(a1)~="function"then error("[Metahook]: Invalid argument #2 (not function)")end;i[a0]={Callback=a1}local a2=function()i[a0]=nil end;return{remove=a2,Remove=a2}end;if J=="AddPropertyEmulator"then if#I<1 then error("[Metahook]: Invalid argument count")end;local a3=I[1]if type(a3)~="string"then error("[Metahook]: Invalid hook type")end;local a4=t(H,a3)local a5=type(a4)if not j[H]then j[H]={}end;if not k[H]then k[H]={}end;j[H][a3]={Type=a5}k[H][a3]=t(H,a3)local a6=function()j[H][a3]=nil;k[H][a3]=nil end;return{remove=a6,Remove=a6}end;return v(H,...)end;if f[H]and f[H][J]then local a7=f[H][J]return a7["Callback"](t(H,J),unpack(I))end;if i[J]then local a8=i[J]return a8["Callback"](H,t(H,J),unpack(I))end;return v(H,...)end)if q==0 then make_readonly(s)elseif q==2 then else n(s,true)end end;p()getgenv().mhapi=true
