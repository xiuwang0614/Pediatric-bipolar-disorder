% created a DCM for each subject named DCM full.mat.
% we’ll collate these into single group DCM file (GCM), 
% which is a cell array with one row per subject and one column
% per model, which we’ll then fit to the data.

%Find all DCM files
dcms = spm_select('FPListRec','I:\3DCM0706\BD\GLM','DCM_5.mat');

% Character array -> cell array
GCM = cellstr(dcms);

% DCM filenames -> DCM structures
GCM = spm_dcm_load(GCM);

%Estimate DCMs(this won't effect original DCM files)
use_parfor = true;
GCM = spm_dcm_fit(GCM,use_parfor);
% GCM = spm_dcm_fit(GCM);

%Save estimated GCM
save('/media/user/xiuwang/3DCM0517/PEB/','GCM');