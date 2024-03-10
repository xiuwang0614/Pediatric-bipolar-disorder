load('/media/user/xiuwang/3DCM0517/COMBAT_H/GCM_PHC.mat');
for i =1: 40
    GCM_i = GCM{i};
    Cp= GCM_i.Cp;
    Cp = full(GCM_i.Cp(:));
    dat(:,i) = Cp;
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
    Cp = data_harmonized(:, i); 
    
    Cp = sparse(repmat((1:627)', 627, 1), repelem((1:627)', 627, 1), Cp, 627, 627);
    GCM{i}.Cp = Cp
end


disp(GCM);




