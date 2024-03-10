% load('/media/user/xiuwang/3DCM0517/COMBAT_H/GCM_PHC.mat');
for i =1: 92
    
    GCM_i = GCM{i};
    y= GCM_i.Y.y;

    y = y(:);
    dat(:,i) = y;
end

batch = PBD_DM(3,:);
age = PBD_DM(1,:)'; % Continuous variable
sex = PBD_DM(2,:)'; % Categorical variable (1 for females, 2 for males)
comorbidity = PBD_DM(5,:)';
medicine = PBD_DM(6,:)';
sex = dummyvar(sex);
mod = [age sex(:,2) comorbidity medicine];
data_harmonized = combat(dat, batch, mod, 1);
% To use ComBat without adjusting for biological variables, simply set
mod=[];

for i = 1:92
    y = data_harmonized(:,i); 
    
    GCM{i}.Y.y = reshape(y, size(GCM{i}.Y.y));
   
end
clear age;
clear batch;
clear dat;
clear data_harmonized;
clear GCM_i;
clear i;
clear mod;
clear sex;
clear y;
clear xY;

% disp(GCM);




