function Q = LToneMap(P,T,G)
%LToneMap Tone map with a linear function
%   P = input image
%   T = offset
%   G = gain
%
% Simple version assumes P is in 0,1
if ~isfloat(P)
    error('Not real','Convert to double/single')
else
    if (T < 0) | (T>1)
        error('LTM','Wrong T')
    else
        Q = 0.5 * G*(P-T);
        Q(Q<0)=0;
        Q(Q>1)=1;
    end
end
return
end

