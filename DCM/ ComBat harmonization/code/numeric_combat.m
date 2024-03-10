load('/media/user/xiuwang/3DCM0517/COMBAT_H/GCM_PHC.mat');
for i =1: 40
    GCM_i = GCM{i};
    F= GCM_i.F;
    
    dat(:,i) = F;
end

batch = HC_DM(1,:);
age = HC_DM(3,:)'; % Continuous variable
sex = HC_DM(2,:)'; % Categorical variable (1 for females, 2 for males)
sex = dummyvar(sex);
mod = [age sex(:,2)];
data_harmonized = combat(dat, batch, mod, 1);
% To use ComBat without adjusting for biological variables, simply set
mod=[];

for i = 1:40
    F = dat(:, i); 
    GCM{i}.F = F;
   
end


% disp(GCM);




