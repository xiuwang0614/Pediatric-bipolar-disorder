load('/media/user/xiuwang/3DCM0517/COMBAT_H/GCM_PHC.mat');
for i =1: 40
    GCM_i = GCM{i};
    Ppc= GCM_i.Pp.c;
    Ppc = reshape(GCM_i.Pp.c,[],1);
    dat(:,i) = Ppc;
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
    Ppc = data_harmonized(:, i); 
    % Ec = reshape(Ec,size(Ec));
    Ppc = sparse(Ppc);
    %Ppc = transpose(Ppc);
    GCM{i}.Pp.c = Ppc;
end

%% transpose(only 1*23 -> 23*1 sparse double data)
for i =1: 40
    GCM_i = GCM{i};
    Ppc= GCM_i.Pp.c;
    Ppc = transpose(Ppc);
    GCM{i}.Pp.c = Ppc;
end


disp(GCM);




