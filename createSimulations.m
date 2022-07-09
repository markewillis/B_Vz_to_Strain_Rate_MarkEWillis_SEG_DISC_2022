function [model] = createSimulations(model)

% This routine creates the simulated waveforms
%
%
% ***********************************************************************************************************
% MIT License
% 
% Copyright (c) 2022 Mark E. Willis
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
% ***********************************************************************************************************
% create master wavelet at depth

model.Vz = mkTraceRicker(model.z0/model.velocity,model.nsamples,model.dt,model.f0,model.amps);

% make two wavelets apart by GL

model.VzUp = mkTraceRicker((model.z0-model.GL/2)/model.velocity,model.nsamples,model.dt,model.f0,model.amps);
model.VzDn = mkTraceRicker((model.z0+model.GL/2)/model.velocity,model.nsamples,model.dt,model.f0,model.amps);

% create the DAS signal - strain rate
model.strainRate = (model.VzDn - model.VzUp )/model.GL;

% create the vertical particle velocity from the DAS strain rate signal
model.vzFromDAS = -1*cumsum(model.strainRate)*model.dt*model.velocity;

return