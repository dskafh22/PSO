function [gbest,gbestval,fitcount]= SRPSO_func(fhd,Dimension,Particle_Number,Max_Gen,VRmin,VRmax,varargin)

rand('state',sum(100*clock));

me=Max_Gen;
ps=Particle_Number;
D=Dimension;
cc=[1.49445 1.49445];   %acceleration constants

if length(VRmin)==1
    VRmin=repmat(VRmin,1,D);
    VRmax=repmat(VRmax,1,D);
end
mv=(0.100625/1.5)*(VRmax-VRmin);
VRmin=repmat(VRmin,ps,1);
VRmax=repmat(VRmax,ps,1);
Vmin=repmat(-mv,ps,1);
Vmax=-Vmin;
pos=VRmin+(VRmax-VRmin).*rand(ps,D);

e=feval(fhd,pos',varargin{:});

fitcount=ps;
vel=rand(ps,D);%initialize the velocity of the particles
pbest=pos;
pbestval=e; %initialize the pbest and the pbest's fitness value
[gbestval,gbestid]=min(pbestval);
gbest=pbest(gbestid,:);%initialize the gbest and the gbest's fitness value
gbestrep=repmat(gbest,ps,1);

w_varyfor = floor(0.5*me); 
w_now    = 1.05*ones(ps,1);
inertdec = ((1-0.501)/w_varyfor)*ones(ps,1);


for i=2:me

        w_now([1:gbestid-1 gbestid+1:end]) = w_now([1:gbestid-1 gbestid+1:end]) - inertdec([1:gbestid-1 gbestid+1:end]);
        w_now(gbestid) = w_now(gbestid) + inertdec(gbestid);
        
        flg = rand(ps,D)>0.5;
        flg1 = rand(ps,D)>0;
    
        flg1(gbestid,:) = 0;
        flg(gbestid,:) = 0;
        
    
        aa=cc(1).*flg1.*rand(ps,D).*(pbest-pos)+cc(2).*flg.*rand(ps,D).*(gbestrep-pos);
       
         vel=repmat(w_now,1,D).*vel+aa;  
         vel=max(Vmin,min(vel,Vmax));
        pos=pos+vel;
        pos=((pos>=VRmin)&(pos<=VRmax)).*pos...
            +(pos<VRmin).*(VRmin+0.25.*(VRmax-VRmin).*rand(ps,D))+(pos>VRmax).*(VRmax-0.25.*(VRmax-VRmin).*rand(ps,D));
        e=feval(fhd,pos',varargin{:});
        
        fitcount=fitcount+ps;
          
        tmp=(pbestval<e);
        temp=repmat(tmp',1,D);
        pbest=temp.*pbest+(1-temp).*pos;
        pbestval=tmp.*pbestval+(1-tmp).*e;%update the pbest
        [gbestval,gbestid]=min(pbestval);
        gbest=pbest(gbestid,:);
        gbestrep=repmat(gbest,ps,1);%update the gbest
end
end


