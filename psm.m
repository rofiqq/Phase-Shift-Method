% -------------------------------------------------------------------------
% The phase-shift method (also known as the wavefield transformation method)
% was first described by Park et al. in 1998. The phase-shift method is 
% a wave transformation technique to obtain a phase-velocity spectra 
% (dispersion image) based on a multichannel impulsive shot gather 
% (Park et al., 1998).
% -------------------------------------------------------------------------
function [Data, ff, vr, plt] = psm(file_name, x0, dx, dt, fmin, fmax, vrmin, vrmax, incv);
 % Load Data        
 if strcmp(file_name((length(file_name)-2):(length(file_name))),'sgy')==1 || ...
         strcmp(file_name((length(file_name)-3):(length(file_name))),'segy')==1; 
     [seismic,text_header,binary_header]=read_segy_file(file_name);
      Data=seismic.traces; 
 elseif strcmp(file_name((length(file_name)-2):(length(file_name))),'sg2')==1
      Data=seg2read(file_name);
 elseif strcmp(file_name((length(file_name)-3):(length(file_name))),'seg2')==1; 
     Data_=Seg2FileReader(file_name);
     Data=readTraceData(Data_);
     for i = 1:Data_.NumberOfTraces
         disp(['TRACE - ' num2str(i)]);
         deskripsi=Data_.TraceDescription(1,i).RawTextBlock;
         disp(deskripsi)
         disp('----------------------------------------------');
     end
 end
 % Loads delta t 
 [m, n]=size(Data); xnhit=0;  
 %time series for next power of two 
 np2=nextpow2(m); 
 u(1:2^np2,1:n)=0; 
 u(1:m,:)=Data;
 nt_fft=2*m;
 nx_fft=2*n;
 % FFT 
 miring=0;
 incv=5;
 if miring==0
    U=fft(u);
 elseif miring==1
    U=fft(fliplr(u));
 end
 % Use half of data (Nyquist frequency) 
 U=U(1:(2^(np2-1))+1,:); 
 % Nyquist frequency
 fnyq=1/(2*dt); 
 fvec=fnyq*((1:(2^(np2-1))+1)-1)/((2^(np2-1)));

 fmini=min(find(abs(fvec-fmin)<1)); 
 fmaxi=min(find(abs(fvec-fmax)<1));
 Vtrial=vrmin:incv:vrmax; 
 clear V2 V; 
 V(1:length(Vtrial),1:length(fmini:fmaxi))=0;
 xnf=0; 
 for fi=fmini:fmaxi;
     % Index of current frequency     
     xnf=xnf+1;     
     keq=2*pi*fvec(fi)./Vtrial;     
     for xi=1:length(U(1,:)) 
         e=exp(1i*keq*abs(xi-1)*dx+x0);     
         V(:,xnf)=V(:,xnf)+(U(fi,xi)./abs(U(fi,xi))).*e(:);     
     end
 end
 fnd=0; 
 VR=squeeze((V));
 normalized=1; 
 if normalized==1     
     [tmpm, tmpn]=size(VR);     
     for im=1:tmpn         
         VR(:,im)=VR(:,im)./max(abs(VR(:,im)));     
     end
 end 
 vri=squeeze(Vtrial(1,:)); 
 ffi=fvec(fmini:fmaxi); 
 [vr,ff]=meshgrid(vri,ffi);
 plt=griddata(fvec(fmini:fmaxi),vri,VR,ff,vr,'nearest'); 
 end