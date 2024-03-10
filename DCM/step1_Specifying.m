%% Settings
% MRI scanner settings
TR = 2;        % Repetition time (secs)
TE = 0.003;  % Echo time (secs) 

% Experiment settings
nsubjects   = 92;
nregions    = 20; 
nconditions = 2; 


% Index of each condition in the DCM
% PBD = 1;HC = 2;

% Index of each region in the DCM
VOI_sgACC_1 =1;
VOI_PCC_1=2;
VOI_Angular_R_1=3;
VOI_Angular_L_1=4;


VOI_MFG_L_1=5;
VOI_MFG_R_1=6;
VOI_IPL_1=7;
VOI_IPR_1=8;

VOI_dACC_L_1=9;
VOI_dACC_R_1=10;
VOI_AI_L_1=11;
VOI_AI_R_1=12;

%VOI_Pallidum_L_1=13;
%VOI_Pallidum_R_1=14;
% VOI_Caudate_L_1=15;
% VOI_Caudate_R_1=16;
%VOI_Putamen_L_1=17;
%VOI_Putamen_R_1=18;
VOI_Caudate_L_1=13;
VOI_Caudate_R_1=14;
VOI_Hippo_L_1=15;
VOI_Hippo_R_1=16;
VOI_Amyg_L_1=17;
VOI_Amyg_R_1=18;
VOI_OFC_L_1=19;
VOI_OFC_R_1=20;

%% Specify DCMs (one per subject)

% A-matrix (on / off)

a = ones(nregions,nregions);

% B-matrix
b  =  zeros(nregions, nregions); 

% C-matrix
c = zeros(nregions, nconditions);

% D-matrix (disabled)
d = zeros(nregions,nregions,0);

start_dir = pwd;

% Select whether to include each condition from the SPM.mat 
include = [0];

% Specify DCM
base_folder = '/media/user/xiuwang/3DCM0706/BD/GLM';
files = dir(fullfile(base_folder));
folder_nums = size(files,1);
folder_names = {};
for i = 3:folder_nums
    folder_names{i-2} = files(i,1).name;
end
    
for k1 = 1:length(folder_names)
     
    % Load SPM
    
    glm_dir = fullfile('/media/user/xiuwang/3DCM0706/BD/GLM',folder_names{k1});
    SPM     = load(fullfile(glm_dir, 'SPM.mat'));
    SPM     = SPM.SPM;
    
    % Load ROIs 
    
     f       = {fullfile(glm_dir ,'VOI_sgACC_1.mat');
        fullfile(glm_dir ,'VOI_PCC_1.mat');
        fullfile(glm_dir ,'VOI_Angular_R_1.mat');
        fullfile(glm_dir ,'VOI_Angular_L_1.mat');
    

    	fullfile(glm_dir ,'VOI_MFG_L_1.mat');
    	fullfile(glm_dir ,'VOI_MFG_R_1.mat');
        fullfile(glm_dir ,'VOI_IPL_1.mat');
        fullfile(glm_dir ,'VOI_IPR_1.mat');

    	fullfile(glm_dir ,'VOI_dACC_L_1.mat');
    	fullfile(glm_dir ,'VOI_dACC_R_1.mat');
        fullfile(glm_dir ,'VOI_AI_L_1.mat');
    	fullfile(glm_dir ,'VOI_AI_R_1.mat');
    
%     	fullfile(glm_dir ,'VOI_Pallidum_L_1.mat');
%     	fullfile(glm_dir ,'VOI_Pallidum_R_1.mat');
    	fullfile(glm_dir ,'VOI_Caudate_L_1.mat');
    	fullfile(glm_dir ,'VOI_Caudate_R_1.mat');
%     	fullfile(glm_dir ,'VOI_Putamen_L_1.mat');
%     	fullfile(glm_dir ,'VOI_Putamen_R_1.mat');
    	fullfile(glm_dir ,'VOI_Hippo_L_1.mat');
    	fullfile(glm_dir ,'VOI_Hippo_R_1.mat');
        fullfile(glm_dir ,'VOI_Amyg_L_1.mat');
    	fullfile(glm_dir ,'VOI_Amyg_R_1.mat');
        fullfile(glm_dir ,'VOI_OFC_L_1.mat');
    	fullfile(glm_dir ,'VOI_OFC_R_1.mat')};
    

    for r = 1:length(f) 
        XY = load(f{r});
        xY(r) = XY.xY;
        
    end
   
    


    % Move to output directory
    cd(glm_dir);

    
    % Select whether to include each condition from the design matrix
    % (preInjection, postInjection)
    
    % Specify. Corresponds to the series of questions in the GUI.
    s = struct();
    s.name       = 'f';
    s.delays     = repmat(TR,1,nregions);   % Slice timing for each region
    s.TE         = TE;
    s.u          = include;
    s.nonlinear  = false;
    s.two_state  = false;
    s.stochastic = false;
    s.centre     = true;
    s.induced    = 1;
    s.a          = a;
    s.b          = b;
    s.c          = c;
    s.d          = d;

    DCM = spm_dcm_specify(SPM,xY,s);
    

     % Return to script directory
    cd(start_dir);

end