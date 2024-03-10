% PEB specification  (using two levels see https://en.wikibooks.org/wiki/SPM/Parametric_Empirical_Bayes_(PEB))

% loading design matrix 
dm = load('I:\3DCM0517\PEB\PHC_design_matrix.mat'); 

X = dm.X;
X_labels = dm.Labels;

% load GCM file with all subjects in one column 
GCM = load('I:\3DCM0517\PEB\GCM_PHC_combat.mat'); 
GCM = GCM.GCM_PHC_COM;


% PEB settings 
M = struct();
M.alpha  = 1;
M.beta = 16;
M.he  = 0;
M.hC = 1/16;
field = {'A'};
M.Q      = 'all';
M.maxit = 2;
M.X      = pbd;
M.Xnames = labels; 



% automatic search for best fit models (taking both A and B to the second
% level) 


[PEB_m, RCM] = spm_dcm_peb(GCM,M,field);
save('PEB.mat', 'PEB','RCM');

% Computing bayesian model average (i.e. weighting the parameters based on the posterior probabilities of the models)
BMA_A = spm_dcm_peb_bmc(PEB_m); 
save('BMA_search_A.mat', 'BMA');

% specific models (i.e. hypothesis testing based on models that have been specified a prior)

% load PEBs 
load('PEB.mat');

% load templates 
templates = load('I:\spDCM\LN——split\GCM_templates_PBD.mat');


% run model comparison 
% 这句报错，引用了不存在的字段 'GCM'。猜测可能是搞错了，因为templates那个m
% 文件，生成的是'GCM_PBD_alt',原始代码生成的是'GCM'
[BMA,BMR] = spm_dcm_peb_bmc(PEB, templates.GCM_PBD_alt);
% Review the BMA

spm_dcm_peb_review(BMA,GCM);

save('I:\spDCM\GLM\Method\BMA_A_6model.mat','BMA_A','BMR');

load('BMA_A_6model.mat');
templates = load('I:\spDCM\GLM\Method\GCM_templates_PBD.mat');
[BMA_fam_Net,Net] = spm_dcm_peb_bmc_fam(BMA,BMR,templates.PBD_family,'ALL');
save('fam.mat','BMA_fam_Net','Net');
